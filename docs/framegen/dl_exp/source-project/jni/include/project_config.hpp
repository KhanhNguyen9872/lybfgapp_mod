#pragma once

#include <cstdint>

namespace reconstructed::config {

inline constexpr char kLogTag[] = "lybfghook-reconstructed";
inline constexpr char kExternalHookLibrary[] = "liblybfghook.so";
inline constexpr char kPrimaryHookSymbol[] = "FunctionInlineHookRouting";
inline constexpr char kFallbackHookSymbol[] = "FunctionInlineHook";
inline constexpr char kControlDevice[] = "/dev/lybfghook";

inline constexpr uint32_t kWireMagic = 0x4b484746;
inline constexpr uint32_t kWireVersion = 1;
inline constexpr unsigned kCompanionReadTimeoutMs = 250;
inline constexpr unsigned long kControlIoctl = 0xc0180902UL;
inline constexpr unsigned kControlRequestBytes = 0x100;

}  // namespace reconstructed::config
