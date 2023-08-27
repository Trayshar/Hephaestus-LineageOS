#!/bin/bash
die () {
  echo ">> [$(date)] [pre-build] Error: $@"
  exit 1
}

codename="$1"

echo ">> [$(date)] [pre-build] Applying patches for $codename"
for file in /root/userscripts/patches/"$codename"/*.patch; do
    if [ -f "$file" ]; then 
        echo ">> [$(date)] [pre-build] Applying $(basename $file)"
        # TODO: Better error handeling; Maybe use a git patch command?
        patch --quiet --force -p1 -i "$file" || die "Failed to apply patch $file"
    fi 
done 
