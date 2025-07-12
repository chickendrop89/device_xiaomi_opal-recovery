#!/usr/bin/env bash
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

export TARGET_DEVICE_ALT="opal"

# Binaries & Tools
export FOX_USE_BASH_SHELL=1
export FOX_USE_TAR_BINARY=1
export FOX_USE_SED_BINARY=1
export FOX_USE_XZ_UTILS=1

# OrangeFox Addons
export FOX_ENABLE_APP_MANAGER=1
export FOX_DELETE_AROMAFM=1

# A/B partitioning
export FOX_VIRTUAL_AB_DEVICE=1
export FOX_RECOVERY_SYSTEM_PARTITION="/dev/block/mapper/system"
export FOX_RECOVERY_VENDOR_PARTITION="/dev/block/mapper/vendor"
export FOX_RECOVERY_BOOT_PARTITION="/dev/block/platform/bootdevice/by-name/boot"

# Use latest "magiskboot" binaries as this is a relatively new device
export FOX_USE_UPDATED_MAGISKBOOT=1

# CCACHE
export USE_CCACHE=1
export CCACHE_EXEC="/usr/bin/ccache"
export CCACHE_MAXSIZE="32G"
export LC_ALL="C"

# Debugging
## export FOX_RESET_SETTINGS=0
## export FOX_INSTALLER_DEBUG_MODE=1
