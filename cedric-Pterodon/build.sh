#!/bin/bash
#Sync
telegram -M "Pterodon - Moto G5: Sync Device (Dependencies) Tree started"
SYNC_START=$(date +"%s")

. build/envsetup.sh
lunch omni_cedric-eng

SYNC_END=$(date +"%s")
SYNC_DIFF=$((SYNC_END - SYNC_START))
telegram -M "Pterodon - Moto G5: Device Tree Sync (Dependencies) completed successfully in $((SYNC_DIFF / 60)) minute(s) and $((SYNC_DIFF % 60)) seconds"

# Build
telegram -M "Pterodon - Moto G5: Building Recovery started"
SYNC_START=$(date +"%s")

export ALLOW_MISSING_DEPENDENCIES=true
export LC_ALL=C
mka recoveryimage

SYNC_END=$(date +"%s")
SYNC_DIFF=$((SYNC_END - SYNC_START))
telegram -M "Pterodon - Moto G5: Building completed successfully in $((SYNC_DIFF / 60)) minute(s) and $((SYNC_DIFF % 60)) seconds"

# Output
telegram -f out/target/product/cedric/recovery.img "[Pterodon Recovery] [Unofficial] - Moto G5"
