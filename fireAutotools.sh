
echo "https://www.amazon.com/gp/help/customer/display.html/ref=hp_bc_nav?ie=UTF8&nodeId=200529680"
echo "Place the image you want to flash in the ./image/ folder. Do not attempt to downgrade to an older version."
echo "1. Enter recovery with the power button and left volume held down with USB plugged in."
echo "2. Select 'wipe data/factory reset' (optional)"
echo "3. Select 'apply update from ADB'."

_pause

echo "Attempting to sideload..."
adb sideload ./image/update-kindle-*.bin

echo "Complete, select 'reboot system now'."
echo "Do not connect your fire to wifi on reboot."
echo "Select a passworded wifi, click cancel, and select 'NOT NOW' to continue without wifi."
echo "Open Settings > Device Options and tap repeatedly on Serial Number until 'Developer Options' appears."
echo "Enable ADB and check 'Always allow from this computer.' and 'OK' when prompted."
echo "Done."

_pause

_pause(){
 read -n1 -rsp $'Press any key to continue or Ctrl+C to exit...\n'
}