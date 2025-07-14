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

OF_MAINTAINER := chickendrop89

# Screen settings
OF_SCREEN_H := 2400
OF_STATUS_H := 100
OF_STATUS_INDENT_LEFT := 48
OF_STATUS_INDENT_RIGHT := 48
OF_ALLOW_DISABLE_NAVBAR := 0
OF_CLOCK_POS := 1 # Left & Right
OF_OPTIONS_LIST_NUM := 6

# Custom ROMs / Misc
OF_DEFAULT_KEYMASTER_VERSION := 4.1
OF_NO_TREBLE_COMPATIBILITY_CHECK := 1
OF_ENABLE_ALL_PARTITION_TOOLS := 1

# Kernel supports LZ4. Use it instead of GZIP for faster boot
OF_USE_LZ4_COMPRESSION := 1

# Fixes certain storage issues
OF_UNBIND_SDCARD_F2FS := 1
OF_WIPE_METADATA_AFTER_DATAFORMAT := 1

# On MTK devices, fuel gauge doesn't work without this
OF_USE_LEGACY_BATTERY_SERVICES := 1

# Hack to get flashlight working
OF_FL_PATH1 := /system/etc/flashlight

# Doesn't work on our device
OF_NO_SPLASH_CHANGE := 1
OF_USE_GREEN_LED := 0
