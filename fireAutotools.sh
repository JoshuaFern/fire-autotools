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
# Stage #3: Bloat Removal & Security
# ----------------------------------------------
three(){
echo "${bold}Welcome to Stage 3: Bloat Removal & Security${normal}"
echo "${bold}This will attempt to disable and replace as much as possible without breaking anything.${normal}"
echo "${bold}It will also install Emerald Launcher and AnySoftKeyboard so you're not left with an unusable device.${normal}"
_pause
# adb shell su -c pm disable amazon.alexa.tablet
# adb shell su -c pm disable amazon.fireos
adb shell su -c pm disable amazon.jackson19
# adb shell su -c pm disable amazon.speech.sim
# adb shell su -c pm disable android
# adb shell su -c pm disable android.amazon.perm
# adb shell su -c pm disable com.amazon.accessorynotifier
# adb shell su -c pm disable com.amazon.acos.providers.UnifiedSettingsProvider
# adb shell su -c pm disable com.amazon.advertisingidsettings
# adb shell su -c pm disable com.amazon.ags.app
# adb shell su -c pm disable com.amazon.alexa.externalmediaplayer.fireos
# adb shell su -c pm disable com.amazon.alta.h2clientservice
adb shell su -c pm disable com.amazon.android.marketplace
# adb shell su -c pm disable com.amazon.application.compatibility.enforcer
# adb shell su -c pm disable com.amazon.application.compatibility.enforcer.sdk.library
# adb shell su -c pm disable com.amazon.assetsync.service
# adb shell su -c pm disable com.amazon.avod
# adb shell su -c pm disable com.amazon.bluetoothinternals
adb shell su -c pm disable com.amazon.calculator # Calculator
# adb shell su -c pm disable com.amazon.camera
# adb shell su -c pm disable com.amazon.cardinal
# adb shell su -c pm disable com.amazon.client.metrics
# adb shell su -c pm disable com.amazon.client.metrics.api
# adb shell su -c pm disable com.amazon.cloud9
# adb shell su -c pm disable com.amazon.cloud9.contentservice
# adb shell su -c pm disable com.amazon.cloud9.kids
# adb shell su -c pm disable com.amazon.cloud9.systembrowserprovider
# adb shell su -c pm disable com.amazon.communication.discovery
# adb shell su -c pm disable com.amazon.connectivitydiag
# adb shell su -c pm disable com.amazon.csapp
# adb shell su -c pm disable com.amazon.dcp
# adb shell su -c pm disable com.amazon.dcp.contracts.framework.library
# adb shell su -c pm disable com.amazon.dcp.contracts.library
# adb shell su -c pm disable com.amazon.dee.app # Amazon Alexa
# adb shell su -c pm disable com.amazon.device.backup
# adb shell su -c pm disable com.amazon.device.backup.sdk.internal.library
# adb shell su -c pm disable com.amazon.device.bluetoothdfu
# adb shell su -c pm disable com.amazon.device.crashmanager
# adb shell su -c pm disable com.amazon.device.logmanager
# adb shell su -c pm disable com.amazon.device.messaging
# adb shell su -c pm disable com.amazon.device.messaging.sdk.internal.library
# adb shell su -c pm disable com.amazon.device.messaging.sdk.library
# adb shell su -c pm disable com.amazon.device.metrics
# adb shell su -c pm disable com.amazon.device.sale.service
# adb shell su -c pm disable com.amazon.device.settings
# adb shell su -c pm disable com.amazon.device.settings.sdk.internal.library
# adb shell su -c pm disable com.amazon.device.software.ota
# adb shell su -c pm disable com.amazon.device.software.ota.override
# adb shell su -c pm disable com.amazon.device.sync
# adb shell su -c pm disable com.amazon.device.sync.sdk.internal
# adb shell su -c pm disable com.amazon.digital.asset.ownership.app
adb shell su -c pm disable com.amazon.dp.contacts # Contacts
adb shell su -c pm disable com.amazon.dp.fbcontacts # Facebook Contacts
# adb shell su -c pm disable com.amazon.dp.logger
# adb shell su -c pm disable com.amazon.dynamicupdationservice
# adb shell su -c pm disable com.amazon.fireinputdevices
adb shell su -c pm disable com.amazon.firelauncher # Fire Launcher
# adb shell su -c pm disable com.amazon.firepowersettings
# adb shell su -c pm disable com.amazon.frameworksettings
# adb shell su -c pm disable com.amazon.geo.client.maps
# adb shell su -c pm disable com.amazon.geo.mapsv2
# adb shell su -c pm disable com.amazon.geo.mapsv2.services
# adb shell su -c pm disable com.amazon.gloria.graphiq
# adb shell su -c pm disable com.amazon.gloria.smarthome
# adb shell su -c pm disable com.amazon.h2settingsfortablet
# adb shell su -c pm disable com.amazon.identity.auth.device.authorization
# adb shell su -c pm disable com.amazon.imp
# adb shell su -c pm disable com.amazon.kcp.tutorial
# adb shell su -c pm disable com.amazon.kindle
# adb shell su -c pm disable com.amazon.kindle.cms
# adb shell su -c pm disable com.amazon.kindle.devicecontrols
# adb shell su -c pm disable com.amazon.kindle.kso
# adb shell su -c pm disable com.amazon.kindle.otter.oobe
# adb shell su -c pm disable com.amazon.kindle.otter.oobe.forced.ota
# adb shell su -c pm disable com.amazon.kindle.personal_video
# adb shell su -c pm disable com.amazon.kindle.rdmdeviceadmin
# adb shell su -c pm disable com.amazon.kindle.unifiedSearch
# adb shell su -c pm disable com.amazon.kindleautomatictimezone
# adb shell su -c pm disable com.amazon.knight.speechui
# adb shell su -c pm disable com.amazon.kor.demo
# adb shell su -c pm disable com.amazon.legalsettings
# adb shell su -c pm disable com.amazon.logan
# adb shell su -c pm disable com.amazon.media.session.monitor
# adb shell su -c pm disable com.amazon.mp3
# adb shell su -c pm disable com.amazon.mw
# adb shell su -c pm disable com.amazon.mw.sdk
# adb shell su -c pm disable com.amazon.nimh
# adb shell su -c pm disable com.amazon.ods.kindleconnect
# adb shell su -c pm disable com.amazon.parentalcontrols
# adb shell su -c pm disable com.amazon.photos
# adb shell su -c pm disable com.amazon.photos.importer
# adb shell su -c pm disable com.amazon.platform
# adb shell su -c pm disable com.amazon.platform.fdrw
# adb shell su -c pm disable com.amazon.platformsettings
# adb shell su -c pm disable com.amazon.pm
# adb shell su -c pm disable com.amazon.providers
# adb shell su -c pm disable com.amazon.providers.contentsupport
# adb shell su -c pm disable com.amazon.readynowcore
# adb shell su -c pm disable com.amazon.recess
# adb shell su -c pm disable com.amazon.redstone
# adb shell su -c pm disable com.amazon.securitysyncclient
# adb shell su -c pm disable com.amazon.settings.systemupdates
# adb shell su -c pm disable com.amazon.sharingservice.android.client.proxy
# adb shell su -c pm disable com.amazon.shpm
# adb shell su -c pm disable com.amazon.socialplatform
# adb shell su -c pm disable com.amazon.storagemanager
# adb shell su -c pm disable com.amazon.sync.provider.ipc
# adb shell su -c pm disable com.amazon.sync.service
# adb shell su -c pm disable com.amazon.tablet.voicesettings
# adb shell su -c pm disable com.amazon.tabletsubscriptions
# adb shell su -c pm disable com.amazon.tahoe
# adb shell su -c pm disable com.amazon.tcomm
# adb shell su -c pm disable com.amazon.tcomm.client
# adb shell su -c pm disable com.amazon.tv.ottssocompanionapp
# adb shell su -c pm disable com.amazon.unifiedshare.actionchooser
# adb shell su -c pm disable com.amazon.unifiedsharegoodreads
# adb shell su -c pm disable com.amazon.unifiedsharesinaweibo
# adb shell su -c pm disable com.amazon.unifiedsharetwitter
# adb shell su -c pm disable com.amazon.vans.alexatabletshopping.app
adb shell su -c pm disable com.amazon.venezia # Amazon Appstore
adb shell su -c pm disable com.amazon.weather # Weather
# adb shell su -c pm disable com.amazon.webapp
# adb shell su -c pm disable com.amazon.webview
# adb shell su -c pm disable com.amazon.webview.chromium
# adb shell su -c pm disable com.amazon.whisperlink.activityview.android
# adb shell su -c pm disable com.amazon.whisperlink.core.android
# adb shell su -c pm disable com.amazon.whisperplay.contracts
# adb shell su -c pm disable com.amazon.wifilocker
# adb shell su -c pm disable com.amazon.windowshop
# adb shell su -c pm disable com.amazon.zico
# adb shell su -c pm disable com.android.backupconfirm
# adb shell su -c pm disable com.android.bluetooth
# adb shell su -c pm disable com.android.calendar
# adb shell su -c pm disable com.android.captiveportallogin
# adb shell su -c pm disable com.android.certinstaller
# adb shell su -c pm disable com.android.contacts
# adb shell su -c pm disable com.android.defcontainer
# adb shell su -c pm disable com.android.deskclock
# adb shell su -c pm disable com.android.documentsui
# adb shell su -c pm disable com.android.email
# adb shell su -c pm disable com.android.externalstorage
# adb shell su -c pm disable com.android.htmlviewer
# adb shell su -c pm disable com.android.keychain
# adb shell su -c pm disable com.android.location.fused
# adb shell su -c pm disable com.android.managedprovisioning
adb shell su -c pm disable com.android.music # Music
# adb shell su -c pm disable com.android.onetimeinitializer
# adb shell su -c pm disable com.android.packageinstaller
# adb shell su -c pm disable com.android.pacprocessor
# adb shell su -c pm disable com.android.printspooler
# adb shell su -c pm disable com.android.providers.calendar
# adb shell su -c pm disable com.android.providers.contacts
# adb shell su -c pm disable com.android.providers.downloads
# adb shell su -c pm disable com.android.providers.downloads.ui
# adb shell su -c pm disable com.android.providers.media
# adb shell su -c pm disable com.android.providers.settings
# adb shell su -c pm disable com.android.providers.userdictionary
# adb shell su -c pm disable com.android.proxyhandler
# adb shell su -c pm disable com.android.settings
# adb shell su -c pm disable com.android.sharedstoragebackup
# adb shell su -c pm disable com.android.shell
# adb shell su -c pm disable com.android.systemui
# adb shell su -c pm disable com.android.vpndialogs
# adb shell su -c pm disable com.android.wallpapercropper
# adb shell su -c pm disable com.audible.application.kindle
# adb shell su -c pm disable com.dolby
# adb shell su -c pm disable com.github.yeriomin.yalpstore
# adb shell su -c pm disable com.goodreads.kindle
# adb shell su -c pm disable com.here.odnp.service
# adb shell su -c pm disable com.ivona.orchestrator
# adb shell su -c pm disable com.ivona.tts.oem
# adb shell su -c pm disable com.kingsoft.office.amz
# adb shell su -c pm disable com.svox.pico
# adb shell su -c pm disable jp.co.omronsoft.iwnnime.languagepack.zhcn_az
# adb shell su -c pm disable jp.co.omronsoft.iwnnime.mlaz
adb shell su -c pm disable org.mopria.printplugin

adb install ./apks/ru.henridellal.emerald_*.apk # Emerald Launcher
adb install ./apks/com.menny.android.anysoftkeyboard_*.apk # Anysoft Keyboard
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
echo "${bold}Done. You can now install some applications from F-Droid, here's some ideas:${normal}"
echo "AppStore    : Yalp Store (Play Store Alternative)"
echo "Calculator  : Equate"
echo "Email       : FairEmail"
echo "File Manager: Ghost Commander"
echo "Keyboard    : AnySoftKeyboard (Installed in Stage 3)"
echo "MP3 Player  : Vanilla Music"
echo "Launcher    : Emerald Launcher (Installed in Stage 3)"
echo "Weather     : WX"
echo "Web Browser : Icecat"
echo "YouTube     : SkyTube/NewPipe"
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
echo "${bold}If you want to return to completely stock, use Stage 1.${normal}"
_pause
adb shell su -c pm enable amazon.alexa.tablet
adb shell su -c pm enable amazon.fireos
adb shell su -c pm enable amazon.jackson19
adb shell su -c pm enable amazon.speech.sim
adb shell su -c pm enable android
adb shell su -c pm enable android.amazon.perm
adb shell su -c pm enable com.amazon.accessorynotifier
adb shell su -c pm enable com.amazon.acos.providers.UnifiedSettingsProvider
adb shell su -c pm enable com.amazon.advertisingidsettings
adb shell su -c pm enable com.amazon.ags.app
adb shell su -c pm enable com.amazon.alexa.externalmediaplayer.fireos
adb shell su -c pm enable com.amazon.alta.h2clientservice
adb shell su -c pm enable com.amazon.android.marketplace
adb shell su -c pm enable com.amazon.application.compatibility.enforcer
adb shell su -c pm enable com.amazon.application.compatibility.enforcer.sdk.library
adb shell su -c pm enable com.amazon.assetsync.service
adb shell su -c pm enable com.amazon.avod
adb shell su -c pm enable com.amazon.bluetoothinternals
adb shell su -c pm enable com.amazon.calculator
adb shell su -c pm enable com.amazon.camera
adb shell su -c pm enable com.amazon.cardinal
adb shell su -c pm enable com.amazon.client.metrics
adb shell su -c pm enable com.amazon.client.metrics.api
adb shell su -c pm enable com.amazon.cloud9
adb shell su -c pm enable com.amazon.cloud9.contentservice
adb shell su -c pm enable com.amazon.cloud9.kids
adb shell su -c pm enable com.amazon.cloud9.systembrowserprovider
adb shell su -c pm enable com.amazon.communication.discovery
adb shell su -c pm enable com.amazon.connectivitydiag
adb shell su -c pm enable com.amazon.csapp
adb shell su -c pm enable com.amazon.dcp
adb shell su -c pm enable com.amazon.dcp.contracts.framework.library
adb shell su -c pm enable com.amazon.dcp.contracts.library
adb shell su -c pm enable com.amazon.dee.app
adb shell su -c pm enable com.amazon.device.backup
adb shell su -c pm enable com.amazon.device.backup.sdk.internal.library
adb shell su -c pm enable com.amazon.device.bluetoothdfu
adb shell su -c pm enable com.amazon.device.crashmanager
adb shell su -c pm enable com.amazon.device.logmanager
adb shell su -c pm enable com.amazon.device.messaging
adb shell su -c pm enable com.amazon.device.messaging.sdk.internal.library
adb shell su -c pm enable com.amazon.device.messaging.sdk.library
adb shell su -c pm enable com.amazon.device.metrics
adb shell su -c pm enable com.amazon.device.sale.service
adb shell su -c pm enable com.amazon.device.settings
adb shell su -c pm enable com.amazon.device.settings.sdk.internal.library
adb shell su -c pm enable com.amazon.device.software.ota
adb shell su -c pm enable com.amazon.device.software.ota.override
adb shell su -c pm enable com.amazon.device.sync
adb shell su -c pm enable com.amazon.device.sync.sdk.internal
adb shell su -c pm enable com.amazon.digital.asset.ownership.app
adb shell su -c pm enable com.amazon.dp.contacts
adb shell su -c pm enable com.amazon.dp.fbcontacts
adb shell su -c pm enable com.amazon.dp.logger
adb shell su -c pm enable com.amazon.dynamicupdationservice
adb shell su -c pm enable com.amazon.fireinputdevices
adb shell su -c pm enable com.amazon.firelauncher
adb shell su -c pm enable com.amazon.firepowersettings
adb shell su -c pm enable com.amazon.frameworksettings
adb shell su -c pm enable com.amazon.geo.client.maps
adb shell su -c pm enable com.amazon.geo.mapsv2
adb shell su -c pm enable com.amazon.geo.mapsv2.services
adb shell su -c pm enable com.amazon.gloria.graphiq
adb shell su -c pm enable com.amazon.gloria.smarthome
adb shell su -c pm enable com.amazon.h2settingsfortablet
adb shell su -c pm enable com.amazon.identity.auth.device.authorization
adb shell su -c pm enable com.amazon.imp
adb shell su -c pm enable com.amazon.kcp.tutorial
adb shell su -c pm enable com.amazon.kindle
adb shell su -c pm enable com.amazon.kindle.cms
adb shell su -c pm enable com.amazon.kindle.devicecontrols
adb shell su -c pm enable com.amazon.kindle.kso
adb shell su -c pm enable com.amazon.kindle.otter.oobe
adb shell su -c pm enable com.amazon.kindle.otter.oobe.forced.ota
adb shell su -c pm enable com.amazon.kindle.personal_video
adb shell su -c pm enable com.amazon.kindle.rdmdeviceadmin
adb shell su -c pm enable com.amazon.kindle.unifiedSearch
adb shell su -c pm enable com.amazon.kindleautomatictimezone
adb shell su -c pm enable com.amazon.knight.speechui
adb shell su -c pm enable com.amazon.kor.demo
adb shell su -c pm enable com.amazon.legalsettings
adb shell su -c pm enable com.amazon.logan
adb shell su -c pm enable com.amazon.media.session.monitor
adb shell su -c pm enable com.amazon.mp3
adb shell su -c pm enable com.amazon.mw
adb shell su -c pm enable com.amazon.mw.sdk
adb shell su -c pm enable com.amazon.nimh
adb shell su -c pm enable com.amazon.ods.kindleconnect
adb shell su -c pm enable com.amazon.parentalcontrols
adb shell su -c pm enable com.amazon.photos
adb shell su -c pm enable com.amazon.photos.importer
adb shell su -c pm enable com.amazon.platform
adb shell su -c pm enable com.amazon.platform.fdrw
adb shell su -c pm enable com.amazon.platformsettings
adb shell su -c pm enable com.amazon.pm
adb shell su -c pm enable com.amazon.providers
adb shell su -c pm enable com.amazon.providers.contentsupport
adb shell su -c pm enable com.amazon.readynowcore
adb shell su -c pm enable com.amazon.recess
adb shell su -c pm enable com.amazon.redstone
adb shell su -c pm enable com.amazon.securitysyncclient
adb shell su -c pm enable com.amazon.settings.systemupdates
adb shell su -c pm enable com.amazon.sharingservice.android.client.proxy
adb shell su -c pm enable com.amazon.shpm
adb shell su -c pm enable com.amazon.socialplatform
adb shell su -c pm enable com.amazon.storagemanager
adb shell su -c pm enable com.amazon.sync.provider.ipc
adb shell su -c pm enable com.amazon.sync.service
adb shell su -c pm enable com.amazon.tablet.voicesettings
adb shell su -c pm enable com.amazon.tabletsubscriptions
adb shell su -c pm enable com.amazon.tahoe
adb shell su -c pm enable com.amazon.tcomm
adb shell su -c pm enable com.amazon.tcomm.client
adb shell su -c pm enable com.amazon.tv.ottssocompanionapp
adb shell su -c pm enable com.amazon.unifiedshare.actionchooser
adb shell su -c pm enable com.amazon.unifiedsharegoodreads
adb shell su -c pm enable com.amazon.unifiedsharesinaweibo
adb shell su -c pm enable com.amazon.unifiedsharetwitter
adb shell su -c pm enable com.amazon.vans.alexatabletshopping.app
adb shell su -c pm enable com.amazon.venezia
adb shell su -c pm enable com.amazon.weather
adb shell su -c pm enable com.amazon.webapp
adb shell su -c pm enable com.amazon.webview
adb shell su -c pm enable com.amazon.webview.chromium
adb shell su -c pm enable com.amazon.whisperlink.activityview.android
adb shell su -c pm enable com.amazon.whisperlink.core.android
adb shell su -c pm enable com.amazon.whisperplay.contracts
adb shell su -c pm enable com.amazon.wifilocker
adb shell su -c pm enable com.amazon.windowshop
adb shell su -c pm enable com.amazon.zico
adb shell su -c pm enable com.android.backupconfirm
adb shell su -c pm enable com.android.bluetooth
adb shell su -c pm enable com.android.calendar
adb shell su -c pm enable com.android.captiveportallogin
adb shell su -c pm enable com.android.certinstaller
adb shell su -c pm enable com.android.contacts
adb shell su -c pm enable com.android.defcontainer
adb shell su -c pm enable com.android.deskclock
adb shell su -c pm enable com.android.documentsui
adb shell su -c pm enable com.android.email
adb shell su -c pm enable com.android.externalstorage
adb shell su -c pm enable com.android.htmlviewer
adb shell su -c pm enable com.android.keychain
adb shell su -c pm enable com.android.location.fused
adb shell su -c pm enable com.android.managedprovisioning
adb shell su -c pm enable com.android.music
adb shell su -c pm enable com.android.onetimeinitializer
adb shell su -c pm enable com.android.packageinstaller
adb shell su -c pm enable com.android.pacprocessor
adb shell su -c pm enable com.android.printspooler
adb shell su -c pm enable com.android.providers.calendar
adb shell su -c pm enable com.android.providers.contacts
adb shell su -c pm enable com.android.providers.downloads
adb shell su -c pm enable com.android.providers.downloads.ui
adb shell su -c pm enable com.android.providers.media
adb shell su -c pm enable com.android.providers.settings
adb shell su -c pm enable com.android.providers.userdictionary
adb shell su -c pm enable com.android.proxyhandler
adb shell su -c pm enable com.android.settings
adb shell su -c pm enable com.android.sharedstoragebackup
adb shell su -c pm enable com.android.shell
adb shell su -c pm enable com.android.systemui
adb shell su -c pm enable com.android.vpndialogs
adb shell su -c pm enable com.android.wallpapercropper
adb shell su -c pm enable com.audible.application.kindle
adb shell su -c pm enable com.dolby
adb shell su -c pm enable com.github.yeriomin.yalpstore
adb shell su -c pm enable com.goodreads.kindle
adb shell su -c pm enable com.here.odnp.service
adb shell su -c pm enable com.ivona.orchestrator
adb shell su -c pm enable com.ivona.tts.oem
adb shell su -c pm enable com.kingsoft.office.amz
adb shell su -c pm enable com.svox.pico
adb shell su -c pm enable jp.co.omronsoft.iwnnime.languagepack.zhcn_az
adb shell su -c pm enable jp.co.omronsoft.iwnnime.mlaz
adb shell su -c pm enable org.mopria.printplugin
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
		9) exit 0;;
		*) echo -e "${RED}Error...${STD}" && sleep 2
	esac
}

while true
do
 
	show_menus
	read_options
done