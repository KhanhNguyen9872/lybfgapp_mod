#include "control_device.hpp"

#include <fcntl.h>
#include <sys/ioctl.h>
#include <unistd.h>

#include "module_state.hpp"
#include "project_config.hpp"

namespace reconstructed::control {

void probe() {
    RuntimeState &state = runtime_state();
    const int device_fd = open(config::kControlDevice, O_RDWR | O_CLOEXEC);
    if (device_fd < 0) {
        return;
    }

    alignas(8) unsigned char request[config::kControlRequestBytes] = {};
    if (ioctl(device_fd, config::kControlIoctl, request) == 0) {
        state.control_ioctl_succeeded.store(1, std::memory_order_release);
    }
    close(device_fd);
}

bool ioctl_succeeded() {
    return runtime_state().control_ioctl_succeeded.load(std::memory_order_acquire) != 0;
}

}  // namespace reconstructed::control
