# Fire Autotools (Beta)
**Only tested on Fire HD 8 (2016), use at your own risk.**

## Goals
* Easy Sideloading & Recovery
* Obtain Root
* Block all Amazon apps and services from spying.
* Disable Amazon Bloat to minimize CPU and memory usage.
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