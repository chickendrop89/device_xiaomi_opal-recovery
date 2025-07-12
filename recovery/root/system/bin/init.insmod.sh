#!/system/bin/sh

MODULES_DIR="/vendor/lib/modules/1.1"
MODULES_LOAD_FILE="${MODULES_DIR}/modules.load"

modprobe -d "$MODULES_DIR" --all="$MODULES_LOAD_FILE"

exit 0
