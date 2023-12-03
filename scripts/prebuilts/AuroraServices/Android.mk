LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := privapp-permissions-AuroraServices.xml
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_PRODUCT_ETC)/permissions
LOCAL_SRC_FILES := $(LOCAL_MODULE)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := AuroraServices
LOCAL_SRC_FILES := AuroraServices.apk
LOCAL_MODULE_CLASS := APPS
LOCAL_PRIVILEGED_MODULE := true
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_REQUIRED_MODULES := privapp-permissions-AuroraServices.xml
LOCAL_PRODUCT_MODULE := true
# Fix signature getting stripped: https://stackoverflow.com/a/71433973
LOCAL_REPLACE_PREBUILT_APK_INSTALLED := $(LOCAL_PATH)/AuroraServices.apk
include $(BUILD_PREBUILT)
