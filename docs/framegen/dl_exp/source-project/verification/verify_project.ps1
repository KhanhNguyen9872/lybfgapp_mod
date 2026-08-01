$ErrorActionPreference = 'Stop'

$project = Split-Path -Parent $PSScriptRoot
$ndk = Join-Path $env:LOCALAPPDATA 'Android\Sdk\ndk\28.2.13676358\ndk-build.cmd'
$package = Join-Path $project 'package'
$output = Join-Path $package 'zygisk\arm64-v8a.so'
$module = Join-Path $package 'module.prop'
$buildLog = Join-Path $PSScriptRoot 'build.log'
$readelf = Join-Path $env:LOCALAPPDATA 'Android\Sdk\ndk\28.2.13676358\toolchains\llvm\prebuilt\windows-x86_64\bin\llvm-readelf.exe'

if (-not (Test-Path -LiteralPath $ndk)) {
    throw "NDK not found: $ndk"
}

Push-Location $project
try {
    & $ndk NDK_PROJECT_PATH=. APP_BUILD_SCRIPT=Android.mk NDK_APPLICATION_MK=Application.mk V=0 *>&1 | Tee-Object -FilePath $buildLog
    if ($LASTEXITCODE -ne 0) {
        throw "ndk-build failed with exit code $LASTEXITCODE"
    }

    New-Item -ItemType Directory -Force -Path (Split-Path -Parent $output) | Out-Null
    Copy-Item -LiteralPath 'libs\arm64-v8a\libreconstructed_zygisk.so' -Destination $output -Force
    Copy-Item -LiteralPath (Join-Path $project 'module.prop') -Destination $module -Force

    $exports = @(& $readelf -Ws $output | Select-String 'zygisk_(module|companion)_entry')
    if ($exports.Count -ne 2) {
        throw "Expected two Zygisk entry exports, found $($exports.Count)"
    }

    $sourceFiles = Get-ChildItem -LiteralPath (Join-Path $project 'jni') -Recurse -File |
        Where-Object { $_.Extension -in '.cpp', '.hpp' }
    $obfuscatedMatches = @($sourceFiles | Select-String -Pattern 'FUN_|DAT_|UNK_|PTR_|param_|local_[0-9A-Fa-f]+|LAB_' -AllMatches)
    if ($obfuscatedMatches.Count -ne 0) {
        throw "Generated identifiers remain in the human project"
    }

    $indexRows = (Get-Content -LiteralPath (Join-Path $project 'analysis\source_index.csv')).Count - 1

    $hash = (Get-FileHash -Algorithm SHA256 -LiteralPath $output).Hash.ToLowerInvariant()
    $size = (Get-Item -LiteralPath $output).Length
    @(
        "PROJECT=$project"
        "OUTPUT=$output"
        "SIZE=$size"
        "SHA256=$hash"
        "EXPORTS=2"
        "SOURCE_FILES=$($sourceFiles.Count)"
        "OBFUSCATED_MATCHES=$($obfuscatedMatches.Count)"
        "INDEX_ROWS=$indexRows"
        "STATUS=OK"
    ) | Set-Content -LiteralPath (Join-Path $PSScriptRoot 'verification.txt') -Encoding utf8
}
finally {
    Pop-Location
}
