#!/bin/bash

# $1 contains the current build target
cd device/samsung/$1
echo ">> [$(date)] [pre-build] Removing Gapps from device tree for $1"
patch --quiet --force -p1 -i "/root/userscripts/patches/device.mk.$1.patch"
