#!/bin/bash

echo ">> [$(date)] [before] Patching in custom f-droid repositories"
cd vendor/partner_gms/additional_repos.xml
patch --quiet --force -p1 -i "/root/userscripts/patches/additional_repos.xml.patch"
