#!/bin/bash
die () {
  echo ">> [$(date)] [before] Error: $@"
  exit 1
}

echo ">> [$(date)] [before] Applying patches"
for file in /root/userscripts/patches/*.patch; do 
    if [ -f "$file" ]; then 
        echo ">> [$(date)] [before] Applying $(basename $file)"
        patch --quiet --force -p1 -i "$file" || die "Failed to apply patch $file"
    fi 
done

generate_prebuilt () {
  [ "$#" -eq 2 ] || die "Expected 2 arguments, got $#"
  local packageName="$1"
  local binaryURL="$2"
  local packagePath="packages/apps/$packageName"
  
  echo ">> [$(date)] [before] Generating prebuilt for \"$packageName\""
  rsync -ac --delete "/root/userscripts/prebuilts/$packageName/" "$packagePath" || die "Failed to copy prebuilt files for \"$packageName\""
  wget -q -O "$packagePath/$packageName.apk" "$binaryURL" || die "Failed to download binary for \"$packageName\""
}

echo ">> [$(date)] [before] Generating prebuilts"
generate_prebuilt Bromite "https://github.com/bromite/bromite/releases/latest/download/arm64_ChromePublic.apk"
generate_prebuilt BromiteWebView "https://github.com/bromite/bromite/releases/latest/download/arm64_SystemWebView.apk"
generate_prebuilt GalleryPro "https://f-droid.org/repo/com.simplemobiletools.gallery.pro_372.apk"
generate_prebuilt PdfViewerPro "https://f-droid.org/repo/com.gsnathan.pdfviewer_28.apk"
generate_prebuilt K9Mail "https://f-droid.org/repo/com.fsck.k9_32000.apk"
generate_prebuilt NewPipe "https://github.com/TeamNewPipe/NewPipe/releases/download/v0.23.1/NewPipe_v0.23.1.apk"
generate_prebuilt AuroraStore "https://gitlab.com/AuroraOSS/AuroraStore/uploads/bbc1bd5a77ab2b40bbf288ccbef8d1f0/AuroraStore_4.1.1.apk"
generate_prebuilt AuroraServices "https://gitlab.com/AuroraOSS/AuroraServices/uploads/c22e95975571e9db143567690777a56e/AuroraServices_v1.1.1.apk"
