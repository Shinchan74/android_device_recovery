#!/bin/bash
#Sync
telegram -M "PBRP - Moto X4: Sync Device (Dependencies) Tree started"
SYNC_START=$(date +"%s")

rm -rf hardware/qcom/bootctrl/
. build/envsetup.sh
lunch omni_payton-eng
rm -rf .repo

SYNC_END=$(date +"%s")
SYNC_DIFF=$((SYNC_END - SYNC_START))
telegram -M "PBRP - Moto X4: Device Tree Sync (Dependencies) completed successfully in $((SYNC_DIFF / 60)) minute(s) and $((SYNC_DIFF % 60)) seconds"

# Build
telegram -M "PBRP - Moto X4: Building Recovery started"
SYNC_START=$(date +"%s")

export ALLOW_MISSING_DEPENDENCIES=true
export LC_ALL=C
make -j4 recoveryimage

SYNC_END=$(date +"%s")
SYNC_DIFF=$((SYNC_END - SYNC_START))
telegram -M "PBRP - Moto X4: Building completed successfully in $((SYNC_DIFF / 60)) minute(s) and $((SYNC_DIFF % 60)) seconds"

# Output
telegram -f out/target/product/payton/recovery.img "[PBRP Recovery] [Unofficial] - Moto X4"
