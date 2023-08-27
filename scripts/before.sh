#!/bin/bash
die () {
  echo ">> [$(date)] [before] Error: $@"
  exit 1
}

echo ">> [$(date)] [before] Applying patches"
for file in /root/userscripts/patches/*.patch; do 
    if [ -f "$file" ]; then 
        echo ">> [$(date)] [before] Applying $(basename $file)"
        # TODO: Better error handeling; Maybe use a git patch command?
        patch --quiet --force -p1 -i "$file" || die "Failed to apply patch $file"
    fi 
done

# TODO: Is there a way to not have a prebuilt be part of the system partition, and instead be installed normally like a user-installed app?
generate_prebuilt () {
  [ "$#" -eq 2 ] || die "Expected 2 arguments, got $#"
  local packageName="$1"
  local binaryURL="$2"
  local packagePath="packages/apps/$packageName"
  
  echo ">> [$(date)] [before] Generating prebuilt for \"$packageName\""
  rsync -ac --delete "/root/userscripts/prebuilts/$packageName/" "$packagePath" || die "Failed to copy prebuilt files for \"$packageName\""
  wget -q -O "$packagePath/$packageName.apk" "$binaryURL" || die "Failed to download binary for \"$packageName\""
}

# TODO: Read CUSTOM_PACKAGES for a list of packages, process only those. Define these urls somewhere else
echo ">> [$(date)] [before] Generating prebuilts"
generate_prebuilt Bromite "https://github.com/bromite/bromite/releases/latest/download/arm64_ChromePublic.apk"
generate_prebuilt BromiteWebView "https://github.com/bromite/bromite/releases/latest/download/arm64_SystemWebView.apk"
generate_prebuilt AuroraStore "https://auroraoss.com/AuroraStore/Stable/AuroraStore_4.3.1.apk"
generate_prebuilt AuroraServices "https://gitlab.com/AuroraOSS/AuroraServices/uploads/c22e95975571e9db143567690777a56e/AuroraServices_v1.1.1.apk"
