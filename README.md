# Custom Build script to compile LineageOS 20.0 with MicroG for Motorola Moto One Vision (codename "kane")

## Usage
Just execute the `run-container.sh` shell script. You might want to tweak it a little bit to your needs tho.

If you want to update your image, connect your device and run `push-update.sh out/<your-file>.zip`. Make sure adb root is unlocked on your device.

## Features
- No GApps, MircoG is used instead
- Built upon LineageOS 20.0, providing a stable Android 13 system
- Uses Bromite, a privacy-enhanced chromium fork, as default WebView and Browser

## Known issues
- AudioFX is not working. Maybe related to my using `Soundcore Space A40` earphones which have their own companion app
- Default lineageos apps are shipped
- Hotspots dont work sometimes
- BT audio still crashes if sound is played while a wifi connection is established
- Fingerprint sensor doesn't store fingerprints and is completely broken after a couple of restarts

## TODO
- Investigate suspicious blobs in `vendor/motorola/exynos9610-common/`
- Add a opt-in-per-App sandbox with firewall, which isolates data
    - Use for **Discord**, WhatsApp, etc
- Always allow screenshots (See [this commit](https://github.com/VarunS2002/Xposed-Disable-FLAG_SECURE/blob/main/app/src/main/java/com/varuns2002/disable_flag_secure/DisableFlagSecure.kt))
- Write better run script
    - Configure build properties on command line
        - Apps
    - Sort outputs by time first and device second
    - Move logs into output folder, remove need for seperate folder
    - Unify build process to adapt other devices eventually
- Switch WebView to Mull
- Always allow rotation of screen
- Lower step size of audio volume change
- Cancel bluetooth connecting in GUI
- Allow zip-ing files in file manager (without copying them into a folder first)
- Fix open issues in LineageOS upstream repo
- Enhance fingerprinting resitance/configure User Agent
