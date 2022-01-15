# Custom Build script to compile LineageOS 18.1 with MicroG for Galaxy J5 device family

## Usage
Just execute the `run-container.sh` shell script. You might want to tweak it a little bit to your needs tho.

## Features
- No GApps, MircoG is used instead
- Built upon LineageOS 18.1, providing a stable Android 11 system
- Only necessary apps are installed, zero bloat
- Currently only supports permissive builds, so no SELinux protection
- Uses Bromite, a privacy-enhanced chromium fork, as default WebView

## TODO
- Enable Enforcing builds
- Add a opt-in-per-App sandbox with firewall, which isolates data
    - Use for GCam, **Discord**, WhatsApp, etc
- Add Aurora and give it the root permission to update/install in the background
- Preconfigure settings
    - Disable Autocorrect
- Write better run script
    - Configure build properties on command line
    - Sort outputs by time first and device second
    - Move logs into output folder, remove need for seperate folder
    - Unify build process to adapt other devices eventually
    - Stop downloading and compiling unnecessary device trees/chipsets 
- Fix root option not working
