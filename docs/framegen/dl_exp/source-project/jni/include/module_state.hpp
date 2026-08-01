#pragma once

#include <atomic>
#include <cstdint>
#include <sys/types.h>

#include "zygisk.hpp"

namespace reconstructed {

struct RuntimeState {
    zygisk::Api *api = nullptr;
    JNIEnv *env = nullptr;
    void *hook_library = nullptr;
    void *hook_symbol = nullptr;
    std::atomic<uint32_t> provider_attempted{0};
    std::atomic<uint32_t> control_ioctl_succeeded{0};
    std::atomic<uint32_t> companion_requests{0};
};

RuntimeState &runtime_state();
void log_debug(const char *message);
void log_process_name(JNIEnv *env, jstring process_name);

}  // namespace reconstructed
