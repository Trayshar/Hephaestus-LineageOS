#!/bin/bash

# This script resets the Updater app if it doesn't work

if [ "`adb get-state 2>/dev/null`" != "device" ]; then
    echo "No device found. Waiting for one..."
    adb wait-for-device
fi
if ! adb root; then
    echo "Abort: Could not run adbd as root"
    exit 1
fi

echo "Deleting old updates"
adb shell rm /data/lineageos_updates/*.zip
adb shell "sqlite3 /data/data/org.lineageos.updater/databases/updates.db \"DELETE from updates\""

# If the OTA update server is unreachable, local updates won't be visible. This adds a cached, empty response, so update requests are delayed and local changes are processed.
echo "Uploading empty update response"
adb shell "printf '{\"response\":[]}\n' > /data/user/0/org.lineageos.updater/cache/updates.json"

# Exit root mode
adb unroot 
echo "Done."
