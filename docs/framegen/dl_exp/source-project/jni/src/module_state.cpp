#include "module_state.hpp"

#include <android/log.h>

#include "project_config.hpp"

namespace reconstructed {

RuntimeState &runtime_state() {
    static RuntimeState state;
    return state;
}

void log_debug(const char *message) {
    __android_log_write(ANDROID_LOG_DEBUG, config::kLogTag, message);
}

void log_process_name(JNIEnv *env, jstring process_name) {
    if (env == nullptr || process_name == nullptr) {
        return;
    }

    const char *name = env->GetStringUTFChars(process_name, nullptr);
    if (name != nullptr) {
        __android_log_print(ANDROID_LOG_DEBUG, config::kLogTag, "process=%s", name);
        env->ReleaseStringUTFChars(process_name, name);
    }
}

}  // namespace reconstructed
