#include "companion_service.hpp"
#include "module_runtime.hpp"
#include "zygisk.hpp"

REGISTER_ZYGISK_MODULE(reconstructed::Module)
REGISTER_ZYGISK_COMPANION(reconstructed::companion::handle_request)
