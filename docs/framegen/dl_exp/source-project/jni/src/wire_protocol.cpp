#include "wire_protocol.hpp"

#include <cerrno>
#include <poll.h>
#include <sys/socket.h>
#include <unistd.h>

#include "project_config.hpp"

namespace reconstructed::protocol {

bool write_all(int socket_fd, const void *data, std::size_t size) {
    const auto *cursor = static_cast<const unsigned char *>(data);
    while (size != 0) {
        const ssize_t written = send(socket_fd, cursor, size, MSG_NOSIGNAL);
        if (written <= 0) {
            if (errno == EINTR) {
                continue;
            }
            return false;
        }
        cursor += written;
        size -= static_cast<std::size_t>(written);
    }
    return true;
}

bool read_packet(int socket_fd, StatusPacket *packet) {
    if (packet == nullptr) {
        return false;
    }

    auto *cursor = reinterpret_cast<unsigned char *>(packet);
    std::size_t remaining = sizeof(*packet);
    while (remaining != 0) {
        const ssize_t received = recv(socket_fd, cursor, remaining, 0);
        if (received == 0) {
            return false;
        }
        if (received < 0) {
            if (errno == EINTR) {
                continue;
            }
            return false;
        }
        cursor += received;
        remaining -= static_cast<std::size_t>(received);
    }
    return true;
}

void drain_request(int socket_fd) {
    pollfd descriptor = {socket_fd, POLLIN, 0};
    if (poll(&descriptor, 1, static_cast<int>(config::kCompanionReadTimeoutMs)) <= 0) {
        return;
    }

    unsigned char request[sizeof(StatusPacket)] = {};
    (void)recv(socket_fd, request, sizeof(request), MSG_DONTWAIT);
}

}  // namespace reconstructed::protocol
