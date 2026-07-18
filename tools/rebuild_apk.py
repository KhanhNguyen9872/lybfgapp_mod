import argparse
import getpass
import os
import shutil
import subprocess
import sys
import tempfile
import zipfile
from pathlib import Path
from typing import List, Optional


REPO_ROOT = Path(__file__).resolve().parent.parent
DEFAULT_ORIGINAL = REPO_ROOT / "docs" / "framegen" / "lybfgapp_v0.5.50.apk"
DEFAULT_OUTPUT = REPO_ROOT / "docs" / "framegen" / "lybfgapp_v0.5.50_mod.apk"
DEFAULT_DEX = REPO_ROOT / "classes.dex"
TEST_KEYSTORE = (REPO_ROOT / "tools" / "test.keystore").resolve()


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Repack classes.dex, zipalign, and release-sign an APK."
    )
    parser.add_argument("--original", type=Path, default=DEFAULT_ORIGINAL)
    parser.add_argument("--dex", type=Path, default=DEFAULT_DEX)
    parser.add_argument("--output", type=Path, default=DEFAULT_OUTPUT)
    parser.add_argument("--keystore", type=Path, required=True)
    parser.add_argument("--alias", required=True)
    parser.add_argument(
        "--ks-pass-env",
        default="LYBFG_KEYSTORE_PASSWORD",
        help="Environment variable containing the keystore password.",
    )
    parser.add_argument(
        "--key-pass-env",
        default="LYBFG_KEY_PASSWORD",
        help="Environment variable containing the key password (defaults to store password).",
    )
    parser.add_argument(
        "--build-tools",
        type=Path,
        help="Android SDK build-tools directory containing zipalign and apksigner.",
    )
    return parser.parse_args()


def fail(message: str) -> None:
    print(f"error: {message}", file=sys.stderr)
    raise SystemExit(1)


def find_build_tools(explicit: Optional[Path]) -> Path:
    if explicit:
        candidates = [explicit]
    else:
        sdk_roots = [
            os.environ.get("ANDROID_SDK_ROOT"),
            os.environ.get("ANDROID_HOME"),
            str(Path.home() / "AppData" / "Local" / "Android" / "Sdk"),
        ]
        candidates = []
        for sdk_root in sdk_roots:
            if not sdk_root:
                continue
            root = Path(sdk_root) / "build-tools"
            if root.is_dir():
                candidates.extend(
                    sorted(
                        (path for path in root.iterdir() if path.is_dir()),
                        key=lambda path: tuple(
                            int(part) if part.isdigit() else 0
                            for part in path.name.replace("-", ".").split(".")
                        ),
                        reverse=True,
                    )
                )

    for candidate in candidates:
        if (candidate / "zipalign.exe").is_file() and (candidate / "apksigner.bat").is_file():
            return candidate.resolve()
    fail("Android SDK zipalign/apksigner not found; pass --build-tools.")


def run(command: List[str], *, stdin_text: Optional[str] = None) -> None:
    printable = " ".join(command)
    print(f"> {printable}")
    result = subprocess.run(command, input=stdin_text, text=True)
    if result.returncode != 0:
        fail(f"command failed with exit code {result.returncode}")


def repack(original: Path, dex: Path, unsigned: Path) -> None:
    with zipfile.ZipFile(original, "r") as source, zipfile.ZipFile(unsigned, "w") as target:
        for item in source.infolist():
            name_upper = item.filename.upper()
            is_old_signature = name_upper.startswith("META-INF/") and name_upper.endswith(
                (".SF", ".RSA", ".DSA", ".EC", "MANIFEST.MF")
            )
            if is_old_signature or item.filename == "classes.dex":
                continue
            target.writestr(item, source.read(item.filename))

        dex_info = zipfile.ZipInfo("classes.dex")
        dex_info.compress_type = zipfile.ZIP_DEFLATED
        dex_info.external_attr = 0o644 << 16
        target.writestr(dex_info, dex.read_bytes())


def get_password(env_name: str, prompt: str) -> str:
    password = os.environ.get(env_name)
    if password is None:
        password = getpass.getpass(prompt)
    if not password:
        fail(f"empty password supplied for {env_name}")
    return password


def main() -> None:
    args = parse_args()
    original = args.original.resolve()
    dex = args.dex.resolve()
    output = args.output.resolve()
    keystore = args.keystore.resolve()

    for path, label in ((original, "original APK"), (dex, "classes.dex"), (keystore, "keystore")):
        if not path.is_file():
            fail(f"{label} not found: {path}")
    if keystore == TEST_KEYSTORE or "test" in keystore.name.lower() or "debug" in keystore.name.lower():
        fail("test/debug keystores are intentionally rejected; provide a release keystore")
    if output == original:
        fail("output must not overwrite the original APK")

    build_tools = find_build_tools(args.build_tools)
    zipalign = build_tools / "zipalign.exe"
    apksigner = build_tools / "apksigner.bat"
    store_password = get_password(args.ks_pass_env, "Keystore password: ")
    key_password = os.environ.get(args.key_pass_env) or store_password

    output.parent.mkdir(parents=True, exist_ok=True)
    with tempfile.TemporaryDirectory(prefix="lybfg-apk-") as temp_dir:
        temp = Path(temp_dir)
        unsigned = temp / "unsigned.apk"
        aligned = temp / "aligned.apk"
        signed = temp / "signed.apk"

        print(f"Repacking {original.name} with {dex}")
        repack(original, dex, unsigned)
        run([str(zipalign), "-f", "-p", "4", str(unsigned), str(aligned)])
        run([str(zipalign), "-c", "4", str(aligned)])

        # Passwords are supplied over stdin so they are not exposed in the process list.
        run(
            [
                str(apksigner),
                "sign",
                "--ks",
                str(keystore),
                "--ks-key-alias",
                args.alias,
                "--ks-pass",
                "stdin",
                "--key-pass",
                "stdin",
                "--v1-signing-enabled",
                "true",
                "--v2-signing-enabled",
                "true",
                "--v3-signing-enabled",
                "true",
                "--out",
                str(signed),
                str(aligned),
            ],
            stdin_text=f"{store_password}\n{key_password}\n",
        )
        run([str(apksigner), "verify", "--verbose", "--print-certs", str(signed)])
        shutil.copy2(signed, output)

    print(f"Release-signed APK written to: {output}")


if __name__ == "__main__":
    main()
