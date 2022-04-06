# Custom Build script to compile LineageOS 18.1 with MicroG for Motorola Moto One Vision (codename "kane") family

## Usage
Just execute the `run-container.sh` shell script. You might want to tweak it a little bit to your needs tho.

## Features
- No GApps, MircoG is used instead
- Built upon LineageOS 18.1, providing a stable Android 11 system
- Only necessary apps are installed, zero bloat
- Uses Bromite, a privacy-enhanced chromium fork, as default WebView

## TODO
- Check if we use Enforcing builds
- Add a opt-in-per-App sandbox with firewall, which isolates data
    - Use for **Discord**, WhatsApp, etc
- Adopt the Aurora ecosystem (doesn't seem to be that well maintained atm)
    - Add AuroraStore, AuroraDroid and AuroraServices
    - Replace FDroid
    - Pre-configure repos and blocked apps (GMS)
    - See [this issue](https://gitlab.com/CalyxOS/calyxos/-/issues/705)
- Always allow screenshots
- Configure OTA updates
- Write better run script
    - Configure build properties on command line
        - Apps
    - Sort outputs by time first and device second
    - Move logs into output folder, remove need for seperate folder
    - Unify build process to adapt other devices eventually
