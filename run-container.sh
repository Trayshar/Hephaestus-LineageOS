#!/bin/bash

echo ">> [$(date)] Building docker container..."
docker build \
    -f $HOME/Dev/Android/docker-lineage-cicd/Dockerfile \
    -t trayshar/lineage-builder \
    $HOME/Dev/Android/docker-lineage-cicd/

echo ">> [$(date)] Running build container..."
docker run \
    -e "TZ=Europe/Berlin" \
    -e "BRANCH_NAME=lineage-18.1" \
    -e "DEVICE_LIST=j5nlte" \
    -e "SIGN_BUILDS=true" \
    -e "SIGNATURE_SPOOFING=restricted" \
    -e "WITH_GMS=true" \
    -e "INCLUDE_PROPRIETARY=false" \
    -e "WITH_SU=true" \
    -e "RELEASE_TYPE=$(date +"%H%M")-UNOFFICIAL-MicroG" \
    -e "CUSTOM_PACKAGES=BromiteWebView" \
    -v "$HOME/Dev/.build/Android/J5-LineageOS18-1-MicroG/src:/srv/src" \
    -v "$HOME/Dev/Android/J5-LineageOS18-1-MicroG/out:/srv/zips" \
    -v "$HOME/Dev/.build/Android/J5-LineageOS18-1-MicroG/logs:/srv/logs" \
    -v "$HOME/Dev/.build/Android/J5-LineageOS18-1-MicroG/cache:/srv/ccache" \
    -v "$HOME/Dev/Android/J5-LineageOS18-1-MicroG/keys:/srv/keys" \
    -v "$HOME/Dev/Android/J5-LineageOS18-1-MicroG/manifests:/srv/local_manifests" \
    -v "$HOME/Dev/Android/J5-LineageOS18-1-MicroG/scripts:/srv/userscripts" \
    -e "SYNC_THREADS=4" \
    --cpus="4" \
    trayshar/lineage-builder
