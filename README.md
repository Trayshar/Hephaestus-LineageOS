# Custom Build script to compile LineageOS 20.0 with MicroG

## Usage
Just execute `run-container.sh configuration.sh`. You can configure it by editing the `configuration.sh` file.

If you want to update your device, connect your device with adb root and run `reset-updater.sh && push-update.sh /path/to/<your-file>.zip`. Then, you can open the LineageOS Updater and install the update.

## Features
- Completely de-googled, [MircoG](https://microg.org) is used instead
- Built upon [LineageOS](https://lineageos.org) 20.0, providing a stable Android 13 system
- Uses [Mulch](https://divestos.org/pages/our_apps#mulch), a security-enhanced chromium fork, as default WebView
- Ships with [AuroraStore](https://gitlab.com/AuroraOSS/AuroraStore) to install apps from the PlayStore

## Devices
- Motorola Moto One Vision ("kane")
- Xiaomi Mi 9T ("davinci")

## Known issues
- Default LineageOS apps are shipped, disabled them in the app settings or by running `pm disable <package_name>` in a root shell, see [here](https://android.stackexchange.com/a/56621)
### Motorola Moto One Vision ("kane")
- Wifi Hotspot doesn't work sometimes
- BT audio crashes if sound is played while a wifi connection is established ([#5676](https://gitlab.com/LineageOS/issues/android/-/issues/5676))
- Fingerprint sensor doesn't store fingerprints and is completely broken after a couple of restarts ([#6080](https://gitlab.com/LineageOS/issues/android/-/issues/6080))
### Xiaomi Mi 9T ("davinci")
- Builds, but not yet installed...

## TODO
- Allow to pin some repositories to a commit to work around issues in upstream
- Always allow screenshots (See [this commit](https://github.com/VarunS2002/Xposed-Disable-FLAG_SECURE/blob/main/app/src/main/java/com/varuns2002/disable_flag_secure/DisableFlagSecure.kt))
- Always allow rotation of screen or adjust angle at which the button appears
- Lower step size of audio volume change if possible
- Cancel ongoing bluetooth connection attempt in GUI
- Investigate [DivestOS](https://divestos.org/index.html) as upstream OS
