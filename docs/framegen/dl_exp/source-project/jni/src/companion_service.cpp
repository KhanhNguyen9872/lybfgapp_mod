#include "companion_service.hpp"

#include <unistd.h>

#include "control_device.hpp"
#include "external_provider.hpp"
#include "module_state.hpp"
#include "project_config.hpp"
#include "wire_protocol.hpp"

namespace reconstructed::companion {

void handle_request(int client_socket) {
    RuntimeState &state = runtime_state();
    state.companion_requests.fetch_add(1, std::memory_order_relaxed);

    provider::ensure_loaded();
    control::probe();

    const protocol::StatusPacket response = {
        config::kWireMagic,
        config::kWireVersion,
        state.provider_attempted.load(std::memory_order_acquire),
        provider::is_loaded() ? 1u : 0u,
        control::ioctl_succeeded() ? 1u : 0u,
    };
    (void)protocol::write_all(client_socket, &response, sizeof(response));
    protocol::drain_request(client_socket);
    close(client_socket);
}

}  // namespace reconstructed::companion
