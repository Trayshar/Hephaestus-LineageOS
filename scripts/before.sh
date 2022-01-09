#!/bin/bash

echo ">> [$(date)] [before] Patching msm8916 audio, media and display driver"
rm -rf hardware/qcom-caf/msm8916/display && rm -rf hardware/qcom-caf/msm8916/media && rm -rf hardware/qcom-caf/msm8916/audio
git clone -b lineage-18.1 https://github.com/Galaxy-J5-Unofficial-LineageOS/hardware_qcom-caf_msm8916_media hardware/qcom-caf/msm8916/media --quiet
git clone -b lineage-18.1 https://github.com/Galaxy-J5-Unofficial-LineageOS/hardware_qcom-caf_msm8916_audio hardware/qcom-caf/msm8916/audio --quiet
git clone -b lineage-18.1 https://github.com/Galaxy-J5-Unofficial-LineageOS/hardware_qcom-caf_msm8916_display hardware/qcom-caf/msm8916/display --quiet

echo ">> [$(date)] [before] Patching in custom f-droid repositories"
cd vendor/partner_gms/additional_repos.xml
patch --quiet --force -p1 -i "/root/userscripts/patches/additional_repos.xml.patch"
