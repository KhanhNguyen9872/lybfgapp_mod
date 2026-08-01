#pragma once

#include <cstddef>
#include <cstdint>

namespace reconstructed::protocol {

struct StatusPacket {
    uint32_t magic;
    uint32_t version;
    uint32_t state;
    uint32_t provider_loaded;
    uint32_t control_ioctl;
};

static_assert(sizeof(StatusPacket) == 20, "The companion packet is a 20-byte ABI");

bool write_all(int socket_fd, const void *data, std::size_t size);
bool read_packet(int socket_fd, StatusPacket *packet);
void drain_request(int socket_fd);

}  // namespace reconstructed::protocol
