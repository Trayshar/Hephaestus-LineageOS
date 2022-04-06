#!/bin/bash

echo ">> [$(date)] Building docker container..."
docker build \
    -f $HOME/Dev/Android/docker-lineage-cicd/Dockerfile \
    -t trayshar/lineage-builder \
    $HOME/Dev/Android/docker-lineage-cicd/

BUILD_DIR="/media/SSDII/AndroidBuild/"
CONFIG_DIR="$HOME/Dev/Android/J5-LineageOS18-1-MicroG"
    
echo ">> [$(date)] Running build..."
docker run \
    -e "TZ=Europe/Berlin" \
    -e "BRANCH_NAME=lineage-18.1" \
    -e "DEVICE_LIST=kane" \
    -e "SIGN_BUILDS=true" \
    -e "SIGNATURE_SPOOFING=restricted" \
    -e "WITH_GMS=true" \
    -e "INCLUDE_PROPRIETARY=true" \
    -e "RELEASE_TYPE=$(date +"%H%M")-UNOFFICIAL-MicroG" \
    -e "CUSTOM_PACKAGES=BromiteWebView" \
    -v "$BUILD_DIR/src:/srv/src" \
    -v "$CONFIG_DIR/out:/srv/zips" \
    -v "$BUILD_DIR/logs:/srv/logs" \
    -v "$BUILD_DIR/cache:/srv/ccache" \
    -v "$CONFIG_DIR/keys:/srv/keys" \
    -v "$CONFIG_DIR/manifests:/srv/local_manifests" \
    -v "$CONFIG_DIR/scripts:/srv/userscripts" \
    -v "$CONFIG_DIR/prebuilts:/srv/prebuilts" \
    -e "PARALLEL_JOBS=6" \
    --cpus="6" \
    trayshar/lineage-builder
