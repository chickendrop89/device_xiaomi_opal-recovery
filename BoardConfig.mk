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

DEVICE_PATH := device/xiaomi/opal
PREBUILT_PATH := $(DEVICE_PATH)/prebuilt

# Architecture
TARGET_ARCH         := arm64
TARGET_ARCH_VARIANT := armv8-2a-dotprod
TARGET_CPU_ABI      := arm64-v8a
TARGET_CPU_ABI2     :=
TARGET_CPU_VARIANT  := cortex-a76
TARGET_CPU_VARIANT_RUNTIME := cortex-a76

TARGET_2ND_ARCH         := arm
TARGET_2ND_ARCH_VARIANT := armv8-2a
TARGET_2ND_CPU_ABI      := armeabi-v7a
TARGET_2ND_CPU_ABI2     := armeabi
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a55

# Bootloader
TARGET_USES_UEFI       := true
BOARD_HAS_MTK_HARDWARE := true

# Platform
TARGET_BOARD_PLATFORM      := mt6833
TARGET_BOARD_PLATFORM_GPU  := mali-g57
TARGET_BOOTLOADER_BOARD_NAME  := opal

ENABLE_CPUSETS    := true
ENABLE_SCHEDBOOST := true

# Kernel
BOARD_BOOT_HEADER_VERSION := 2
BOARD_KERNEL_BASE        := 0x40078000
BOARD_RAMDISK_OFFSET     := 0x11088000
BOARD_KERNEL_TAGS_OFFSET := 0x07c08000
BOARD_KERNEL_DTB_OFFSET  := $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_KERNEL_PAGESIZE    := 4096

TARGET_PREBUILT_KERNEL   := $(PREBUILT_PATH)/Image.gz
TARGET_PREBUILT_DTB      := $(PREBUILT_PATH)/dtb.img
TARGET_PREBUILT_DTBO     := $(PREBUILT_PATH)/dtbo.img
BOARD_PREBUILT_DTBOIMAGE := $(TARGET_PREBUILT_DTBO)

BOARD_MKBOOTIMG_ARGS += --base $(BOARD_KERNEL_BASE)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --dtb_offset $(BOARD_KERNEL_DTB_OFFSET)
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)
BOARD_MKBOOTIMG_ARGS += --pagesize $(BOARD_KERNEL_PAGESIZE)

# Kernel
BOARD_KERNEL_CMDLINE += \
	bootopt=64S3,32N2,64N2 \
    androidboot.init_fatal_reboot_target=recovery \
    androidboot.selinux=permissive

BOARD_USES_RECOVERY_AS_BOOT  := true
BOARD_HAS_RECOVERY_PARTITION := false
BOARD_INCLUDE_RECOVERY_DTBO  := true

# Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_ALGORITHM := SHA256_RSA2048
BOARD_AVB_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --set_hashtree_disabled_flag

BOARD_AVB_BOOT_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_BOOT_ALGORITHM := SHA256_RSA2048
BOARD_AVB_BOOT_ROLLBACK_INDEX := 1
BOARD_AVB_BOOT_ROLLBACK_INDEX_LOCATION := 1

BOARD_AVB_VBMETA_SYSTEM := system system_ext product
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := 1
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 2

BOARD_AVB_VBMETA_VENDOR := vendor
BOARD_AVB_VBMETA_VENDOR_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VBMETA_VENDOR_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VBMETA_VENDOR_ROLLBACK_INDEX := 1
BOARD_AVB_VBMETA_VENDOR_ROLLBACK_INDEX_LOCATION := 3

# Allow for building with minimal manifest
ALLOW_MISSING_DEPENDENCIES := true
BUILD_BROKEN_USES_NETWORK  := true
BUILD_BROKEN_DUP_RULES     := true
BUILD_BROKEN_MISSING_REQUIRED_MODULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true

# Partitions size
BOARD_FLASH_BLOCK_SIZE := 258304 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_XIAOMI_DYNAMIC_PARTITIONS_SIZE := 9122611200
BOARD_BOOTIMAGE_PARTITION_SIZE       := 134217728
BOARD_DTBOIMG_PARTITION_SIZE         := 8388608

BOARD_SUPER_PARTITION_SIZE    := 9126805504
BOARD_SUPER_PARTITION_GROUPS  := xiaomi_dynamic_partitions
BOARD_XIAOMI_DYNAMIC_PARTITIONS_PARTITION_LIST += \
    system \
    vendor \
    product \
    system_ext

BOARD_USES_METADATA_PARTITION := true
BOARD_USES_SYSTEM_EXTIMAGE := true
BOARD_USES_PRODUCTIMAGE    := true
 
BOARD_PARTITION_LIST := $(call to-upper, $(BOARD_XIAOMI_DYNAMIC_PARTITIONS_PARTITION_LIST))
$(foreach p, $(BOARD_PARTITION_LIST), $(eval BOARD_$(p)IMAGE_FILE_SYSTEM_TYPE := ext4))
$(foreach p, $(BOARD_PARTITION_LIST), $(eval TARGET_COPY_OUT_$(p) := $(call to-lower, $(p))))

# File systems
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
TARGET_USES_MKE2FS         := true

# Recovery
TARGET_SYSTEM_PROP := \
    $(DEVICE_PATH)/system.prop

TARGET_RECOVERY_FSTAB := \
    $(DEVICE_PATH)/recovery/root/system/etc/recovery.fstab

TARGET_BOARD_INFO_FILE := \
    $(DEVICE_PATH)/board-info.txt

TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"
