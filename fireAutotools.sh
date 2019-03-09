#!/bin/bash

_pause(){
    read -n1 -rsp $'Press any key to continue or Ctrl+C to exit...\n'
    }
bold=$(tput bold)
normal=$(tput sgr0)

# function to display menus
show_menus() {
	clear
	echo "${bold}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${normal}"	
	echo "${bold}       Fire Autotools        ${normal}"
	echo "${bold}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${normal}"
	echo "${bold}This script assumes you have ADB.${normal}"
	echo "${bold}Please read the instructions carefully.${normal}"
	echo "Stage 1: Automated Recovery"
	echo "Stage 2: Automated Rooting"
	echo "Stage 3: Bloat Removal & Security"
	echo "Stage 4: Install F-Droid & Privileged Extension"
	echo "Stage 5: Material Design Xposed Installer"
	echo "      9: Exit"
	echo " "
}
show_extras() {
	clear
	echo "${bold}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${normal}"	
	echo "${bold}        Extras Menu          ${normal}"
	echo "${bold}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${normal}"
	echo "Extra 1: Restore Amazon Apps"
	echo "      9: Exit"
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
echo "${bold}Thanks to diplomatic on xda for this method.${normal}"
_pause
adb shell rm /data/local/tmp/mtk-su /data/local/tmp/install.sh
adb push ./rooting/arm64/su ./rooting/arm64/supolicy ./rooting/arm64/libsupol.so ./rooting/arm64/mtk-su ./rooting/install.sh /data/local/tmp
adb shell chmod 0755 /data/local/tmp/mtk-su /data/local/tmp/install.sh
echo "${bold}Attempting to root...${normal}"
echo "${bold}You should end up at a root command prompt, execute this command:${normal}"
echo "${bold}exec /data/local/tmp/install.sh${normal}"
adb shell ./data/local/tmp/mtk-su
echo "${bold}If you saw permission errors the root failed, try again from Stage 2.${normal}"
echo "${bold}We're about to install the SuperSU Free apk, exit at this point if you want to install something yourself.${normal}"
_pause
echo "${bold}Installing SuperSU...${normal}"
adb install ./rooting/eu.chainfire.supersu.282.apk
echo "${bold}Open SuperSU app and update the binary, reboot when prompted.${normal}"
echo "${bold}Set SuperSU default access mode to 'Grant' the prompt mode doesn't work on FireOS.${normal}"
echo "${bold}Done. Continue to Stage 3.${normal}"
_pause
}

