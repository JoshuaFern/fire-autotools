#!/bin/bash

_pause(){
    read -n1 -rsp $'Press any key to continue or Ctrl+C to exit...\n'
    }
bold=$(tput bold)
normal=$(tput sgr0)

# function to display menus
show_menus() {
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"	
	echo "       Fire Autotools"
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo "Stage 1: Automated Recovery"
	echo "Stage 2: Automated Rooting"
	echo "      3: Exit"
	echo " "
}

# ----------------------------------------------
# Stage #1: Automated Recovery
# ----------------------------------------------
one(){
echo "${bold}Welcome to Stage 1: Automated Recovery${normal}"
echo "${bold}https://www.amazon.com/gp/help/customer/display.html/ref=hp_bc_nav?ie=UTF8&nodeId=200529680${normal}"
echo "${bold}Place the image for your device in the ./image/ folder. Do not attempt to downgrade to an older version.${normal}"
echo "${bold}Be warned that the rooting method could be patched in future versions. 5.3.6.4 is the current version.${normal}"
echo "${bold}1. Enter recovery with the power button and left volume held down with USB plugged in.${normal}"
echo "${bold}2. Select 'wipe data/factory reset' (optional)${normal}"
echo "${bold}3. Select 'apply update from ADB'.${normal}"
_pause
echo "${bold}Attempting to sideload...${normal}"
echo adb sideload ./image/update-kindle-*.bin
echo "${bold}Complete, select 'reboot system now'.${normal}"
echo "${bold}Do not connect your fire to wifi on reboot.${normal}"
echo "${bold}Select a passworded wifi, click cancel, and select 'NOT NOW' to continue without wifi.${normal}"
echo "${bold}Open Settings > Device Options and tap repeatedly on Serial Number until 'Developer Options' appears.${normal}"
echo "${bold}Enable ADB and check 'Always allow from this computer.' and 'OK' when prompted.${normal}"
echo "${bold}Done. Continue to Stage 2.${normal}"
_pause
}

# ----------------------------------------------
# Stage #2: Automated Rooting
# ----------------------------------------------
two(){
echo "${bold}Welcome to Stage 2: Automated Rooting Process${normal}"
echo "${bold}This rooting method is reported to work on:${normal}"
echo "${bold}Fire HD 8 8th gen (2018)${normal}"
echo "${bold}Fire HD 8 7th gen (2017)${normal}"
echo "${bold}Fire HD 8 6th gen (2016)${normal}"
echo "${bold}Fire HD 10 7th gen (2017)${normal}"
echo "${bold}Fire TV 2 (2015)${normal}"
echo "${bold}ASUS Zenpad Z380M${normal}"
echo "${bold}BQ Aquaris M8${normal}"
echo "${bold}Use at your own risk.${normal}"
_pause
adb shell rm data/local/tmp/mtk-su
adb push ./rooting/arm64/su ./rooting/arm64/supolicy ./rooting/arm64/libsupol.so ./rooting/arm64/mtk-su ./rooting/install.sh /data/local/tmp
adb shell chmod 0755 /data/local/tmp/mtk-su /data/local/tmp/install.sh
echo "${bold}Attempting to root...${normal}"
echo "${bold}You should end up at a root command prompt, execute this command:${normal}"
echo "${bold}exec /data/local/tmp/install.sh${normal}"
adb shell ./data/local/tmp/mtk-su
echo "${bold}If you saw permission errors the root failed, try again from Stage 2.${normal}"
echo "${bold}We're about to install the SuperSU apk, exit at this point if you want to install something yourself.${normal}"
_pause
echo "${bold}Installing SuperSU...${normal}"
adb install ./rooting/eu.chainfire.supersu.282.apk
echo "${bold}Open SuperSU app and update the binary, reboot when prompted.${normal}"
echo "${bold}Set SuperSU permission mode to 'Grant' the default prompts don't work on FireOS.${normal}"
echo "${bold}Done. Continue to Stage 3.${normal}"
_pause
}

read_options(){
	local choice
	read -p "Enter choice [ 1 - 3] " choice
	case $choice in
		1) one ;;
		2) two ;;
		3) exit 0;;
		*) echo -e "${RED}Error...${STD}" && sleep 2
	esac
}

while true
do
 
	show_menus
	read_options
done