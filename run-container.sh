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

# Reading configuration for this build run
[ "$#" -eq 1 ] || die "Expected path to the configuration file, got $#"
source "$1" || die "Coud not load configuration!"
echo ">> [$(date)] Configuration: Build $BRANCH_NAME-$RELEASE_NAME for \"$DEVICE_LIST\""
echo ">> [$(date)] Configuration: Included packages: \"$CUSTOM_PACKAGES\""

# Create required folders if they do not already exist
mkdir -p "$ARTIFACTS_DIR/out"
mkdir -p "$ARTIFACTS_DIR/logs"
mkdir -p "$BUILD_DIR/src"
mkdir -p "$BUILD_DIR/cache"

echo ">> [$(date)] Building docker container..."
container_id=$(docker build -q -f "docker-lineage-cicd/Dockerfile" "docker-lineage-cicd/")
if [ $? -ne 0 ]; then
    # Call docker build again without '-q' so I can see the error
    docker build -f "docker-lineage-cicd/Dockerfile" "docker-lineage-cicd/"
    die "Failed to build docker container!"
fi

# Generate filename for next run, see https://superuser.com/a/924453
# This argument makes sure the date stays consistent if we compile at midnight, and to ensure each build gets it's own logfile
log_path="$ARTIFACTS_DIR/logs/repo"
log_name=$(date +%Y%m%d)
i=0
while [[ -e $log_path-$log_name-$i.log ]] ; do
    let i++
done
log_name=$log_name-$i

# TODO: Consider changing WITH_GMS: https://github.com/lineageos4microg/docker-lineage-cicd/issues/358
echo ">> [$(date)] Running build..."
docker run --rm \
    -v "/etc/localtime:/etc/localtime:ro" \
    -e "BUILD_IDENTIFIER=$log_name" \
    -e "PRINT_LOGFILE_PATHS=true" \
    -e "ZIP_SUBDIR=artifacts" \
    -e "LOGS_SUBDIR=codename" \
    -e "BRANCH_NAME=$BRANCH_NAME" \
    -e "DEVICE_LIST=$DEVICE_LIST" \
    -e "SIGN_BUILDS=true" \
    -e "SIGNATURE_SPOOFING=restricted" \
    -e "WITH_GMS=true" \
    -e "INCLUDE_PROPRIETARY=true" \
    -e "RELEASE_TYPE=$RELEASE_NAME" \
    -e "CUSTOM_PACKAGES=$CUSTOM_PACKAGES" \
    -v "$ARTIFACTS_DIR/out:/srv/zips" \
    -v "$ARTIFACTS_DIR/logs:/srv/logs" \
    -v "$BUILD_DIR/src:/srv/src" \
    -v "$BUILD_DIR/cache:/srv/ccache" \
    -v "$KEYS_DIR:/srv/keys" \
    -v "$PWD/manifests:/srv/local_manifests" \
    -v "$PWD/scripts:/srv/userscripts" \
    -e "PARALLEL_JOBS=$CPUS" \
    --cpus="$CPUS" \
    $container_id