# ----------------------------------------------
# Stage #3: Bloat Removal, Replacement & Security
# ----------------------------------------------
three(){
echo "${bold}Welcome to Stage 3: Bloat Removal & Security${normal}"
echo "${bold}This will attempt to disable and replace as much as possible without breaking anything.${normal}"
echo "${bold}Then it will secure your system by preventing Amazon apps from touching the internet.${normal}"
_pause
# adb shell pm disable amazon.alexa.tablet
# adb shell pm disable amazon.fireos
# adb shell pm disable amazon.jackson19
# adb shell pm disable amazon.speech.sim
# adb shell pm disable android
# adb shell pm disable android.amazon.perm
# adb shell pm disable com.amazon.accessorynotifier
# adb shell pm disable com.amazon.acos.providers.UnifiedSettingsProvider
# adb shell pm disable com.amazon.advertisingidsettings
# adb shell pm disable com.amazon.ags.app
# adb shell pm disable com.amazon.alexa.externalmediaplayer.fireos
# adb shell pm disable com.amazon.alta.h2clientservice
# adb shell pm disable com.amazon.android.marketplace
# adb shell pm disable com.amazon.application.compatibility.enforcer
# adb shell pm disable com.amazon.application.compatibility.enforcer.sdk.library
# adb shell pm disable com.amazon.assetsync.service
# adb shell pm disable com.amazon.avod
# adb shell pm disable com.amazon.bluetoothinternals
# adb shell pm disable com.amazon.calculator
# adb shell pm disable com.amazon.camera
# adb shell pm disable com.amazon.cardinal
# adb shell pm disable com.amazon.client.metrics
# adb shell pm disable com.amazon.client.metrics.api
# adb shell pm disable com.amazon.cloud9
# adb shell pm disable com.amazon.cloud9.contentservice
# adb shell pm disable com.amazon.cloud9.kids
# adb shell pm disable com.amazon.cloud9.systembrowserprovider
# adb shell pm disable com.amazon.communication.discovery
# adb shell pm disable com.amazon.connectivitydiag
# adb shell pm disable com.amazon.csapp
# adb shell pm disable com.amazon.dcp
# adb shell pm disable com.amazon.dcp.contracts.framework.library
# adb shell pm disable com.amazon.dcp.contracts.library
# adb shell pm disable com.amazon.dee.app
# adb shell pm disable com.amazon.device.backup
# adb shell pm disable com.amazon.device.backup.sdk.internal.library
# adb shell pm disable com.amazon.device.bluetoothdfu
# adb shell pm disable com.amazon.device.crashmanager
# adb shell pm disable com.amazon.device.logmanager
# adb shell pm disable com.amazon.device.messaging
# adb shell pm disable com.amazon.device.messaging.sdk.internal.library
# adb shell pm disable com.amazon.device.messaging.sdk.library
# adb shell pm disable com.amazon.device.metrics
# adb shell pm disable com.amazon.device.sale.service
# adb shell pm disable com.amazon.device.settings
# adb shell pm disable com.amazon.device.settings.sdk.internal.library
# adb shell pm disable com.amazon.device.software.ota
# adb shell pm disable com.amazon.device.software.ota.override
# adb shell pm disable com.amazon.device.sync
# adb shell pm disable com.amazon.device.sync.sdk.internal
# adb shell pm disable com.amazon.digital.asset.ownership.app
# adb shell pm disable com.amazon.dp.contacts
# adb shell pm disable com.amazon.dp.fbcontacts
# adb shell pm disable com.amazon.dp.logger
# adb shell pm disable com.amazon.dynamicupdationservice
# adb shell pm disable com.amazon.fireinputdevices
# adb shell pm disable com.amazon.firelauncher
# adb shell pm disable com.amazon.firepowersettings
# adb shell pm disable com.amazon.frameworksettings
# adb shell pm disable com.amazon.geo.client.maps
# adb shell pm disable com.amazon.geo.mapsv2
# adb shell pm disable com.amazon.geo.mapsv2.services
# adb shell pm disable com.amazon.gloria.graphiq
# adb shell pm disable com.amazon.gloria.smarthome
# adb shell pm disable com.amazon.h2settingsfortablet
# adb shell pm disable com.amazon.identity.auth.device.authorization
# adb shell pm disable com.amazon.imp
# adb shell pm disable com.amazon.kcp.tutorial
# adb shell pm disable com.amazon.kindle
# adb shell pm disable com.amazon.kindle.cms
# adb shell pm disable com.amazon.kindle.devicecontrols
# adb shell pm disable com.amazon.kindle.kso
# adb shell pm disable com.amazon.kindle.otter.oobe
# adb shell pm disable com.amazon.kindle.otter.oobe.forced.ota
# adb shell pm disable com.amazon.kindle.personal_video
# adb shell pm disable com.amazon.kindle.rdmdeviceadmin
# adb shell pm disable com.amazon.kindle.unifiedSearch
# adb shell pm disable com.amazon.kindleautomatictimezone
# adb shell pm disable com.amazon.knight.speechui
# adb shell pm disable com.amazon.kor.demo
# adb shell pm disable com.amazon.legalsettings
# adb shell pm disable com.amazon.logan
# adb shell pm disable com.amazon.media.session.monitor
# adb shell pm disable com.amazon.mp3
# adb shell pm disable com.amazon.mw
# adb shell pm disable com.amazon.mw.sdk
# adb shell pm disable com.amazon.nimh
# adb shell pm disable com.amazon.ods.kindleconnect
# adb shell pm disable com.amazon.parentalcontrols
# adb shell pm disable com.amazon.photos
# adb shell pm disable com.amazon.photos.importer
# adb shell pm disable com.amazon.platform
# adb shell pm disable com.amazon.platform.fdrw
# adb shell pm disable com.amazon.platformsettings
# adb shell pm disable com.amazon.pm
# adb shell pm disable com.amazon.providers
# adb shell pm disable com.amazon.providers.contentsupport
# adb shell pm disable com.amazon.readynowcore
# adb shell pm disable com.amazon.recess
# adb shell pm disable com.amazon.redstone
# adb shell pm disable com.amazon.securitysyncclient
# adb shell pm disable com.amazon.settings.systemupdates
# adb shell pm disable com.amazon.sharingservice.android.client.proxy
# adb shell pm disable com.amazon.shpm
# adb shell pm disable com.amazon.socialplatform
# adb shell pm disable com.amazon.storagemanager
# adb shell pm disable com.amazon.sync.provider.ipc
# adb shell pm disable com.amazon.sync.service
# adb shell pm disable com.amazon.tablet.voicesettings
# adb shell pm disable com.amazon.tabletsubscriptions
# adb shell pm disable com.amazon.tahoe
# adb shell pm disable com.amazon.tcomm
# adb shell pm disable com.amazon.tcomm.client
# adb shell pm disable com.amazon.tv.ottssocompanionapp
# adb shell pm disable com.amazon.unifiedshare.actionchooser
# adb shell pm disable com.amazon.unifiedsharegoodreads
# adb shell pm disable com.amazon.unifiedsharesinaweibo
# adb shell pm disable com.amazon.unifiedsharetwitter
# adb shell pm disable com.amazon.vans.alexatabletshopping.app
# adb shell pm disable com.amazon.venezia
# adb shell pm disable com.amazon.weather
# adb shell pm disable com.amazon.webapp
# adb shell pm disable com.amazon.webview
# adb shell pm disable com.amazon.webview.chromium
# adb shell pm disable com.amazon.whisperlink.activityview.android
# adb shell pm disable com.amazon.whisperlink.core.android
# adb shell pm disable com.amazon.whisperplay.contracts
# adb shell pm disable com.amazon.wifilocker
# adb shell pm disable com.amazon.windowshop
# adb shell pm disable com.amazon.zico
# adb shell pm disable com.android.backupconfirm
# adb shell pm disable com.android.bluetooth
# adb shell pm disable com.android.calendar
# adb shell pm disable com.android.captiveportallogin
# adb shell pm disable com.android.certinstaller
# adb shell pm disable com.android.contacts
# adb shell pm disable com.android.defcontainer
# adb shell pm disable com.android.deskclock
# adb shell pm disable com.android.documentsui
# adb shell pm disable com.android.email
# adb shell pm disable com.android.externalstorage
# adb shell pm disable com.android.htmlviewer
# adb shell pm disable com.android.keychain
# adb shell pm disable com.android.location.fused
# adb shell pm disable com.android.managedprovisioning
# adb shell pm disable com.android.music
# adb shell pm disable com.android.onetimeinitializer
# adb shell pm disable com.android.packageinstaller
# adb shell pm disable com.android.pacprocessor
# adb shell pm disable com.android.printspooler
# adb shell pm disable com.android.providers.calendar
# adb shell pm disable com.android.providers.contacts
# adb shell pm disable com.android.providers.downloads
# adb shell pm disable com.android.providers.downloads.ui
# adb shell pm disable com.android.providers.media
# adb shell pm disable com.android.providers.settings
# adb shell pm disable com.android.providers.userdictionary
# adb shell pm disable com.android.proxyhandler
# adb shell pm disable com.android.settings
# adb shell pm disable com.android.sharedstoragebackup
# adb shell pm disable com.android.shell
# adb shell pm disable com.android.systemui
# adb shell pm disable com.android.vpndialogs
# adb shell pm disable com.android.wallpapercropper
# adb shell pm disable com.audible.application.kindle
# adb shell pm disable com.dolby
# adb shell pm disable com.github.yeriomin.yalpstore
# adb shell pm disable com.goodreads.kindle
# adb shell pm disable com.here.odnp.service
# adb shell pm disable com.ivona.orchestrator
# adb shell pm disable com.ivona.tts.oem
# adb shell pm disable com.kingsoft.office.amz
# adb shell pm disable com.svox.pico
# adb shell pm disable jp.co.omronsoft.iwnnime.languagepack.zhcn_az
# adb shell pm disable jp.co.omronsoft.iwnnime.mlaz
# adb shell pm disable org.mopria.printplugin
}

