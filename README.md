# Fire Autotools (Beta)
**Only tested on Fire HD 8 (2016), use at your own risk.**

I am not responsible for bricked devices, dead SD cards, thermonuclear war, or you getting fired because the alarm app failed. Please do some research if you have any concerns about features included in this script BEFORE using it! YOU are choosing to make these modifications, and if you point the finger at me for messing up your device, I will laugh at you.

## Goals
* Easy Sideloading & Recovery
* Obtain Root
* Block all Amazon apps and services from spying.
* Disable Amazon Bloat to minimize CPU usage, memory usage, and disk space.
* Use Open Source alternatives when available.
* Install Xposed Framework.

## Quick Usage Guide
Fire Autotools assumes you have ADB installed already.

To install ADB on Arch Linux: ```sudo pacman -S android-tools```

Make script executable: ```chmod +x ./fireAutotools.sh```

Run: ```./fireAutotools.sh```

## File Overview
```
.
├── apks
|   ├── autotools_readme.txt
|   └── *.apk
├── image
|   ├── autotools_readme.txt
|   └── update-kindle-*.bin
├── other
|   └── hosts
├── rooting
|   ├── arm64
|   |   ├── libsupol.so
|   |   ├── mtk-su
|   |   ├── su
|   |   └── supolicy
|   ├── autotools_readme.txt
|   ├── install.sh
|   └── readme.txt
├── fireAutotools.sh
└── README.md
```

## Workarounds
### Unable to set Time Zone
Sometimes you may be unable to change the timezone in the settings. We can do it manually with ADB.

```adb shell su -c setprop persist.sys.timezone "America/Los_Angeles"```

Reboot. See this page for a list of timezones: https://en.wikipedia.org/wiki/List_of_tz_database_time_zones

### Unable to use Widgets
Widgets are unfunctional, here's the fix:

```adb shell appwidget grantbind --package com.launcher.name --user 0 ```

Replace "com.launcher.name" with the name of your launcher.