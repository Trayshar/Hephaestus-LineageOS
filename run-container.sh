#!/bin/bash
die () {
  echo ">> [$(date)] Error: $@"
  exit 1
}

# Exit if user scripts are not executable
for file in scripts/*.sh; do 
    if [[ -f "$file" && ! -x "$file" ]]; then 
        die "Script $file is not executable!"
    fi 
done 

# TODO: Reorganize this with submodules
DOCKERFILE_DIR="$HOME/Dev/Android/docker-lineage-cicd"
BUILD_DIR="/media/SSDII/AndroidBuild/"
CONFIG_DIR="$HOME/Dev/Android/J5-LineageOS18-1-MicroG"
# TODO: Query about this
CPUS=4

echo ">> [$(date)] Building docker container..."
# TODO: Remove tag and use hash instead
docker build \
    -f "$DOCKERFILE_DIR/Dockerfile" \
    -t trayshar/lineage-builder \
    "$DOCKERFILE_DIR/" || die "Failed to build docker container!"
    
# Consider changing WITH_GMS: https://github.com/lineageos4microg/docker-lineage-cicd/issues/358
echo ">> [$(date)] Running build..."
docker run \
    -e "TZ=Europe/Berlin" \
    -e "BRANCH_NAME=lineage-19.1" \
    -e "DEVICE_LIST=kane" \
    -e "SIGN_BUILDS=true" \
    -e "SIGNATURE_SPOOFING=restricted" \
    -e "WITH_GMS=true" \
    -e "INCLUDE_PROPRIETARY=true" \
    -e "ZIP_SUBDIR=false" \
    -e "RELEASE_TYPE=microG" \
    -e "CUSTOM_PACKAGES=BromiteWebView Bromite AuroraStore AuroraServices" \
    -v "$BUILD_DIR/src:/srv/src" \
    -v "$CONFIG_DIR/out:/srv/zips" \
    -v "$BUILD_DIR/logs:/srv/logs" \
    -v "$BUILD_DIR/cache:/srv/ccache" \
    -v "$CONFIG_DIR/keys:/srv/keys" \
    -v "$CONFIG_DIR/manifests:/srv/local_manifests" \
    -v "$CONFIG_DIR/scripts:/srv/userscripts" \
    -e "PARALLEL_JOBS=$CPUS" \
    --cpus="$CPUS" \
    trayshar/lineage-builder
