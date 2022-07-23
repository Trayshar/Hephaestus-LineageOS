# Custom Build script to compile LineageOS 19.1 with MicroG for Motorola Moto One Vision (codename "kane")

## Usage
Just execute the `run-container.sh` shell script. You might want to tweak it a little bit to your needs tho.

## Features
- No GApps, MircoG is used instead
- Built upon LineageOS 19.1, providing a stable Android 12 system
- Uses Bromite, a privacy-enhanced chromium fork, as default WebView and Browser

## Known issues
- No internet over wifi hotspot ([#4657](https://gitlab.com/LineageOS/issues/android/-/issues/4657))

## TODO
- Investigate suspicious blobs in `vendor/motorola/exynos9610-common/`
- Add a opt-in-per-App sandbox with firewall, which isolates data
    - Use for **Discord**, WhatsApp, etc
- Always allow screenshots
- Write better run script
    - Configure build properties on command line
        - Apps
    - Sort outputs by time first and device second
    - Move logs into output folder, remove need for seperate folder
    - Unify build process to adapt other devices eventually
