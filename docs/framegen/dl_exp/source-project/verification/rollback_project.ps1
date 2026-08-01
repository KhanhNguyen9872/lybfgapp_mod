$ErrorActionPreference = 'Stop'

$project = Split-Path -Parent $PSScriptRoot
$baseline = Join-Path $project 'verification\baseline\arm64-v8a.so'
$target = Join-Path $project 'package\zygisk\arm64-v8a.so'

if (-not (Test-Path -LiteralPath $baseline)) {
    throw "Baseline artifact not found: $baseline"
}

New-Item -ItemType Directory -Force -Path (Split-Path -Parent $target) | Out-Null
Copy-Item -LiteralPath $baseline -Destination $target -Force
$hash = (Get-FileHash -Algorithm SHA256 -LiteralPath $target).Hash.ToLowerInvariant()
@(
    "BASELINE=$baseline"
    "RESTORED=$target"
    "SHA256=$hash"
    "STATUS=ROLLBACK_OK"
) | Set-Content -LiteralPath (Join-Path $PSScriptRoot 'rollback_record.txt') -Encoding utf8
Write-Output "ROLLBACK_OK $hash"
