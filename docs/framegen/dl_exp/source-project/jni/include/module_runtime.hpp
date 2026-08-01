#pragma once

#include <sys/types.h>

#include "zygisk.hpp"

namespace reconstructed {

class Module final : public zygisk::ModuleBase {
public:
    void onLoad(zygisk::Api *api, JNIEnv *env) override;
    void preAppSpecialize(zygisk::AppSpecializeArgs *args) override;
    void postAppSpecialize(const zygisk::AppSpecializeArgs *args) override;
    void preServerSpecialize(zygisk::ServerSpecializeArgs *args) override;
    void postServerSpecialize(const zygisk::ServerSpecializeArgs *args) override;

private:
    void record_process(jstring process_name);
    void request_companion();
};

}  // namespace reconstructed
