#include "external_provider.hpp"

#include <dlfcn.h>

#include <atomic>

#include "module_state.hpp"
#include "project_config.hpp"

namespace reconstructed::provider {

void ensure_loaded() {
    RuntimeState &state = runtime_state();
    if (state.provider_attempted.exchange(1, std::memory_order_acq_rel) != 0) {
        return;
    }

    // The analyzed module resolves its hook provider dynamically instead of
    // recording it as a DT_NEEDED dependency.
    state.hook_library = dlopen(config::kExternalHookLibrary, RTLD_NOW | RTLD_LOCAL);
    if (state.hook_library == nullptr) {
        return;
    }

    state.hook_symbol = dlsym(state.hook_library, config::kPrimaryHookSymbol);
    if (state.hook_symbol == nullptr) {
        state.hook_symbol = dlsym(state.hook_library, config::kFallbackHookSymbol);
    }
}

bool is_loaded() {
    return runtime_state().hook_symbol != nullptr;
}

}  // namespace reconstructed::provider
