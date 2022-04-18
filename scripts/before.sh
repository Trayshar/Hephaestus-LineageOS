#!/bin/bash

echo ">> [$(date)] [before] Applying patches"
for file in /root/userscripts/patches/*.patch; do 
    if [ -f "$file" ]; then 
        echo ">> [$(date)] [before] Applying $(basename $file)"
        patch --quiet --force -p1 -i "$file"
    fi 
done

echo ">> [$(date)] [before] Moving prebuilts"
cp -arvu /srv/prebuilts/* packages/apps/
