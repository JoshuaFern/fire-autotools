#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
#!/bin/bash

_pause(){
    read -n1 -rsp $'Press any key to continue or Ctrl+C to exit...\n'
    }
bold=$(tput bold)
normal=$(tput sgr0)

# function to display menus
show_menus() {
	clear
	echo " "
	echo "${bold}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${normal}"	
	echo "${bold}       Fire Autotools        ${normal}"
	echo "${bold}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${normal}"
	echo "${bold}This script assumes you have ADB.${normal}"
	echo "${bold}Please read the instructions carefully.${normal}"
	echo "Stage #1: Automated Recovery"
	echo "Stage #2: Automated Rooting"
	echo "Stage #3: Block Amazon Spying"
	echo "Stage #4: Disable Amazon Apps & Install F-Droid"
	echo "Stage #5: Xposed Framework Installer"
	echo "       9: Exit"
	echo " "
}

# ----------------------------------------------
# Stage #1: Automated Recovery
# ----------------------------------------------
one(){
echo "${bold}Welcome to Stage #1: Automated Recovery${normal}"
echo "${bold}https://www.amazon.com/gp/help/customer/display.html/ref=hp_bc_nav?ie=UTF8&nodeId=200529680${normal}"
echo "${bold}Place the image for your device in the ./image/ folder. Do not attempt to downgrade to an older version.${normal}"
echo "${bold}Be warned that the rooting method could be patched in future versions. 5.3.6.4 is the current version.${normal}"
echo "${bold}1. Enter recovery with the power button and left volume held down with USB plugged in.${normal}"
echo "${bold}2. Select 'wipe data/factory reset' (optional)${normal}"
echo "${bold}3. Select 'apply update from ADB'.${normal}"
_pause
echo "Attempting to sideload..."
adb sideload ./image/update-kindle-*.bin
echo "${bold}Complete, select 'reboot system now'.${normal}"
echo "${bold}Do not connect your fire to wifi on reboot.${normal}"
echo "${bold}Select a passworded wifi, click cancel, and select 'NOT NOW' to continue without wifi.${normal}"
echo "${bold}Open Settings > Device Options and tap repeatedly on Serial Number until 'Developer Options' appears.${normal}"
echo "${bold}Enable ADB and check 'Always allow from this computer.' and 'OK' when prompted.${normal}"
echo "${bold}Done. Continue to Stage 2: Rooting.${normal}"
_pause
}

# ----------------------------------------------
# Stage #2: Automated Rooting
# ----------------------------------------------
two(){
echo "${bold}Welcome to Stage #2: Automated Rooting${normal}"
echo "${bold}Thanks to diplomatic for this method.${normal}"
_pause
echo "Making sure wifi is disabled..."
adb shell su -c svc wifi disable
echo "Copying root files..."
adb shell rm /data/local/tmp/mtk-su /data/local/tmp/install.sh
adb push ./rooting/arm64/su ./rooting/arm64/supolicy ./rooting/arm64/libsupol.so ./rooting/arm64/mtk-su ./rooting/install.sh /data/local/tmp
echo "Setting permissions..."
adb shell chmod 0755 /data/local/tmp/mtk-su /data/local/tmp/install.sh
echo "Attempting to root..."
echo "${bold}You should end up at a root command prompt, execute this command:${normal}"
echo "${bold}exec /data/local/tmp/install.sh${normal}"
echo "${bold}If this command hangs or you see permission errors, rooting failed. Try again from Stage 2.${normal}"
adb shell ./data/local/tmp/mtk-su
echo "${bold}We're about to install the SuperSU app, exit at this point if you want to install something yourself.${normal}"
_pause
echo "Installing SuperSU..."
adb install ./rooting/eu.chainfire.supersu.*.apk
echo "${bold}Open SuperSU app and update the binary using normal mode, reboot when prompted.${normal}"
echo "${bold}Set SuperSU default access mode to 'Grant' the prompt mode doesn't work on FireOS.${normal}"
echo "${bold}Done. Continue to Stage 3: Disable Spying.${normal}"
_pause
}

