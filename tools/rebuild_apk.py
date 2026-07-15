import zipfile
import subprocess
import os
import sys

REPO_ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
TOOLS_DIR = os.path.dirname(__file__)

original_apk = os.path.join(REPO_ROOT, r"docs\framegen\lybfgapp_v0.5.50.apk")
modded_apk   = os.path.join(REPO_ROOT, r"docs\framegen\lybfgapp_v0.5.50_mod.apk")
new_dex      = os.path.join(REPO_ROOT, "classes.dex")
keystore     = os.path.join(TOOLS_DIR, "test.keystore")

print(f"Reading original APK: {original_apk}")
# Open original APK and write to modded APK, skipping original signature files and old classes.dex
with zipfile.ZipFile(original_apk, 'r') as yin:
    with zipfile.ZipFile(modded_apk, 'w', zipfile.ZIP_DEFLATED) as yout:
        for item in yin.infolist():
            filename = item.filename
            # Skip signature files in META-INF/ and the old classes.dex
            if filename.startswith("META-INF/") and (filename.endswith(".SF") or filename.endswith(".RSA") or filename.endswith(".MF")):
                print(f"Skipping signature file: {filename}")
                continue
            if filename == "classes.dex":
                print("Skipping old classes.dex")
                continue

            # Copy other files
            data = yin.read(filename)
            yout.writestr(item, data)

        # Write our new classes.dex
        print(f"Adding new classes.dex from {new_dex}")
        with open(new_dex, "rb") as f:
            yout.writestr("classes.dex", f.read())

print("Repackaging complete!")

# Sign APK
print("Signing APK...")
jarsigner = r"C:\Program Files\Java\jdk-17\bin\jarsigner.exe"
result = subprocess.run([
    jarsigner,
    "-keystore", keystore,
    "-storepass", "testpassword",
    "-keypass", "testpassword",
    modded_apk,
    "test"
], capture_output=True, text=True)
print(result.stdout)
if result.returncode != 0:
    print(result.stderr, file=sys.stderr)
    sys.exit(1)
print("Signing complete!")
