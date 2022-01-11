#!/bin/bash

echo ">> [$(date)] [before] Patching in custom f-droid repositories"
cd vendor/partner_gms/additional_repos.xml
patch --quiet --force -p1 -i "/root/userscripts/patches/additional_repos.xml.patch"

cd ..
cd ..

echo ">> [$(date)] [before] Removing GalleryGo and Lawnchair"
cd samsung/msm8916-common
patch --quiet --force -p1 -i "/root/userscripts/patches/msm8916-common-vendor.mk.patch"
