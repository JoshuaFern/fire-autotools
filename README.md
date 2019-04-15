# Fire Autotools (Beta)
**Only tested on Fire HD 8 (2016), use at your own risk.**

I am not responsible for bricked devices, dead SD cards, thermonuclear war, or you getting fired because the alarm app failed. Please do some research if you have any concerns about features included in this script BEFORE using it! YOU are choosing to make these modifications, and if you point the finger at me for messing up your device, I will laugh at you.

## Description

Fire Autotools is a simple bash shell script that I made for myself to automate the process of recovering and setting up my device. I have made this script publicly avalible for anyone to use, but I haven't tested it on any device but my own. The script should be fairly easy to edit and tailor for your specific device and use case.

### Features
* Stage 1: Easy Sideloading & Recovery
* Stage 2: Obtain Root, Install SuperSU
* Stage 3: Install Hosts file blocking for known Amazon domains, install AFWall+ firewall.
* Stage 4: Remove and replace Amazon apps and services to minimize CPU usage, memory usage, and disk space. Install F-Droid and Busybox.
* Stage 5: Install Xposed Framework
* Stage 6: Set Lockscreen Wallpaper

## Quick Usage Guide
### Dependencies
Fire Autotools assumes you have ADB installed already.

To install ADB on Arch Linux: ```sudo pacman -S android-tools```

### Downloading
Click the cloud icon on the top right of the page, click "Download zip"

### Setup
If you wish to use sideloading / recovery, please place the correct ROM for your device in the ./image folder.

You can find the image for your device here: https://www.amazon.com/gp/help/customer/display.html/ref=hp_bc_nav?ie=UTF8&nodeId=200529680

Do not use a lower version than your currently installed version or try to use an image from the wrong device. Be aware the current root method may not work on upcoming FireOS versions.

If you wish to change your background wallpaper, replace ./other/wallpaper.jpg with your preferred image.


### Running

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
|   └── update-kindle-*.bin // User supplied.
├── other
|   ├── autotools_readme.txt
|   ├── hosts
|   └── wallpaper.jpg // Replace to your liking.
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

```adb shell appwidget grantbind --package com.launcher.name --user 0```

Replace "com.launcher.name" with the name of your launcher.

### Disable Lockscreen
Amazon has made disabling the lockscreen harder in recent versions, you can still do it but there's some side effects:
* Developer options are no longer accessible.
* Notifications and quick controls are no longer accessible.

```adb shell settings set global device_provisioned 0```

### Setting Lockscreen Wallpaper
You can set a custom lockscreen wallpaper image by placing it in this folder:

```/data/securedStorageLocation/com.android.systemui/ls_wallpaper/0```