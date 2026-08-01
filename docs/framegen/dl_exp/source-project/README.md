# Human-readable ARM64 Zygisk reconstruction

This directory is the maintainable project view of the analyzed `arm64-v8a`
module. It keeps the recovered lifecycle and companion behavior in small,
named C++ components instead of one generated decompiler file.

## Layout

| Path | Purpose |
| --- | --- |
| `jni/include/project_config.hpp` | Constants recovered from the binary's data and call paths |
| `jni/include/wire_protocol.hpp` | The 20-byte companion request/response ABI |
| `jni/src/module_runtime.cpp` | Zygisk lifecycle callbacks and process handoff |
| `jni/src/companion_service.cpp` | Companion request handling |
| `jni/src/external_provider.cpp` | Dynamic provider loading and symbol lookup |
| `jni/src/control_device.cpp` | Control-device probe and ioctl result |
| `jni/src/wire_protocol.cpp` | Socket I/O and request draining |
| `jni/src/zygisk_entry.cpp` | The two exported Zygisk entry registrations |
| `docs/` | Architecture and evidence notes |
| `analysis/` | Coverage index and generated-name mapping |
| `verification/` | Reproducible build and package checks |

The complete decompiler source view is kept in the research bundle under
`scratch/dl_exp_arm64_reconstruct_research/full_source_generated/c/` and
`assembly/`. It is useful for address-level lookup but is not the build source
because stripped globals, types, and compiler-generated control-flow names are
not recoverable with source-level certainty.

## Build

From this directory, with the Android NDK installed:

```powershell
& "$env:LOCALAPPDATA\Android\Sdk\ndk\28.2.13676358\ndk-build.cmd" `
  NDK_PROJECT_PATH=. APP_BUILD_SCRIPT=Android.mk `
  NDK_APPLICATION_MK=Application.mk V=0
```

The installable output is written to `package/zygisk/arm64-v8a.so` by the
verification script after the shared library is built.

## Interpretation

This is a behavior-focused reconstruction, not a claim that the original
developer's source files or original variable names were recovered. Names in
this project describe observed roles: module lifecycle, companion protocol,
provider loading, and device probing.
