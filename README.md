# Fire Autotools (Beta)
**Only tested on Fire HD 8 (2016), use at your own risk.**

## Goals:
* Obtain Root.
* Avoid registering to Amazon and prevent ads from showing.
* Block all Amazon apps and services from spying.
* Minimize CPU and memory usage.
* Replace as much as possible with lightweight Open Source alternatives.
* Avoid breaking anything.


## File Overview
```
.
├── image // For adb sideloading & recovery.
|   ├── autotools_readme.txt // Includes a link to obtain update images.
|   └── update-kindle-*.bin // Supply your own update image.
├── apks // Bundled app files for automatic installation & caching updates.
|   └── autotools_readme.txt // App update information.
├── rooting // Rooting utilities.
|   ├── arm 
|   |   └── mtk-su // Rooting utility.
|   ├── arm64
|   |   └── mtk-su // 64bit version
|   ├── autotools_readme.txt // Root update information.
|   └── readme.txt // Readme provided by the root method's author.
├── fireAutotools.sh // Main script file, run this.
└── README.md // This readme.
```