# ----------------------------------------------
# Stage #3: Block Amazon Spying (Optional)
# ----------------------------------------------
three(){
echo "${bold}Stage #3: Block Amazon Spying${normal}"
echo "${bold}Blocking Amazon services from the internet can be a bit tricky, so we'll take a multi-layered approach.${normal}"
echo "${bold}1. Install a host file, this will block many of the domains that Amazon services usually connect to.${normal}"
echo "${bold}   (One side effect of this process: Your wifi icon will have an exclamation mark even when connected correctly.)${normal}"
echo "${bold}2. Install a Firewall (AFWall)${normal}"
_pause
echo "Making sure device wifi is disabled..."
adb shell su -c svc wifi disable
echo "Applying hosts file..."
adb push ./other/hosts /data/local/tmp
adb shell su -c mount -o remount -rw /system
adb shell su -c mv /data/local/tmp/hosts /etc/hosts
echo "Installing AFWall..."
adb install ./apks/dev.ukanth.ufirewall_*.apk
adb shell su -c svc power reboot
echo "${bold}Rebooting... It's now safe to connect to wifi.${normal}"
echo "${bold}Beware that data may leak to servers not in the hosts file during a narrow timeframe between booting and the firewall starting.${normal}"
echo "${bold}You can mitigate this by turning off wifi before rebooting.${normal}"
echo "${bold}Done. Continue to Stage 4: Bloat Removal.${normal}"
}

