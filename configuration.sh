#!/bin/bash

# Absolute paths to the directories used to store the source code, keys and artifacts
BUILD_DIR="$HOME/Dev/.build/Android"
ARTIFACTS_DIR="$HOME/Dev/.build/Android"
KEYS_DIR="$PWD/keys"
# Configure how many CPU cores can be used by the compiler
CPUS=12

# LineageOS version, device list and release name
BRANCH_NAME="lineage-20.0"
DEVICE_LIST="kane"
RELEASE_NAME="microG"
# Add packages to the system partition. Requires them to be set up correctly, see scripts/prebuilts
CUSTOM_PACKAGES="AuroraStore AuroraServices"
