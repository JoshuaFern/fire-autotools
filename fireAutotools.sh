
echo "Welcome to Stage 1: Automated Recovery"
echo "https://www.amazon.com/gp/help/customer/display.html/ref=hp_bc_nav?ie=UTF8&nodeId=200529680"
echo "Place the image for your device in the ./image/ folder. Do not attempt to downgrade to an older version."
echo "Be warned that the rooting method could be patched in future versions. 5.3.6.4 is the current version."
echo "1. Enter recovery with the power button and left volume held down with USB plugged in."
echo "2. Select 'wipe data/factory reset' (optional)"
echo "3. Select 'apply update from ADB'."

_pause

echo "Attempting to sideload..."
echo adb sideload ./image/update-kindle-*.bin

echo "Complete, select 'reboot system now'."
echo "Do not connect your fire to wifi on reboot."
echo "Select a passworded wifi, click cancel, and select 'NOT NOW' to continue without wifi."
echo "Open Settings > Device Options and tap repeatedly on Serial Number until 'Developer Options' appears."
echo "Enable ADB and check 'Always allow from this computer.' and 'OK' when prompted."
echo "Done. Continue to Stage 2."

_pause

echo "Welcome to Stage 2: Automated Rooting Process"
echo "This rooting method is reported to work on:"
echo "Fire HD 8 8th gen (2018)"
echo "Fire HD 8 7th gen (2017)"
echo "Fire HD 8 6th gen (2016)"
echo "Fire HD 10 7th gen (2017)"
echo "Fire TV 2 (2015)"
echo "ASUS Zenpad Z380M"
echo "BQ Aquaris M8"
echo "Use at your own risk."

_pause

echo "Copying files..."
adb shell rm data/local/tmp/mtk-su
adb push /rooting/arm64/su /rooting/arm64/supolicy /rooting/arm64/libsupol.so /rooting/arm64/mtk-su /data/local/tmp
echo "Setting permissions..."
adb shell chmod 0755 data/local/tmp/mtk-su
echo "We're about to attempt root, sometimes this fails and you need to try it again."
_pause
echo "Attempting to root..."
adb shell ./data/local/tmp/mtk-su -v && echo Done.
_pause
echo "Remounting /system to read/write..."
adb shell mount -o remount -rw /system
echo "If you saw a permission error the root failed, try again."
_pause
echo "Copying su binaries into /system/xbin..."
adb shell cp /data/local/tmp/su /system/xbin/su
adb shell cp /data/local/tmp/su /system/xbin/daemonsu
adb shell cp /data/local/tmp/supolicy /system/xbin/
adb shell cp /data/local/tmp/libsupol.so /system/lib/
adb shell cp /data/local/tmp/libsupol.so /system/lib64/
echo "Setting permissions..."
adb shell chmod 0755 /system/xbin/su
adb shell chcon u:object_r:system_file:s0/system/xbin/su
adb shell chmod 0755 /system/xbin/daemonsu
adb shell chcon u:object_r:system_file:s0 /system/xbin/daemonsu
echo "Starting daemonsu..."
adb shell daemonsu --auto-daemon

echo "We're about to install SuperSU, exit at this point if you want to install it or something else yourself."
_pause
echo "Installing SuperSU..."
adb install SuperSU.apk
echo "Open SuperSU app and update the binary reboot when prompted."
echo "Set SuperSU permission mode to 'Grant' the default prompts don't work on FireOS."

_pause

_pause(){
 read -n1 -rsp $'Press any key to continue or Ctrl+C to exit...\n'
}