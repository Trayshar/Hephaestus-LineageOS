# !/bin/bash

echo $pwd
ls -la

echo ">> [$(date)] [begin] Deleting msm8916 audio, media and display driver"
rm -rf hardware/qcom-caf/msm8916/display && rm -rf hardware/qcom-caf/msm8916/media && rm -rf hardware/qcom-caf/msm8916/audio
 
ls -la hardware/qcom-caf/msm8916
