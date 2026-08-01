LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := reconstructed_zygisk
LOCAL_SRC_FILES := \
    jni/src/companion_service.cpp \
    jni/src/control_device.cpp \
    jni/src/external_provider.cpp \
    jni/src/module_runtime.cpp \
    jni/src/module_state.cpp \
    jni/src/wire_protocol.cpp \
    jni/src/zygisk_entry.cpp
LOCAL_C_INCLUDES := $(LOCAL_PATH)/jni $(LOCAL_PATH)/jni/include
LOCAL_CPPFLAGS := -std=c++17 -fno-exceptions -fno-rtti -fvisibility=hidden -fvisibility-inlines-hidden
LOCAL_LDLIBS := -llog -lGLESv3 -lGLESv2 -lEGL -lm -ldl
include $(BUILD_SHARED_LIBRARY)
