# Reconstructed feature inventory

## Module lifecycle

The project implements the recovered Zygisk module callbacks:

- `onLoad`
- `preAppSpecialize`
- `postAppSpecialize`
- `preServerSpecialize`
- `postServerSpecialize`

The state object retains the API pointer, JNI environment, provider handle,
resolved provider symbol, and status counters.

## Companion protocol

`StatusPacket` has five little-endian 32-bit fields and is exactly 20 bytes:

| Field | Meaning |
| --- | --- |
| `magic` | Protocol marker `0x4b484746` |
| `version` | Protocol version `1` |
| `state` | Provider-load attempt has been made |
| `provider_loaded` | One of the recovered provider symbols resolved |
| `control_ioctl` | The control ioctl returned success |

## External provider boundary

The provider is loaded with `dlopen` and searched first for
`FunctionInlineHookRouting`, then for `FunctionInlineHook`. The symbol is
retained as an opaque pointer because the stripped binary does not provide a
reliable source-level function signature.

## Control-device boundary

The recovered path opens the control device, supplies a zeroed 0x100-byte
request area, executes the recovered ioctl value, and records whether the call
returned success.

## Confidence labels

- **High:** exported entry points, callback names, packet size, dynamic-loader
  calls, and visible constants.
- **Medium:** the relationship between the status fields and the original
  private protocol semantics.
- **Low:** exact original type names, local variable names, and stripped
  function signatures.
