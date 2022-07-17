LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := K9Mail
LOCAL_SRC_FILES := K9Mail.apk
LOCAL_MODULE_CLASS := APPS
LOCAL_OPTIONAL_USES_LIBRARIES := com.sec.android.app.multiwindow androidx.window.extensions androidx.window.sidecar
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_CERTIFICATE := PRESIGNED
include $(BUILD_PREBUILT)