# ----------------------------------------------
# Stage #4: Disable Amazon Apps & Install F-Droid
# ----------------------------------------------
four(){
echo "${bold}Welcome to Stage #4: Disable Amazon Apps & Install F-Droid${normal}"
echo "${bold}This will attempt to agressively disable as much as possible without breaking core functionality.${normal}"
echo "${bold}It will also install Emerald Launcher and AnySoftKeyboard so you're not left with an unusable device.${normal}"
echo "${bold}You may replace these later.${normal}"
_pause
echo "Disabling Amazon Apps..."
# Some services will continue starting even when disabled.
adb shell su -c pm disable amazon.alexa.tablet # Alexa Cards
# adb shell su -c pm disable amazon.fireos # (Do not disable, bootloop.)
adb shell su -c pm disable amazon.jackson19
adb shell su -c pm disable amazon.speech.sim # SpeechInteractionManager
# adb shell su -c pm disable android # System
adb shell su -c pm disable android.amazon.perm # Fire
adb shell su -c pm disable com.amazon.accessorynotifier # Accessory Notifier
adb shell su -c pm disable com.amazon.acos.providers.UnifiedSettingsProvider
adb shell su -c pm disable com.amazon.advertisingidsettings # Advertising ID
adb shell su -c pm disable com.amazon.ags.app # Amazon GameCircle
adb shell su -c pm disable com.amazon.alexa.externalmediaplayer.fireos
adb shell su -c pm disable com.amazon.alta.h2clientservice # H2Application
adb shell su -c pm disable com.amazon.android.marketplace # Marketplace Service Receiver
adb shell su -c pm disable com.amazon.application.compatibility.enforcer # Application Compatibility Enforcer
adb shell su -c pm disable com.amazon.application.compatibility.enforcer.sdk.library # Fire Application Compatibility Enforcer SDK
adb shell su -c pm disable com.amazon.assetsync.service # AssetSyncService
adb shell su -c pm disable com.amazon.avod # Video
adb shell su -c pm disable com.amazon.bluetoothinternals # Amazon - Bluetooth Internals
adb shell su -c pm disable com.amazon.calculator # Calculator
adb shell su -c pm disable com.amazon.camera # Camera
adb shell su -c pm disable com.amazon.cardinal # Alexa Video Player
adb shell su -c pm disable com.amazon.client.metrics # Amazon Metrics Service Application
adb shell su -c pm disable com.amazon.client.metrics.api
adb shell su -c pm disable com.amazon.cloud9 # Silk Browser
adb shell su -c pm disable com.amazon.cloud9.contentservice # Silk Content Service
adb shell su -c pm disable com.amazon.cloud9.kids # Kids Web Browser
adb shell su -c pm disable com.amazon.cloud9.systembrowserprovider # System Browser Provider
adb shell su -c pm disable com.amazon.communication.discovery
adb shell su -c pm disable com.amazon.connectivitydiag
adb shell su -c pm disable com.amazon.csapp # Help
adb shell su -c pm disable com.amazon.dcp # Amazon Device Middleware Debugging Tool
adb shell su -c pm disable com.amazon.dcp.contracts.framework.library # DCP Contracts Framework
adb shell su -c pm disable com.amazon.dcp.contracts.library # DCP Platform Contracts
adb shell su -c pm disable com.amazon.dee.app # Amazon Alexa
adb shell su -c pm disable com.amazon.device.backup # Backup and Restore
adb shell su -c pm disable com.amazon.device.backup.sdk.internal.library # Amazon Backup and Restore Internal SDK
adb shell su -c pm disable com.amazon.device.bluetoothdfu # Amazon Bluetooth DFU
adb shell su -c pm disable com.amazon.device.crashmanager # CrashManager
adb shell su -c pm disable com.amazon.device.logmanager # Log Manager
adb shell su -c pm disable com.amazon.device.messaging # Amazon Device Messaging (ADM)
adb shell su -c pm disable com.amazon.device.messaging.sdk.internal.library # Amazon Device Messaging Internal SDK
adb shell su -c pm disable com.amazon.device.messaging.sdk.library # Amazon Device Messaging SDK
adb shell su -c pm disable com.amazon.device.metrics # AmazonDeviceMetrics
adb shell su -c pm disable com.amazon.device.sale.service # Local Recommendations Service
adb shell su -c pm disable com.amazon.device.settings # Amazon Device Settings
adb shell su -c pm disable com.amazon.device.settings.sdk.internal.library # Amazon Device Settings Internal SDK
adb shell su -c pm disable com.amazon.device.software.ota # DeviceSoftwareOTA
adb shell su -c pm disable com.amazon.device.software.ota.override # System Updates
adb shell su -c pm disable com.amazon.device.sync # Amazon Whispersync DX
adb shell su -c pm disable com.amazon.device.sync.sdk.internal # Amazon Whispersync SDK
adb shell su -c pm disable com.amazon.digital.asset.ownership.app # DigitalAssetOwnershipAndroidClient
adb shell su -c pm disable com.amazon.dp.contacts # Contact Sync Adapter
adb shell su -c pm disable com.amazon.dp.fbcontacts # Facebook Sync Adapter
adb shell su -c pm disable com.amazon.dp.logger
adb shell su -c pm disable com.amazon.dynamicupdationservice # Dynamic Updation Service
adb shell su -c pm disable com.amazon.fireinputdevices # Fire Input Devices
adb shell su -c pm disable com.amazon.firelauncher # Home Pages
adb shell su -c pm disable com.amazon.firepowersettings # Power
adb shell su -c pm disable com.amazon.frameworksettings # Blue Shade
adb shell su -c pm disable com.amazon.geo.client.maps # Maps
adb shell su -c pm disable com.amazon.geo.mapsv2 # Map API v2: Application Support
adb shell su -c pm disable com.amazon.geo.mapsv2.services # Amazon Maps Platform Services V2
adb shell su -c pm disable com.amazon.gloria.graphiq
adb shell su -c pm disable com.amazon.gloria.smarthome
adb shell su -c pm disable com.amazon.h2settingsfortablet # Profiles Settings
adb shell su -c pm disable com.amazon.identity.auth.device.authorization # MobileAuthenticationPlatformAndroid
adb shell su -c pm disable com.amazon.imp # Identity Mobile Platform
adb shell su -c pm disable com.amazon.kcp.tutorial # Fire Tutorial
adb shell su -c pm disable com.amazon.kindle # Amazon Kindle
adb shell su -c pm disable com.amazon.kindle.cms # Content Management Service
adb shell su -c pm disable com.amazon.kindle.devicecontrols # Fire Whispercast
adb shell su -c pm disable com.amazon.kindle.kso # Special Offers
adb shell su -c pm disable com.amazon.kindle.otter.oobe # Device Setup
adb shell su -c pm disable com.amazon.kindle.otter.oobe.forced.ota # Forced OTA
adb shell su -c pm disable com.amazon.kindle.personal_video # My Videos
adb shell su -c pm disable com.amazon.kindle.rdmdeviceadmin # Remote Device Management Application
adb shell su -c pm disable com.amazon.kindle.unifiedSearch # Unified Search
adb shell su -c pm disable com.amazon.kindleautomatictimezone # Auto Timezone Service
adb shell su -c pm disable com.amazon.knight.speechui # SpeechUi
adb shell su -c pm disable com.amazon.kor.demo # Amazon Retail Demo
adb shell su -c pm disable com.amazon.legalsettings # Legal Notices
adb shell su -c pm disable com.amazon.logan # VoiceView
adb shell su -c pm disable com.amazon.media.session.monitor # MediaSessionMonitor
adb shell su -c pm disable com.amazon.mp3 # Music
adb shell su -c pm disable com.amazon.mw
adb shell su -c pm disable com.amazon.mw.sdk
adb shell su -c pm disable com.amazon.nimh # Arcus Android Client
adb shell su -c pm disable com.amazon.ods.kindleconnect # Mayday
adb shell su -c pm disable com.amazon.parentalcontrols # Parental Controls
adb shell su -c pm disable com.amazon.photos # Amazon Photos
adb shell su -c pm disable com.amazon.photos.importer # Photo Importer
adb shell su -c pm disable com.amazon.platform # Amazon Platform
adb shell su -c pm disable com.amazon.platform.fdrw # Factory Data Reset Whitelist Manager
adb shell su -c pm disable com.amazon.platformsettings # Platform Remote Settings
adb shell su -c pm disable com.amazon.pm # Parental Monitoring Service
adb shell su -c pm disable com.amazon.providers # White Listed URL Provider
adb shell su -c pm disable com.amazon.providers.contentsupport # Content Support Manager
adb shell su -c pm disable com.amazon.readynowcore # On Deck
adb shell su -c pm disable com.amazon.recess # Amazon Recess
adb shell su -c pm disable com.amazon.redstone # Fire Standard Keyboard
adb shell su -c pm disable com.amazon.securitysyncclient # SecuritySyncClient
adb shell su -c pm disable com.amazon.settings.systemupdates # System Updates
adb shell su -c pm disable com.amazon.sharingservice.android.client.proxy # SharingServiceAndroidClientProxy
adb shell su -c pm disable com.amazon.shpm # Shipmode
adb shell su -c pm disable com.amazon.socialplatform # Manage Social Networks
adb shell su -c pm disable com.amazon.storagemanager # Storage Management
adb shell su -c pm disable com.amazon.sync.provider.ipc # Sync Provider Executor
adb shell su -c pm disable com.amazon.sync.service # Content Sync Framework
adb shell su -c pm disable com.amazon.tablet.voicesettings # FireTabletVoiceSettings
adb shell su -c pm disable com.amazon.tabletsubscriptions # Tabletsubscriptions
adb shell su -c pm disable com.amazon.tahoe # FreeTime
adb shell su -c pm disable com.amazon.tcomm # Amazon Communication Services
adb shell su -c pm disable com.amazon.tcomm.client # Amazon Communication Services Client Library
adb shell su -c pm disable com.amazon.tv.ottssocompanionapp # OttSsoCompanionApp
adb shell su -c pm disable com.amazon.unifiedshare.actionchooser # Chooser Menu
adb shell su -c pm disable com.amazon.unifiedsharegoodreads # Amazon Goodreads Share
adb shell su -c pm disable com.amazon.unifiedsharesinaweibo # Amazon Sina Weibo Share
adb shell su -c pm disable com.amazon.unifiedsharetwitter # Amazon Twitter Share
adb shell su -c pm disable com.amazon.vans.alexatabletshopping.app # AlexaShoppingApp
adb shell su -c pm disable com.amazon.venezia # Appstore
adb shell su -c pm disable com.amazon.weather # Weather
adb shell su -c pm disable com.amazon.webapp # Kindle Store
# adb shell su -c pm disable com.amazon.webview # AmazonKKWebViewLib
# adb shell su -c pm disable com.amazon.webview.chromium # Amazon System WebView (Do not disable, breaks apps.)
adb shell su -c pm disable com.amazon.whisperlink.activityview.android # Whisperlink Activity View
adb shell su -c pm disable com.amazon.whisperlink.core.android # WhisperPlay Daemon
adb shell su -c pm disable com.amazon.whisperplay.contracts # Whisperlink SDK
adb shell su -c pm disable com.amazon.wifilocker # WiFi Locker
adb shell su -c pm disable com.amazon.windowshop # Shop Amazon
adb shell su -c pm disable com.amazon.zico # Documents
adb shell su -c pm disable com.android.backupconfirm
adb shell su -c pm disable com.android.bluetooth # Bluetooth Share
adb shell su -c pm disable com.android.calendar # Calendar
adb shell su -c pm disable com.android.captiveportallogin # CaptivePortalLogin
adb shell su -c pm disable com.android.certinstaller # Certificate Installer
adb shell su -c pm disable com.android.contacts # Contacts
# adb shell su -c pm disable com.android.defcontainer # Package Access Helper
adb shell su -c pm disable com.android.deskclock # Clock
adb shell su -c pm disable com.android.documentsui # Documents
adb shell su -c pm disable com.android.email # Email
# adb shell su -c pm disable com.android.externalstorage # External Storage
adb shell su -c pm disable com.android.htmlviewer # HTML Viewer
adb shell su -c pm disable com.android.keychain # Key Chain
adb shell su -c pm disable com.android.location.fused # Fused Location
# adb shell su -c pm disable com.android.managedprovisioning # Device Provisioner
adb shell su -c pm disable com.android.music # Music
adb shell su -c pm disable com.android.onetimeinitializer # One Time Init
# adb shell su -c pm disable com.android.packageinstaller # Package Installer (Don't disable, can't install apps.)
adb shell su -c pm disable com.android.pacprocessor # PacProcessor
adb shell su -c pm disable com.android.printspooler # Print Spooler
adb shell su -c pm disable com.android.providers.calendar # Calendar Storage
adb shell su -c pm disable com.android.providers.contacts # Contacts Storage
# adb shell su -c pm disable com.android.providers.downloads # Download Manager (Do not disable, breaks apps ability to download.)
adb shell su -c pm disable com.android.providers.downloads.ui # Downloads
adb shell su -c pm disable com.android.providers.media # Media Storage
# adb shell su -c pm disable com.android.providers.settings # Settings Storage
adb shell su -c pm disable com.android.providers.userdictionary # User Dictionary
adb shell su -c pm disable com.android.proxyhandler # ProxyHandler
# adb shell su -c pm disable com.android.settings # Settings (Removes settings app.)
adb shell su -c pm disable com.android.sharedstoragebackup
# adb shell su -c pm disable com.android.shell # Shell
# adb shell su -c pm disable com.android.systemui # System UI (Don't disable)
# adb shell su -c pm disable com.android.vpndialogs # VpnDialogs (Removes VPN functionality.)
adb shell su -c pm disable com.android.wallpapercropper
adb shell su -c pm disable com.audible.application.kindle # Audible
adb shell su -c pm disable com.dolby # Dolby Service (Unable to disable)
adb shell su -c pm disable com.goodreads.kindle # Goodreads
adb shell su -c pm disable com.here.odnp.service # HERE Positioning
adb shell su -c pm disable com.ivona.orchestrator # IvonaTTSOrchestrator
adb shell su -c pm disable com.ivona.tts.oem # IVONA TTS
adb shell su -c pm disable com.kingsoft.office.amz # WPS Office for Amazon
adb shell su -c pm disable com.svox.pico # Pico TTS
adb shell su -c pm disable jp.co.omronsoft.iwnnime.languagepack.zhcn_az # Fire Keyboard Simplified Chinese Pack
adb shell su -c pm disable jp.co.omronsoft.iwnnime.mlaz # Fire Keyboard (Asian)
adb shell su -c pm disable org.mopria.printplugin # Mopria Print Service
echo "Remounting /system..."
adb shell su -c mount -o remount -rw /system
echo "Deleting apps..."
adb shell su -c rm -r /system/priv-app/SpeechInteractionManager # Prevents a battery wasting loop.
echo "Installing Emerald Launcher..."
adb install ./apks/ru.henridellal.emerald_*.apk # Emerald Launcher
echo "Installing Anysoft Keyboard..."
adb install ./apks/com.menny.android.anysoftkeyboard_*.apk # Anysoft Keyboard
echo "Installing Busybox Installer..."
adb install ./apks/ru.meefik.busybox_*.apk # Busybox
echo "Installing F-Droid..."
adb install ./apks/org.fdroid.fdroid_*.apk # F-Droid
echo "Installing F-Droid Privileged Extension..."
adb push ./apks/org.fdroid.fdroid.privileged_2090.apk /data/local/tmp
adb shell su -c mv /data/local/tmp/org.fdroid.fdroid.privileged_2090.apk /system/priv-app
adb shell su -c svc power reboot
echo "${bold}Done. Your device will reboot.${normal}"
echo "${bold}You can now install some applications from F-Droid, here's some ideas:${normal}"
echo "AppStore    : Yalp Store/Aurora Store (Play Store Alternatives)"
echo "Backup      : oandbackup"
echo "Books       : Book Reader"
echo "Calculator  : Equate"
echo "Camera      : Open Camera/Simple Camera"
echo "Clock       : Simple Clock"
echo "Email       : FairEmail/Tutanota/K9"
echo "File Manager: Ghost Commander"
echo "Keyboard    : AnySoftKeyboard (Installed)"
echo "Maps        : OsmAnd"
echo "MP3 Player  : Vanilla Music"
echo "Launcher    : Emerald Launcher (Installed)"
echo "Weather     : WX"
echo "Web Browser : Icecat/Fennec/Privacy Browser"
echo "YouTube     : SkyTube/NewPipe"
echo "${bold}Use the Busybox Application to install it on your device.${normal}"
_pause
}

