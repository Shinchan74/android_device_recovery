#!/bin/bash

export my_dir=$(pwd)

# Build
telegram -m "OrangeFox R11.0 - Moto G (5S) Plus (sanders): Building Recovery started"
SYNC_START=$(date +"%s")

. build_ofox.sh

SYNC_END=$(date +"%s")
SYNC_DIFF=$((SYNC_END - SYNC_START))

if [ -f "${my_dir}/out/target/product/sanders/OrangeFox-R11.0*sanders.zip" ]; then
    telegram -M "OrangeFox R11.0 - Moto G (5S) Plus (sanders): Building completed successfully in $((SYNC_DIFF / 60)) minute(s) and $((SYNC_DIFF % 60)) seconds"
    telegram -f out/target/product/sanders/OrangeFox-R11.0*sanders.zip "[OrangeFox Recovery] [Unofficial] - Moto G (5S) Plus (sanders)"
else
    telegram -M "OrangeFox R11.0 - Moto G (5S) Plus (sanders): Building completed unsuccessfully in $((SYNC_DIFF / 60)) minute(s) and $((SYNC_DIFF % 60)) seconds"
fi
