#!/bin/bash
# Sync
telegram -M "PBRP - Samsung A8/A8+: Sync Device (Dependencies) Tree started"
SYNC_START=$(date +"%s")

. build/envsetup.sh
lunch omni_jackpot2lte-eng
lunch omni_jackpotlte-eng

SYNC_END=$(date +"%s")
SYNC_DIFF=$((SYNC_END - SYNC_START))
telegram -M "PBRP - Samsung A8/A8+: Device Tree Sync (Dependencies) completed successfully in $((SYNC_DIFF / 60)) minute(s) and $((SYNC_DIFF % 60)) seconds"

# Save space
rm -rf .repo .git

# Build 1/3 - Initial step
telegram -M "PBRP - Samsung A8/A8+: Building Recovery started"
SYNC_START=$(date +"%s")

# Minimal flags
export ALLOW_MISSING_DEPENDENCIES=true
export LC_ALL=C

# A8+ 2/3 - jackpot2lte
lunch omni_jackpot2lte-eng
mka recoveryimage

# Move to tmp
mkdir tmp
mv out/target/product/jackpotlte/PBRP-jackpot2lte-*-*-*-UNOFFICIAL.zip tmp/

# Delete out
rm -rf out

# A8 3/3 - jackpotlte
lunch omni_jackpotlte-eng
mka recoveryimage

# Move to tmp
mv out/target/product/jackpotlte/PBRP-jackpotlte-*-*-*-UNOFFICIAL.zip tmp/

SYNC_END=$(date +"%s")
SYNC_DIFF=$((SYNC_END - SYNC_START))
telegram -M "PBRP - Samsung A8/A8+: Building completed successfully in $((SYNC_DIFF / 60)) minute(s) and $((SYNC_DIFF % 60)) seconds"

# Output
telegram -f tmp/PBRP-jackpot2lte-*-*-*-UNOFFICIAL.zip "[PBRP Recovery] [Unofficial] - Samsung A8+"
telegram -f tmp/PBRP-jackpotlte-*-*-*-UNOFFICIAL.zip "[PBRP Recovery] [Unofficial] - Samsung A8"
