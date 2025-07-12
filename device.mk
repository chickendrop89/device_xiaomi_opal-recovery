#  Copyright (C) 2025 chickendrop89
#   
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#   
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <https://www.gnu.org/licenses/>.

LOCAL_PATH := device/xiaomi/opal
PREBUILT_PATH := $(LOCAL_PATH)/prebuilt

# Configure Virtual A/B with compression
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/compression.mk)

# Enable updating of APEXes
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# Enable developer GSI keys
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

# Configure emulated_storage.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/recovery/root,recovery/root)

# devices
TARGET_OTA_ASSERT_DEVICE := opal

# Boot control HAL | Preloader utils
PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-service \
    android.hardware.boot@1.2-mtkimpl.recovery \
    mtk_plpath_utils.recovery

PRODUCT_PACKAGES_DEBUG += \
    bootctl

# FastbootD
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.1-impl-mock \
    fastbootd

# Contains necessary LKMs and firmware
PRODUCT_PACKAGES += \
    vendor_blobs

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
	$(LOCAL_PATH)/

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_BUILD_SUPER_PARTITION  := false

# Resolution
TARGET_SCREEN_HEIGHT  := 2400
TARGET_SCREEN_DENSITY := 399
TARGET_SCREEN_WIDTH   := 1080

# API
PRODUCT_ENFORCE_VINTF_MANIFEST := true
PRODUCT_SHIPPING_API_LEVEL  := 30
PRODUCT_TARGET_VNDK_VERSION := 31

BOARD_API_LEVEL    := $(PRODUCT_SHIPPING_API_LEVEL)
SHIPPING_API_LEVEL := $(PRODUCT_SHIPPING_API_LEVEL)
BOARD_SHIPPING_API_LEVEL := $(PRODUCT_SHIPPING_API_LEVEL)

# A/B
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += \
    vendor_boot \
    boot \
    dpm \
    dtbo \
    gz \
    lk \
    logo \
    mcupm \
    md1img \
    pi_img \
    product \
    scp \
    spmfw \
    sspm \
    system \
    system_ext \
    tee \
    vbmeta \
    vbmeta_system \
    vbmeta_vendor \
    vendor

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=ext4 \
    POSTINSTALL_OPTIONAL_vendor=true

# Update engine
PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier

PRODUCT_PACKAGES_DEBUG += \
    update_engine_client

PRODUCT_PACKAGES += \
    otapreopt_script \
    checkpoint_gc

# TWRP - Specifics
TW_THEME                := portrait_hdpi
TW_DEFAULT_LANGUAGE     := en
TW_USE_TOOLBOX          := true
TW_INCLUDE_NTFS_3G      := true
TW_INCLUDE_RESETPROP    := true
TW_INCLUDE_LIBRESETPROP := true
TW_INCLUDE_REPACKTOOLS  := true
TW_EXTRA_LANGUAGES      := true
TW_EXCLUDE_APEX         := true
TW_INCLUDE_FASTBOOTD    := true
TW_INCLUDE_PYTHON       := true
TW_NO_SCREEN_BLANK      := true # Dim the display instead of turning off
TW_NO_FASTBOOT_BOOT     := true # "fastboot boot xxx" bricks device
TW_USES_VENDOR_LIBS     := true # Stop vendor prebuilts from being overwritten
TW_EXCLUDE_TWRPAPP      := true # This isn't official build. Don't include the app
#TW_FRAMERATE           := 60  # Causes underflow errors!

# TWRP - Logging
TWRP_INCLUDE_LOGCAT     := true
TARGET_USES_LOGD        := true

# Ignore this input to prevent power button issues
TW_INPUT_BLACKLIST := "uinput-goodix" 

# USB configuration
TW_EXCLUDE_DEFAULT_USB_INIT := true
TARGET_USE_CUSTOM_LUN_FILE_PATH := \
    /config/usb_gadget/g1/functions/mass_storage.0/lun.%d/file

# Display brightness
TW_DEFAULT_BRIGHTNESS := 1200
TW_MAX_BRIGHTNESS     := 2047
TW_BRIGHTNESS_PATH    := \
    "/sys/class/leds/lcd-backlight/brightness"

# Haptics
TW_SUPPORT_INPUT_AIDL_HAPTICS := true
TW_SUPPORT_INPUT_AIDL_HAPTICS_FQNAME := \
    "IVibrator/vibratorfeature"

# TWRP - Crypto
TW_INCLUDE_CRYPTO     := true
TW_INCLUDE_CRYPTO_FBE := true
TW_INCLUDE_FBE_METADATA_DECRYPT := true

PLATFORM_VERSION := 99.87.36
PLATFORM_VERSION_LAST_STABLE := $(PLATFORM_VERSION)

PLATFORM_SECURITY_PATCH := 2127-12-31
VENDOR_SECURITY_PATCH   := $(PLATFORM_SECURITY_PATCH)
BOOT_SECURITY_PATCH     := $(PLATFORM_SECURITY_PATCH)

TARGET_RECOVERY_DEVICE_MODULES += \
    libkeymaster4 \
    libkeymaster41 \
    libpuresoftkeymasterdevice

TW_RECOVERY_ADDITIONAL_RELINK_LIBRARY_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/libkeymaster4.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libkeymaster41.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libpuresoftkeymasterdevice.so

# Xiaomi OTACert
PRODUCT_EXTRA_RECOVERY_KEYS += \
    vendor/recovery/security/miui
