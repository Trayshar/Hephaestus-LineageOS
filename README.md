# Custom Build script to compile LineageOS 20.0 with MicroG for Motorola Moto One Vision (codename "kane")

## Usage
Just execute `run-container.sh configuration.sh`. You can configure it by editing the `configuration.sh` file.

If you want to update your image, connect your device and run `reset-updater.sh && push-update.sh /path/to/<your-file>.zip`. Make sure adb root is unlocked on your device.

Disable packages by doing "pm disable <package_name>" in a root shell, see https://android.stackexchange.com/a/56621

## Features
- No GApps, MircoG is used instead
- Built upon LineageOS 20.0, providing a stable Android 13 system
- Uses Bromite, a privacy-enhanced chromium fork, as default WebView and Browser

## Known issues
- Default lineageos apps are shipped, I disabled them using the workaround mentioned above
- Hotspots don't work sometimes
- BT audio still crashes if sound is played while a wifi connection is established ([#5676](https://gitlab.com/LineageOS/issues/android/-/issues/5676))
- Fingerprint sensor doesn't store fingerprints and is completely broken after a couple of restarts ([#6080](https://gitlab.com/LineageOS/issues/android/-/issues/6080))

## TODO
- Investigate suspicious blobs in `vendor/motorola/exynos9610-common/`
- Add a opt-in-per-App sandbox with firewall, which isolates data
    - Use for **Discord**, WhatsApp, etc
- Always allow screenshots (See [this commit](https://github.com/VarunS2002/Xposed-Disable-FLAG_SECURE/blob/main/app/src/main/java/com/varuns2002/disable_flag_secure/DisableFlagSecure.kt))
- Switch WebView to Mull
- Always allow rotation of screen
- Lower step size of audio volume change
- Cancel ongoing bluetooth connection attempt in GUI
- Allow zip-ing files in file manager (without copying them into a folder first)
- Fix open issues in LineageOS upstream repo
- Enhance browser fingerprinting resitance/configure User Agent
