#!/bin/sh
# Original file from https://raw.githubusercontent.com/LineageOS/android_packages_apps_Updater/lineage-19.1/push-update.sh
# Instructions: https://wiki.lineageos.org/devices/kane/update

updates_dir=/data/lineageos_updates

if [ ! -f "$1" ]; then
   echo "Usage: $0 ZIP [UNVERIFIED]"
   echo "Push ZIP to $updates_dir and add it to Updater"
   echo
   echo "The name of ZIP is assumed to have lineage-VERSION-DATE-TYPE-* as format"
   echo "If UNVERIFIED is set, the app will verify the update"
   exit
fi
zip_path=`realpath "$1"`

if [ "`adb get-state 2>/dev/null`" != "device" ]; then
    echo "Abort: No device found. Waiting for one..."
    adb wait-for-device
fi
if ! adb root; then
    echo "Abort: Could not run adbd as root"
    exit 1
fi

zip_path_device=$updates_dir/`basename "$zip_path"`
if adb shell test -f "$zip_path_device"; then
    echo "Abort: $zip_path_device exists already"
    exit 1
fi

if [ -n "$2" ]; then
    status=1
else
    status=2
fi

# Assume lineage-VERSION-TIME-TYPE-DEVICE.zip
zip_name=`basename "$zip_path"`
zip_name_split=(${zip_name//-/ })
id=`echo "$zip_name" | sha1sum | cut -d' ' -f1`
version=${zip_name_split[1]}
type=${zip_name_split[3]}
device=${zip_name_split[4]}
timestamp=`stat -c '%W' "$zip_path"`
size=`stat -c "%s" "$zip_path"`

echo "Will write \"$zip_name\" to your device at \"$zip_path_device\", with the following properties:"
echo "Version: $version"
echo "Type: $type"
echo "Device $device"
echo "Build time: $(date -d "@$timestamp") ($timestamp)"
read -p "Are you sure? " -n 1 -r
echo
if [[ ! $REPLY =~ ^[YyJj]$ ]]
then
    echo "Aborted."
    exit 1
fi

adb push "$zip_path" "$zip_path_device"
adb shell chgrp cache "$zip_path_device"
adb shell chmod 664 "$zip_path_device"

# Kill the app before updating the database
adb shell "killall org.lineageos.updater 2>/dev/null"
adb shell "sqlite3 /data/data/org.lineageos.updater/databases/updates.db" \
    "\"INSERT INTO updates (status, path, download_id, timestamp, type, version, size)" \
    "  VALUES ($status, '$zip_path_device', '$id', $timestamp, '$type', '$version', $size)\""

# Exit root mode
adb unroot 

echo "Done."
