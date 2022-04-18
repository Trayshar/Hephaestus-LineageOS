# Custom Build script to compile LineageOS 18.1 with MicroG for Motorola Moto One Vision (codename "kane")

## Usage
Just execute the `run-container.sh` shell script. You might want to tweak it a little bit to your needs tho.

## Features
- No GApps, MircoG is used instead
- Built upon LineageOS 18.1, providing a stable Android 11 system
- Uses Bromite, a privacy-enhanced chromium fork, as default WebView and Browser

## Known issues
- No audio in calls over bluetooth headset ([#4584](https://gitlab.com/LineageOS/issues/android/-/issues/4584))

## TODO
- Use `tee` in repo-sync and build script so `run-container` shows whats going on
- Use `rsync` instead of copy for prebuilts
- Do not ship prebuilts in this repo, but write a short download script for them
- Add GrapheneOs Camera by default
- Auto-update apps when building
- Investigate suspicious blobs in `vendor/motorola/exynos9610-common/`
- Add a opt-in-per-App sandbox with firewall, which isolates data
    - Use for **Discord**, WhatsApp, etc
- Adopt the Aurora ecosystem (doesn't seem to be that well maintained atm)
    - Add AuroraStore, AuroraDroid and AuroraServices
    - Remove FDroid
    - Pre-configure repos and blocked apps (MicroG GMS is detected as real GMS and is promted for updates)
    - See [this issue](https://gitlab.com/CalyxOS/calyxos/-/issues/705)
- Always allow screenshots
- Configure OTA updates
- Write better run script
    - Configure build properties on command line
        - Apps
    - Sort outputs by time first and device second
    - Move logs into output folder, remove need for seperate folder
    - Unify build process to adapt other devices eventually
