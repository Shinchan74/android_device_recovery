#!/bin/bash
#Sync
telegram -M "PBRP - Samsung A8: Sync Device (Dependencies) Tree started"
SYNC_START=$(date +"%s")

. build/envsetup.sh
lunch omni_jackpotlte-eng

SYNC_END=$(date +"%s")
SYNC_DIFF=$((SYNC_END - SYNC_START))
telegram -M "PBRP - Samsung A8: Device Tree Sync (Dependencies) completed successfully in $((SYNC_DIFF / 60)) minute(s) and $((SYNC_DIFF % 60)) seconds"

# Build
telegram -M "PBRP - Samsung A8: Building Recovery started"
SYNC_START=$(date +"%s")

export ALLOW_MISSING_DEPENDENCIES=true
export LC_ALL=C
mka recoveryimage

SYNC_END=$(date +"%s")
SYNC_DIFF=$((SYNC_END - SYNC_START))
telegram -M "Samsung A8: Building completed successfully in $((SYNC_DIFF / 60)) minute(s) and $((SYNC_DIFF % 60)) seconds"

# Output
telegram -f out/target/product/montana/PBRP-jackpotlte-3.0.0*.zip "[PBRP Recovery] [Unofficial] - Samsung A8:"