# ----------------------------------------------
# Stage #4: Install F-Droid & Privileged Extension
# ----------------------------------------------
four(){
echo "${bold}Welcome to Stage 4: Install F-Droid & Privileged Extension${normal}"
echo "${bold}This will install the F-Droid app store and the Privileged Extension to do background installs.${normal}"
_pause
adb push ./apks/org.fdroid.privileged_*.apk /data/local/tmp
adb install ./apks/org.fdroid.fdroid_*.apk
adb shell mv /data/local/tmp/org.fdroid.privileged_*.apk /system/priv-app
echo "${bold}Done.${normal}"
}

# ----------------------------------------------
# Stage #5: Material Design Xposed Installer
# ----------------------------------------------
five(){
echo "${bold}Welcome to Stage 5: Material Design Xposed Installer${normal}"
echo "${bold}This will install the Material Design Xposed Installer and give instructions on how to use it.${normal}"
_pause
adb install ./apks/XposedInstaller*.apk
echo "${bold}Please open the app, go to the official tab and install the latest ARM64 version.${normal}"
echo "${bold}You will recieve an error during install. This is normal, continue after this has happened..${normal}"
_pause
echo "${bold}Done. Please reboot.${normal}"
}

# ----------------------------------------------
# Extra #1: Unfreeze Amazon Apps
# ----------------------------------------------
eone(){
echo "${bold}Welcome to Extra #1: Unfreeze Amazon Apps${normal}"
echo "${bold}This will attempt to re-enable every Amazon app.${normal}"
echo "${bold}This may fix any issues you've found after disabling them.${normal}"
_pause
adb shell pm enable amazon.alexa.tablet
adb shell pm enable amazon.fireos
adb shell pm enable amazon.jackson19
adb shell pm enable amazon.speech.sim
adb shell pm enable android
adb shell pm enable android.amazon.perm
adb shell pm enable com.amazon.accessorynotifier
adb shell pm enable com.amazon.acos.providers.UnifiedSettingsProvider
adb shell pm enable com.amazon.advertisingidsettings
adb shell pm enable com.amazon.ags.app
adb shell pm enable com.amazon.alexa.externalmediaplayer.fireos
adb shell pm enable com.amazon.alta.h2clientservice
adb shell pm enable com.amazon.android.marketplace
adb shell pm enable com.amazon.application.compatibility.enforcer
adb shell pm enable com.amazon.application.compatibility.enforcer.sdk.library
adb shell pm enable com.amazon.assetsync.service
adb shell pm enable com.amazon.avod
adb shell pm enable com.amazon.bluetoothinternals
adb shell pm enable com.amazon.calculator
adb shell pm enable com.amazon.camera
adb shell pm enable com.amazon.cardinal
adb shell pm enable com.amazon.client.metrics
adb shell pm enable com.amazon.client.metrics.api
adb shell pm enable com.amazon.cloud9
adb shell pm enable com.amazon.cloud9.contentservice
adb shell pm enable com.amazon.cloud9.kids
adb shell pm enable com.amazon.cloud9.systembrowserprovider
adb shell pm enable com.amazon.communication.discovery
adb shell pm enable com.amazon.connectivitydiag
adb shell pm enable com.amazon.csapp
adb shell pm enable com.amazon.dcp
adb shell pm enable com.amazon.dcp.contracts.framework.library
adb shell pm enable com.amazon.dcp.contracts.library
adb shell pm enable com.amazon.dee.app
adb shell pm enable com.amazon.device.backup
adb shell pm enable com.amazon.device.backup.sdk.internal.library
adb shell pm enable com.amazon.device.bluetoothdfu
adb shell pm enable com.amazon.device.crashmanager
adb shell pm enable com.amazon.device.logmanager
adb shell pm enable com.amazon.device.messaging
adb shell pm enable com.amazon.device.messaging.sdk.internal.library
adb shell pm enable com.amazon.device.messaging.sdk.library
adb shell pm enable com.amazon.device.metrics
adb shell pm enable com.amazon.device.sale.service
adb shell pm enable com.amazon.device.settings
adb shell pm enable com.amazon.device.settings.sdk.internal.library
adb shell pm enable com.amazon.device.software.ota
adb shell pm enable com.amazon.device.software.ota.override
adb shell pm enable com.amazon.device.sync
adb shell pm enable com.amazon.device.sync.sdk.internal
adb shell pm enable com.amazon.digital.asset.ownership.app
adb shell pm enable com.amazon.dp.contacts
adb shell pm enable com.amazon.dp.fbcontacts
adb shell pm enable com.amazon.dp.logger
adb shell pm enable com.amazon.dynamicupdationservice
adb shell pm enable com.amazon.fireinputdevices
adb shell pm enable com.amazon.firelauncher
adb shell pm enable com.amazon.firepowersettings
adb shell pm enable com.amazon.frameworksettings
adb shell pm enable com.amazon.geo.client.maps
adb shell pm enable com.amazon.geo.mapsv2
adb shell pm enable com.amazon.geo.mapsv2.services
adb shell pm enable com.amazon.gloria.graphiq
adb shell pm enable com.amazon.gloria.smarthome
adb shell pm enable com.amazon.h2settingsfortablet
adb shell pm enable com.amazon.identity.auth.device.authorization
adb shell pm enable com.amazon.imp
adb shell pm enable com.amazon.kcp.tutorial
adb shell pm enable com.amazon.kindle
adb shell pm enable com.amazon.kindle.cms
adb shell pm enable com.amazon.kindle.devicecontrols
adb shell pm enable com.amazon.kindle.kso
adb shell pm enable com.amazon.kindle.otter.oobe
adb shell pm enable com.amazon.kindle.otter.oobe.forced.ota
adb shell pm enable com.amazon.kindle.personal_video
adb shell pm enable com.amazon.kindle.rdmdeviceadmin
adb shell pm enable com.amazon.kindle.unifiedSearch
adb shell pm enable com.amazon.kindleautomatictimezone
adb shell pm enable com.amazon.knight.speechui
adb shell pm enable com.amazon.kor.demo
adb shell pm enable com.amazon.legalsettings
adb shell pm enable com.amazon.logan
adb shell pm enable com.amazon.media.session.monitor
adb shell pm enable com.amazon.mp3
adb shell pm enable com.amazon.mw
adb shell pm enable com.amazon.mw.sdk
adb shell pm enable com.amazon.nimh
adb shell pm enable com.amazon.ods.kindleconnect
adb shell pm enable com.amazon.parentalcontrols
adb shell pm enable com.amazon.photos
adb shell pm enable com.amazon.photos.importer
adb shell pm enable com.amazon.platform
adb shell pm enable com.amazon.platform.fdrw
adb shell pm enable com.amazon.platformsettings
adb shell pm enable com.amazon.pm
adb shell pm enable com.amazon.providers
adb shell pm enable com.amazon.providers.contentsupport
adb shell pm enable com.amazon.readynowcore
adb shell pm enable com.amazon.recess
adb shell pm enable com.amazon.redstone
adb shell pm enable com.amazon.securitysyncclient
adb shell pm enable com.amazon.settings.systemupdates
adb shell pm enable com.amazon.sharingservice.android.client.proxy
adb shell pm enable com.amazon.shpm
adb shell pm enable com.amazon.socialplatform
adb shell pm enable com.amazon.storagemanager
adb shell pm enable com.amazon.sync.provider.ipc
adb shell pm enable com.amazon.sync.service
adb shell pm enable com.amazon.tablet.voicesettings
adb shell pm enable com.amazon.tabletsubscriptions
adb shell pm enable com.amazon.tahoe
adb shell pm enable com.amazon.tcomm
adb shell pm enable com.amazon.tcomm.client
adb shell pm enable com.amazon.tv.ottssocompanionapp
adb shell pm enable com.amazon.unifiedshare.actionchooser
adb shell pm enable com.amazon.unifiedsharegoodreads
adb shell pm enable com.amazon.unifiedsharesinaweibo
adb shell pm enable com.amazon.unifiedsharetwitter
adb shell pm enable com.amazon.vans.alexatabletshopping.app
adb shell pm enable com.amazon.venezia
adb shell pm enable com.amazon.weather
adb shell pm enable com.amazon.webapp
adb shell pm enable com.amazon.webview
adb shell pm enable com.amazon.webview.chromium
adb shell pm enable com.amazon.whisperlink.activityview.android
adb shell pm enable com.amazon.whisperlink.core.android
adb shell pm enable com.amazon.whisperplay.contracts
adb shell pm enable com.amazon.wifilocker
adb shell pm enable com.amazon.windowshop
adb shell pm enable com.amazon.zico
adb shell pm enable com.android.backupconfirm
adb shell pm enable com.android.bluetooth
adb shell pm enable com.android.calendar
adb shell pm enable com.android.captiveportallogin
adb shell pm enable com.android.certinstaller
adb shell pm enable com.android.contacts
adb shell pm enable com.android.defcontainer
adb shell pm enable com.android.deskclock
adb shell pm enable com.android.documentsui
adb shell pm enable com.android.email
adb shell pm enable com.android.externalstorage
adb shell pm enable com.android.htmlviewer
adb shell pm enable com.android.keychain
adb shell pm enable com.android.location.fused
adb shell pm enable com.android.managedprovisioning
adb shell pm enable com.android.music
adb shell pm enable com.android.onetimeinitializer
adb shell pm enable com.android.packageinstaller
adb shell pm enable com.android.pacprocessor
adb shell pm enable com.android.printspooler
adb shell pm enable com.android.providers.calendar
adb shell pm enable com.android.providers.contacts
adb shell pm enable com.android.providers.downloads
adb shell pm enable com.android.providers.downloads.ui
adb shell pm enable com.android.providers.media
adb shell pm enable com.android.providers.settings
adb shell pm enable com.android.providers.userdictionary
adb shell pm enable com.android.proxyhandler
adb shell pm enable com.android.settings
adb shell pm enable com.android.sharedstoragebackup
adb shell pm enable com.android.shell
adb shell pm enable com.android.systemui
adb shell pm enable com.android.vpndialogs
adb shell pm enable com.android.wallpapercropper
adb shell pm enable com.audible.application.kindle
adb shell pm enable com.dolby
adb shell pm enable com.github.yeriomin.yalpstore
adb shell pm enable com.goodreads.kindle
adb shell pm enable com.here.odnp.service
adb shell pm enable com.ivona.orchestrator
adb shell pm enable com.ivona.tts.oem
adb shell pm enable com.kingsoft.office.amz
adb shell pm enable com.svox.pico
adb shell pm enable jp.co.omronsoft.iwnnime.languagepack.zhcn_az
adb shell pm enable jp.co.omronsoft.iwnnime.mlaz
adb shell pm enable org.mopria.printplugin
echo "${bold}Done. You may need to reboot.${normal}"
_pause
}

read_options(){
	local choice
	read -p "Enter choice [ 1 - 9] " choice
	case $choice in
		1) one ;;
		2) two ;;
		3) three ;;
		4) four ;;
		5) five ;;
		8) exit 0;;
		9) exit 0;;
		*) echo -e "${RED}Error...${STD}" && sleep 2
	esac
}

while true
do
 
	show_menus
	read_options
done