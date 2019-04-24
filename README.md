# Fire Autotools 19.04 (Beta)
**Only tested on Fire HD 8 2016 (giza), use at your own risk.**

I am not responsible for bricked devices, dead SD cards, thermonuclear war, or you getting fired because the alarm app failed. Please do some research if you have any concerns about features included in this script BEFORE using it! YOU are choosing to make these modifications, and if you point the finger at me for messing up your device, I will laugh at you.

## Description
Fire Autotools is a simple bash shell script that I made for myself to automate the process of recovering and setting up my device. I have made this script publicly available for anyone to use, but I haven't tested it on any device but my own. The script should be fairly easy to edit and tailor for your specific device and use case.
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

To install ADB on NixOS: ```programs.adb.enable = true;``` and add your user to the "adbusers" group.

### Downloading
Click the cloud icon near the top right of the page, click "Download zip"

### Setup
* If you wish to use sideloading / recovery, please place the correct ROM for your device in the ./image folder. You can find the image for your device [here](https://www.amazon.com/gp/help/customer/display.html/ref=hp_bc_nav?ie=UTF8&nodeId=200529680). Do not use a lower version than your currently installed version or try to use an image from the wrong device. Be aware the current root method may not work on upcoming FireOS versions.

* If you wish to change your lockscreen wallpaper, replace ./other/wallpaper.png with your preferred image.

* By default, the script attempts to remove as many FireOS app packages as possible. This WILL break certain features of your device such as printing, proxy, and VPN support. If you need these features you can edit ./fireAutotools.sh and comment out the sections for the packages you want to keep, but the ultimate goal is to find open source alternatives to replace them with.


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
|   └── wallpaper.png // Replace to your liking.
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

## Workarounds & Tweaks
### Unable to set Time Zone
Sometimes you may be unable to change the timezone in the settings. We can do it manually with ADB.

```adb shell su -c setprop persist.sys.timezone "America/Los_Angeles"```

Reboot. See this page for a list of timezones: https://en.wikipedia.org/wiki/List_of_tz_database_time_zones

### Unable to use Widgets
If you change the launcher, widgets are nonfunctional. Here's the fix:

```adb shell appwidget grantbind --package com.launcher.name --user 0```

Replace "com.launcher.name" with the name of your launcher.

### Disable Lockscreen
Amazon has made disabling the lockscreen harder in recent versions, you can still do it but there's some side effects:
* Developer options are no longer accessible.
* Notifications and quick controls are no longer accessible.

```adb shell settings put global device_provisioned 0```

### F-Droid Repos
Some software is not included in the official F-Droid Repository, you may wish to add these additional repos:
* Bromite/WebView: ```https://fdroid.bromite.org/fdroid/repo?fingerprint=E1EE5CD076D7B0DC84CB2B45FB78B86DF2EB39A3B6C56BA3DC292A5E0C3B9504```
* Micro-G: ```https://microg.org/fdroid/repo?fingerprint=9BD06727E62796C0130EB6DAB39B73157451582CBD138E86C468ACC395D14165```