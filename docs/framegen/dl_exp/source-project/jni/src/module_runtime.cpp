#include "module_runtime.hpp"

#include <sys/socket.h>
#include <unistd.h>

#include "external_provider.hpp"
#include "module_state.hpp"
#include "project_config.hpp"
#include "wire_protocol.hpp"

namespace reconstructed {

void Module::onLoad(zygisk::Api *api, JNIEnv *env) {
    RuntimeState &state = runtime_state();
    state.api = api;
    state.env = env;
    provider::ensure_loaded();
    log_debug("onLoad");
}

void Module::preAppSpecialize(zygisk::AppSpecializeArgs *args) {
    record_process(args == nullptr ? nullptr : args->nice_name);
    request_companion();
}

void Module::postAppSpecialize(const zygisk::AppSpecializeArgs *) {
    log_debug("postAppSpecialize");
}

void Module::preServerSpecialize(zygisk::ServerSpecializeArgs *) {
    record_process(nullptr);
    request_companion();
}

void Module::postServerSpecialize(const zygisk::ServerSpecializeArgs *) {
    log_debug("postServerSpecialize");
}

void Module::record_process(jstring process_name) {
    log_process_name(runtime_state().env, process_name);
}

void Module::request_companion() {
    RuntimeState &state = runtime_state();
    if (state.api == nullptr) {
        return;
    }

    const int client_socket = state.api->connectCompanion();
    if (client_socket < 0) {
        return;
    }

    const protocol::StatusPacket request = {
        config::kWireMagic,
        config::kWireVersion,
        1,
        0,
        0,
    };
    (void)protocol::write_all(client_socket, &request, sizeof(request));

    protocol::StatusPacket response = {};
    (void)protocol::read_packet(client_socket, &response);
    close(client_socket);
}

}  // namespace reconstructed
