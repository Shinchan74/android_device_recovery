#!/bin/bash
# Sync
telegram -M "PBRP - Samsung A8+: Sync started"
SYNC_START=$(date +"%s")

sudo -E apt-get -qq update
sudo -E apt-get -qq install bc zip libstdc++6 python gcc clang libssl-dev repo flex aria2
sudo apt-get install default-jdk android-tools-adb bison build-essential curl flex g++-multilib gcc-multilib gnupg gperf imagemagick lib32readline-dev lib32z1-dev liblz4-tool libssl-dev libwxgtk3.0-dev libxml2 libxml2-utils lzop pngcrush yasm zlib1g-dev python3 python3-dev kernel-package bzip2 g++-multilib gcc-multilib make git libfdt-dev ccache flex g++-multilib gcc-multilib gnupg gperf imagemagick lib32ncurses5-dev libsdl1.2-dev libssl-dev rsync schedtool squashfs-tools xsltproc openjdk-8-jdk repo byacc m4 libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev python3-pip
sudo curl --create-dirs -L -o /usr/local/bin/repo -O -L https://storage.googleapis.com/git-repo-downloads/repo
sudo chmod a+rx /usr/local/bin/repo

repo init --depth=1 -u git://github.com/PitchBlackRecoveryProject/manifest_pb.git -b android-9.0
repo sync
git clone https://github.com/YuMi-Project/android_device_samsung_jackpot2lte -b pbrp-9.0 device/samsung/jackpot2lte

SYNC_END=$(date +"%s")
SYNC_DIFF=$((SYNC_END - SYNC_START))
telegram -M "PBRP - Samsung A8+: Sync completed successfully in $((SYNC_DIFF / 60)) minute(s) and $((SYNC_DIFF % 60)) seconds"