# ----------------------------------------------
# Stage #5: Xposed Framework Installer
# ----------------------------------------------
five(){
echo "${bold}Welcome to Stage #5: Xposed Framework Installer${normal}"
echo "${bold}This will install the Material Design Xposed Installer and give instructions on how to use it.${normal}"
echo "${bold}You will need tablet Wifi connected for this process.${normal}"
_pause
adb install ./apks/XposedInstaller*.apk
echo "${bold}Please open the app, go to the official tab and install the latest ARM64 version.${normal}"
echo "${bold}You will recieve an error during install. This is normal, continue only after this has happened.${normal}"
_pause
echo "Disabling wifi..."
adb shell su -c svc wifi disable
echo "Mounting /system read/write..."
adb shell su -c mount -o remount -rw /system
echo "Fixing xposed..."
adb shell su -c rm /system/bin/app_process64_xposed
adb shell su -c svc power reboot
echo "${bold}Done. Your device will reboot.${normal}"
echo "${bold}Check inside the app for a green checkmark.${normal}"
_pause
}

# ----------------------------------------------
# Stage #6:
# ----------------------------------------------
six(){

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
		6) six ;;
		9) exit 0;;
		*) echo -e "${RED}Error...${STD}" && sleep 2
	esac
}

while true
do
 
	show_menus
	read_options
done