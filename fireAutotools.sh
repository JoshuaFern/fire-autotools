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
# Stage #3: Block Amazon Spying
# ----------------------------------------------
three(){
echo "${bold}Stage #3: Block Amazon Spying${normal}"
echo "${bold}Blocking Amazon services from the internet can be a bit tricky, so we'll take a multi-layered approach.${normal}"
echo "${bold}1. Install a host file, this will block many of the domains that Amazon services usually connect to.${normal}"
echo "${bold}   (One side effect of this process: Your wifi icon will have an exclamation mark even when connected correctly.)${normal}"
echo "${bold}2. Install an iptables Firewall (AFWall)${normal}"
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
echo "${bold}Rebooting... Enable the firewall and it's now safe to connect to wifi.${normal}"
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
echo "${bold}If anything does break, it's up to you to diagnose the issue and resolve it.${normal}"
echo "${bold}It will also install Emerald Launcher and AnySoftKeyboard so you're not left with an unusable device.${normal}"
_pause
echo "Remounting /system..."
adb shell su -c mount -o remount -rw /system
echo "Removing Amazon Apps..."
# Many services will continue starting even when disabled, we can delete them directly from system.
# You can customize your applications by commenting out items below this line.
# Alexa Cards
adb shell su -c pm disable amazon.alexa.tablet
adb shell su -c rm -r /system/priv-app/amazon.alexa.tablet
# amazon.fireos (Do not disable.)
# adb shell su -c pm disable amazon.fireos
# adb shell su -c rm -r /system/framework/fireos-res/fireos-res.apk
# amazon.jackson19
adb shell su -c pm disable amazon.jackson19
adb shell su -c rm -r /system/priv-app/amazon.jackson-19
# SpeechInteractionManager
adb shell su -c pm disable amazon.speech.sim
adb shell su -c rm -r /system/priv-app/SpeechInteractionManager
# System (Do not disable.)
# adb shell su -c pm disable android
# adb shell su -c rm -r /system/framework/framework-res.apk
# Fire
adb shell su -c pm disable android.amazon.perm # Fire
adb shell su -c rm -r /system/framework/android.amazon.perm
# Accessory Notifier
adb shell su -c pm disable com.amazon.accessorynotifier
adb shell su -c rm -r /system/priv-app/com.amazon.accessorynotifier
# com.amazon.acos.providers.UnifiedSettingsProvider
adb shell su -c pm disable com.amazon.acos.providers.UnifiedSettingsProvider
adb shell su -c rm -r /system/app/UnifiedSettingsProvider
# Advertising ID
adb shell su -c pm disable com.amazon.advertisingidsettings
adb shell su -c rm -r /system/priv-app/AdvertisingIdSettings
# Amazon GameCircle
adb shell su -c pm disable com.amazon.ags.app
adb shell su -c rm -r /system/priv-app/com.amazon.ags.app
# com.amazon.alexa.externalmediaplayer.fireos
adb shell su -c pm disable com.amazon.alexa.externalmediaplayer.fireos
adb shell su -c rm -r /system/priv-app/com.amazon.alexa.externalmediaplayer.fireos
# H2Application
adb shell su -c pm disable com.amazon.alta.h2clientservice
adb shell su -c rm -r /system/priv-app/com.amazon.h2clientservice
# Marketplace Service Receiver
adb shell su -c pm disable com.amazon.android.marketplace
adb shell su -c rm -r /system/priv-app/marketplace_service_receiver
# Application Compatibility Enforcer
adb shell su -c pm disable com.amazon.application.compatibility.enforcer
adb shell su -c rm -r /system/priv-app/FireApplicationCompatibilityEnforcer
# Fire Application Compatibility Enforcer SDK
adb shell su -c pm disable com.amazon.application.compatibility.enforcer.sdk.library
adb shell su -c rm -r /system/priv-app/FireApplicationCompatibilityEnforcerSDK
# AssetSyncService
adb shell su -c pm disable com.amazon.assetsync.service
adb shell su -c rm -r /system/priv-app/com.amazon.assetsync.service
# Video
adb shell su -c pm disable com.amazon.avod
adb shell su -c rm -r /system/priv-app/com.amazon.avod
# Amazon - Bluetooth Internals
adb shell su -c pm disable com.amazon.bluetoothinternals
adb shell su -c rm -r /system/priv-app/BluetoothInternals
# Calculator
adb shell su -c pm disable com.amazon.calculator
adb shell su -c rm -r /system/priv-app/com.amazon.calculator
# Camera
adb shell su -c pm disable com.amazon.camera
adb shell su -c rm -r /system/priv-app/Camera
# Alexa Video Player
adb shell su -c pm disable com.amazon.cardinal
adb shell su -c rm -r /system/priv-app/com.amazon.cardinal
# Amazon Metrics Service Application
adb shell su -c pm disable com.amazon.client.metrics
adb shell su -c rm -r /system/priv-app/MetricsService
# com.amazon.client.metrics.api
adb shell su -c pm disable com.amazon.client.metrics.api
adb shell su -c rm -r /system/priv-app/MetricsApi
# Silk Browser
adb shell su -c pm disable com.amazon.cloud9
adb shell su -c rm -r /system/priv-app/com.amazon.cloud9
# Silk Content Service
adb shell su -c pm disable com.amazon.cloud9.contentservice
adb shell su -c rm -r /system/priv-app/com.amazon.cloud9.contentservice
# Kids Web Browser
adb shell su -c pm disable com.amazon.cloud9.kids
adb shell su -c rm -r /system/priv-app/com.amazon.cloud9.kids-stub
# System Browser Provider
adb shell su -c pm disable com.amazon.cloud9.systembrowserprovider
adb shell su -c rm -r /system/priv-app/com.amazon.cloud9.systembrowserprovider
# com.amazon.communication.discovery
adb shell su -c pm disable com.amazon.communication.discovery
adb shell su -c rm -r /system/priv-app/com.amazon.communication.discovery
# com.amazon.connectivitydiag
adb shell su -c pm disable com.amazon.connectivitydiag
adb shell su -c rm -r /system/priv-app/ConnectivityDiag
# Help
adb shell su -c pm disable com.amazon.csapp
adb shell su -c rm -r /system/priv-app/com.amazon.csapp
# Amazon Device Middleware Debugging Tool
adb shell su -c pm disable com.amazon.dcp
adb shell su -c rm -r /system/priv-app/com.amazon.FireOsMiddlewareDebugApp
# DCP Contracts Framework
adb shell su -c pm disable com.amazon.dcp.contracts.framework.library
adb shell su -c rm -r /system/priv-app/DeviceClientPlatformContractsFramework
# DCP Platform Contracts
adb shell su -c pm disable com.amazon.dcp.contracts.library
adb shell su -c rm -r /system/priv-app/DeviceSoftwareOTAContracts
# Amazon Alexa
adb shell su -c pm disable com.amazon.dee.app
adb shell su -c rm -r /system/priv-app/com.amazon.dee.app
# Backup and Restore
adb shell su -c pm disable com.amazon.device.backup
adb shell su -c rm -r /system/priv-app/DeviceBackupAndRestore-release
# Amazon Backup and Restore Internal SDK
adb shell su -c pm disable com.amazon.device.backup.sdk.internal.library
adb shell su -c rm -r /system/priv-app/DeviceBackupAndRestoreInternalSDK-release
# Amazon Bluetooth DFU
adb shell su -c pm disable com.amazon.device.bluetoothdfu
adb shell su -c rm -r /system/priv-app/com.amazon.device.bluetoothdfu
# CrashManager
adb shell su -c pm disable com.amazon.device.crashmanager
adb shell su -c rm -r /system/priv-app/CrashManager
# Log Manager
adb shell su -c pm disable com.amazon.device.logmanager
adb shell su -c rm -r /system/priv-app/LogManager-logd
# Amazon Device Messaging (ADM)
adb shell su -c pm disable com.amazon.device.messaging
adb shell su -c rm -r /system/priv-app/DeviceMessagingAndroid
# Amazon Device Messaging Internal SDK
adb shell su -c pm disable com.amazon.device.messaging.sdk.internal.library
adb shell su -c rm -r /system/priv-app/DeviceMessagingAndroidInternalSDK
# Amazon Device Messaging SDK
adb shell su -c pm disable com.amazon.device.messaging.sdk.library
adb shell su -c rm -r /system/priv-app/DeviceMessagingAndroidSDK
# AmazonDeviceMetrics
adb shell su -c pm disable com.amazon.device.metrics
adb shell su -c rm -r /system/app/AmazonDeviceMetrics
# Local Recommendations Service
adb shell su -c pm disable com.amazon.device.sale.service
adb shell su -c rm -r /system/priv-app/FireTvSaleService
# Amazon Device Settings
adb shell su -c pm disable com.amazon.device.settings
adb shell su -c rm -r /system/priv-app/RemoteSettingsAndroid
# Amazon Device Settings Internal SDK
adb shell su -c pm disable com.amazon.device.settings.sdk.internal.library
adb shell su -c rm -r /system/priv-app/RemoteSettingsInternalSDK
# DeviceSoftwareOTA
adb shell su -c pm disable com.amazon.device.software.ota
adb shell su -c rm -r /system/priv-app/DeviceSoftwareOTA
# System Updates
adb shell su -c pm disable com.amazon.device.software.ota.override
adb shell su -c rm -r /system/priv-app/DeviceSoftwareOTAIdleOverride
# Amazon Whispersync DX
adb shell su -c pm disable com.amazon.device.sync
adb shell su -c rm -r /system/priv-app/com.amazon.device.sync
# Amazon Whispersync SDK
adb shell su -c pm disable com.amazon.device.sync.sdk.internal
adb shell su -c rm -r /system/priv-app/com.amazon.device.sync.sdk.internal
# DigitalAssetOwnershipAndroidClient
adb shell su -c pm disable com.amazon.digital.asset.ownership.app
adb shell su -c rm -r /system/priv-app/com.amazon.digital.asset.ownership.app
# Contact Sync Adapter
adb shell su -c pm disable com.amazon.dp.contacts
adb shell su -c rm -r /system/priv-app/com.amazon.dp.contacts
# Facebook Sync Adapter
adb shell su -c pm disable com.amazon.dp.fbcontacts
adb shell su -c rm -r /system/priv-app/com.amazon.dp.fbcontacts
# com.amazon.dp.logger
adb shell su -c pm disable com.amazon.dp.logger
adb shell su -c rm -r /system/priv-app/com.amazon.dp.logger
# Dynamic Updation Service
adb shell su -c pm disable com.amazon.dynamicupdationservice
adb shell su -c rm -r /system/priv-app/com.amazon.dynamicupdationservice
# Fire Input Devices
adb shell su -c pm disable com.amazon.fireinputdevices
adb shell su -c rm -r /system/priv-app/com.amazon.fireinputdevices
# Home Pages
adb shell su -c pm disable com.amazon.firelauncher
adb shell su -c rm -r /system/priv-app/com.amazon.firelauncher
# Power
adb shell su -c pm disable com.amazon.firepowersettings
adb shell su -c rm -r /system/priv-app/com.amazon.firepowersettings
# Blue Shade
adb shell su -c pm disable com.amazon.frameworksettings
adb shell su -c rm -r /system/priv-app/com.amazon.frameworksettings
# Maps
adb shell su -c pm disable com.amazon.geo.client.maps
adb shell su -c rm -r /system/priv-app/com.amazon.geo.client.maps
# Map API v2: Application Support
adb shell su -c pm disable com.amazon.geo.mapsv2
adb shell su -c rm -r /system/priv-app/MapsAPISupportLibrary-release-signed
# Amazon Maps Platform Services V2
adb shell su -c pm disable com.amazon.geo.mapsv2.services
adb shell su -c rm -r /system/priv-app/MapsAPIClientServices-release-signed
# com.amazon.gloria.graphiq
adb shell su -c pm disable com.amazon.gloria.graphiq
adb shell su -c rm -r /system/priv-app/com.amazon.gloria.graphiq
# com.amazon.gloria.smarthome
adb shell su -c pm disable com.amazon.gloria.smarthome
adb shell su -c rm -r /system/priv-app/com.amazon.gloria.smarthome
# Profiles Settings
adb shell su -c pm disable com.amazon.h2settingsfortablet
adb shell su -c rm -r /system/priv-app/com.amazon.h2settingsfortablet
# MobileAuthenticationPlatformAndroid
adb shell su -c pm disable com.amazon.identity.auth.device.authorization
adb shell su -c rm -r /system/priv-app/com.amazon.identity.auth.device.authorization
# Identity Mobile Platform
adb shell su -c pm disable com.amazon.imp
adb shell su -c rm -r /system/priv-app/com.amazon.imp
# Fire Tutorial
adb shell su -c pm disable com.amazon.kcp.tutorial
adb shell su -c rm -r /system/priv-app/com.amazon.kcp.tutorial
# Amazon Kindle
adb shell su -c pm disable com.amazon.kindle
adb shell su -c rm -r /system/priv-app/com.amazon.kindle
# Content Management Service
adb shell su -c pm disable com.amazon.kindle.cms
adb shell su -c rm -r /system/priv-app/com.amazon.kindle.cms-service
# Fire Whispercast
adb shell su -c pm disable com.amazon.kindle.devicecontrols
adb shell su -c rm -r /system/priv-app/com.amazon.kindle.devicecontrols
# Special Offers
adb shell su -c pm disable com.amazon.kindle.kso
adb shell su -c rm -r /system/priv-app/com.amazon.kindle.kso
# Device Setup
adb shell su -c pm disable com.amazon.kindle.otter.oobe
adb shell su -c rm -r /system/priv-app/com.amazon.kindle.otter.oobe
# Forced OTA
adb shell su -c pm disable com.amazon.kindle.otter.oobe.forced.ota
adb shell su -c rm -r /system/priv-app/com.amazon.kindle.otter.oobe.forced.ota
# My Videos
adb shell su -c pm disable com.amazon.kindle.personal_video
adb shell su -c rm -r /system/priv-app/com.amazon.kindle.personal_video
# Remote Device Management Application
adb shell su -c pm disable com.amazon.kindle.rdmdeviceadmin
adb shell su -c rm -r /system/priv-app/com.amazon.kindle.rdmdeviceadmin
# Unified Search
adb shell su -c pm disable com.amazon.kindle.unifiedSearch
adb shell su -c rm -r /system/priv-app/com.amazon.kindle.unifiedSearch
# Auto Timezone Service
adb shell su -c pm disable com.amazon.kindleautomatictimezone
adb shell su -c rm -r /system/priv-app/com.amazon.kindleautomatictimezone
# SpeechUi
adb shell su -c pm disable com.amazon.knight.speechui
adb shell su -c rm -r /system/priv-app/SpeechUiTablet
# Amazon Retail Demo
adb shell su -c pm disable com.amazon.kor.demo
adb shell su -c rm -r /system/priv-app/com.amazon.kor.demo
# Legal Notices
adb shell su -c pm disable com.amazon.legalsettings
adb shell su -c rm -r /system/priv-app/com.amazon.legalsettings
# VoiceView
adb shell su -c pm disable com.amazon.logan
adb shell su -c rm -r /system/priv-app/logan
# MediaSessionMonitor
adb shell su -c pm disable com.amazon.media.session.monitor
adb shell su -c rm -r /system/priv-app/com.amazon.media.session.monitor
# Music
adb shell su -c pm disable com.amazon.mp3
adb shell su -c rm -r /system/priv-app/com.amazon.mp3
# com.amazon.mw
adb shell su -c pm disable com.amazon.mw
adb shell su -c rm -r /system/priv-app/FireflyAppFireOS-release-stub
# com.amazon.mw.sdk
adb shell su -c pm disable com.amazon.mw.sdk
adb shell su -c rm -r /system/priv-app/FireflyIdentifiesSDK-release
# Arcus Android Client
adb shell su -c pm disable com.amazon.nimh
adb shell su -c rm -r /system/priv-app/com.amazon.nimh
# Mayday
adb shell su -c pm disable com.amazon.ods.kindleconnect
adb shell su -c rm -r /system/priv-app/com.amazon.ods.kindleconnect
# Parental Controls
adb shell su -c pm disable com.amazon.parentalcontrols
adb shell su -c rm -r /system/priv-app/com.amazon.parentalcontrols
# Amazon Photos
adb shell su -c pm disable com.amazon.photos
adb shell su -c rm -r /system/priv-app/com.amazon.photos
# Photo Importer
adb shell su -c pm disable com.amazon.photos.importer
adb shell su -c rm -r /system/priv-app/com.amazon.photos.importer
# Amazon Platform
adb shell su -c pm disable com.amazon.platform
adb shell su -c rm -r /system/priv-app/AmazonPlatform-release
# Factory Data Reset Whitelist Manager
adb shell su -c pm disable com.amazon.platform.fdrw
adb shell su -c rm -r /system/app/fdrw
# Platform Remote Settings
adb shell su -c pm disable com.amazon.platformsettings
adb shell su -c rm -r /system/priv-app/com.amazon.platformsettings
# Parental Monitoring Service
adb shell su -c pm disable com.amazon.pm
adb shell su -c rm -r /system/priv-app/com.amazon.pm
# White Listed URL Provider
adb shell su -c pm disable com.amazon.providers
adb shell su -c rm -r /system/app/WhiteListedUrlProvider
# Content Support Manager
adb shell su -c pm disable com.amazon.providers.contentsupport
adb shell su -c rm -r /system/priv-app/ContentSupportProvider
# On Deck
adb shell su -c pm disable com.amazon.readynowcore
adb shell su -c rm -r /system/priv-app/ReadyNowCore-release
# Amazon Recess
adb shell su -c pm disable com.amazon.recess
adb shell su -c rm -r /system/priv-app/FireRecessProxy
# Fire Standard Keyboard
adb shell su -c pm disable com.amazon.redstone
adb shell su -c rm -r /system/priv-app/com.amazon.redstone
# SecuritySyncClient
adb shell su -c pm disable com.amazon.securitysyncclient
adb shell su -c rm -r /system/priv-app/com.amazon.securitysyncclient
# System Updates
adb shell su -c pm disable com.amazon.settings.systemupdates
adb shell su -c rm -r /system/priv-app/SystemUpdatesUI
# SharingServiceAndroidClientProxy
adb shell su -c pm disable com.amazon.sharingservice.android.client.proxy
adb shell su -c rm -r /system/priv-app/com.amazon.sharingservice.android.client.proxy.release
# Shipmode
adb shell su -c pm disable com.amazon.shpm
adb shell su -c rm -r /system/priv-app/shipmode
# Manage Social Networks
adb shell su -c pm disable com.amazon.socialplatform
adb shell su -c rm -r /system/priv-app/com.amazon.socialplatform
# Storage Management
adb shell su -c pm disable com.amazon.storagemanager
adb shell su -c rm -r /system/priv-app/FireStorageManager
# Sync Provider Executor
adb shell su -c pm disable com.amazon.sync.provider.ipc
adb shell su -c rm -r /system/priv-app/sync-provider_ipc-tablet-release
# Content Sync Framework
adb shell su -c pm disable com.amazon.sync.service
adb shell su -c rm -r /system/priv-app/sync-service-fireos-tablet-release
# FireTabletVoiceSettings
adb shell su -c pm disable com.amazon.tablet.voicesettings
adb shell su -c rm -r /system/priv-app/com.amazon.tablet.voicesettings
# Tabletsubscriptions
adb shell su -c pm disable com.amazon.tabletsubscriptions
adb shell su -c rm -r /system/priv-app/com.amazon.tabletsubscriptions
# FreeTime
adb shell su -c pm disable com.amazon.tahoe
adb shell su -c rm -r /system/priv-app/com.amazon.tahoe
# Amazon Communication Services
adb shell su -c pm disable com.amazon.tcomm
adb shell su -c rm -r /system/priv-app/com.amazon.tcomm
# Amazon Communication Services Client Library
adb shell su -c pm disable com.amazon.tcomm.client
adb shell su -c rm -r /system/priv-app/com.amazon.communication
# OttSsoCompanionApp
adb shell su -c pm disable com.amazon.tv.ottssocompanionapp
adb shell su -c rm -r /system/priv-app/com.amazon.tv.ottssocompanionapp
# Chooser Menu
adb shell su -c pm disable com.amazon.unifiedshare.actionchooser
adb shell su -c rm -r /system/priv-app/UnifiedShareActivityChooser
# Amazon Goodreads Share
adb shell su -c pm disable com.amazon.unifiedsharegoodreads
adb shell su -c rm -r /system/priv-app/com.amazon.unifiedsharegoodreads
# Amazon Sina Weibo Share
adb shell su -c pm disable com.amazon.unifiedsharesinaweibo
adb shell su -c rm -r /system/priv-app/com.amazon.unifiedsharesinaweibo
# Amazon Twitter Share
adb shell su -c pm disable com.amazon.unifiedsharetwitter
adb shell su -c rm -r /system/priv-app/com.amazon.unifiedsharetwitter
# AlexaShoppingApp
adb shell su -c pm disable com.amazon.vans.alexatabletshopping.app
adb shell su -c rm -r /system/priv-app/com.amazon.vans.alexatabletshopping.app
# Appstore
adb shell su -c pm disable com.amazon.venezia
adb shell su -c rm -r /system/priv-app/com.amazon.venezia
# Weather
adb shell su -c pm disable com.amazon.weather
adb shell su -c rm -r /system/priv-app/com.amazon.weather
# Kindle Store
adb shell su -c pm disable com.amazon.webapp
adb shell su -c rm -r /system/priv-app/com.amazon.webapp
# AmazonKKWebViewLib
adb shell su -c pm disable com.amazon.webview
adb shell su -c rm -r /system/priv-app/AmazonKKWebViewLib
# Amazon System WebView
adb shell su -c pm disable com.amazon.webview.chromium
adb shell su -c rm -r /system/app/AmazonWebView
# Whisperlink Activity View
adb shell su -c pm disable com.amazon.whisperlink.activityview.android
adb shell su -c rm -r /system/priv-app/WhisperplayActivityView
# WhisperPlay Daemon
adb shell su -c pm disable com.amazon.whisperlink.core.android
adb shell su -c rm -r /system/priv-app/WhisperplayCore
# Whisperlink SDK
adb shell su -c pm disable com.amazon.whisperplay.contracts
adb shell su -c rm -r /system/priv-app/WhisperlinkSdk
# WiFi Locker
adb shell su -c pm disable com.amazon.wifilocker
adb shell su -c rm -r /system/priv-app/CredentialLockerAndroid-tablet-release
# Shop Amazon
adb shell su -c pm disable com.amazon.windowshop
adb shell su -c rm -r /system/priv-app/com.amazon.windowshop
# Documents
adb shell su -c pm disable com.amazon.zico
adb shell su -c rm -r /system/priv-app/com.amazon.zico
# com.android.backupconfirm
adb shell su -c pm disable com.android.backupconfirm
adb shell su -c rm -r /system/priv-app/BackupRestoreConfirmation
# Bluetooth Share
adb shell su -c pm disable com.android.bluetooth
adb shell su -c rm -r /system/app/Bluetooth
# Calendar
adb shell su -c pm disable com.android.calendar
adb shell su -c rm -r /system/priv-app/com.android.calendar
# CaptivePortalLogin
adb shell su -c pm disable com.android.captiveportallogin
adb shell su -c rm -r /system/app/TabletCaptivePortalLogin
# Certificate Installer
adb shell su -c pm disable com.android.certinstaller
adb shell su -c rm -r /system/app/CertInstaller
 # Contacts
adb shell su -c pm disable com.android.contacts
adb shell su -c rm -r /system/priv-app/com.android.contacts
# Package Access Helper (Don't disable)
# adb shell su -c pm disable com.android.defcontainer
# adb shell su -c rm -r /system/priv-app/DefaultContainerService
# Clock
adb shell su -c pm disable com.android.deskclock
adb shell su -c rm -r /system/priv-app/com.android.deskclock
# Documents
adb shell su -c pm disable com.android.documentsui
adb shell su -c rm -r /system/app/DocumentsUI
# Email
adb shell su -c pm disable com.android.email
adb shell su -c rm -r /system/priv-app/com.android.email
# External Storage
adb shell su -c pm disable com.android.externalstorage
adb shell su -c rm -r /system/priv-app/ExternalStorageProvider
# HTML Viewer
adb shell su -c pm disable com.android.htmlviewer
adb shell su -c rm -r /system/app/HTMLViewer
# Key Chain
adb shell su -c pm disable com.android.keychain
adb shell su -c rm -r /system/app/KeyChain
# Fused Location
adb shell su -c pm disable com.android.location.fused
adb shell su -c rm -r /system/priv-app/FusedLocation
# Device Provisioner
adb shell su -c pm disable com.android.managedprovisioning
adb shell su -c rm -r /system/priv-app/ManagedProvisioning
# Music
adb shell su -c pm disable com.android.music
adb shell su -c rm -r /system/app/Music
# One Time Init
adb shell su -c pm disable com.android.onetimeinitializer
adb shell su -c rm -r /system/priv-app/OneTimeInitializer
# Package Installer
# adb shell su -c pm disable com.android.packageinstaller
# adb shell su -c rm -r /system/priv-app/PackageInstaller
# PacProcessor
adb shell su -c pm disable com.android.pacprocessor
adb shell su -c rm -r /system/app/PacProcessor
# Print Spooler
adb shell su -c pm disable com.android.printspooler
adb shell su -c rm -r /system/priv-app/PrintSpooler
# Calendar Storage
adb shell su -c pm disable com.android.providers.calendar
adb shell su -c rm -r /system/priv-app/com.android.providers.calendar
# Contacts Storage
adb shell su -c pm disable com.android.providers.contacts
adb shell su -c rm -r /system/priv-app/com.android.providers.contacts
# Download Manager (Do not disable, breaks apps ability to download.)
# adb shell su -c pm disable com.android.providers.downloads
# adb shell su -c rm -r /system/priv-app/DownloadProvider
# Downloads
adb shell su -c pm disable com.android.providers.downloads.ui
adb shell su -c rm -r /system/priv-app/DownloadProviderUi
# Media Storage
adb shell su -c pm disable com.android.providers.media
adb shell su -c rm -r /system/priv-app/MediaProvider
# Settings Storage
# adb shell su -c pm disable com.android.providers.settings
# adb shell su -c rm -r /system/priv-app/SettingsProvider
# User Dictionary
adb shell su -c pm disable com.android.providers.userdictionary
adb shell su -c rm -r /system/app/UserDictionaryProvider
# ProxyHandler
adb shell su -c pm disable com.android.proxyhandler
adb shell su -c rm -r /system/priv-app/ProxyHandler
# Settings (Removes settings app.)
# adb shell su -c pm disable com.android.settings
# adb shell su -c rm -r /system/priv-app/FireTabletSettings
# com.android.sharedstoragebackup
adb shell su -c pm disable com.android.sharedstoragebackup
adb shell su -c rm -r /system/priv-app/SharedStorageBackup
# Shell
# adb shell su -c pm disable com.android.shell
# adb shell su -c rm -r /system/priv-app/Shell
# System UI (Don't disable)
#adb shell su -c pm disable com.android.systemui
#adb shell su -c rm -r /system/priv-app/SystemUI
# VpnDialogs (Removes VPN functionality.)
# adb shell su -c pm disable com.android.vpndialogs
# adb shell su -c rm -r /system/priv-app/VpnDialogs
# com.android.wallpapercropper
adb shell su -c pm disable com.android.wallpapercropper
adb shell su -c rm -r /system/priv-app/WallpaperCropper
# Audible
adb shell su -c pm disable com.audible.application.kindle
adb shell su -c rm -r /system/priv-app/com.audible.application.kindle
# Dolby Service
adb shell su -c pm disable com.dolby
adb shell su -c rm -r /system/vendor/app/Ds
# Goodreads
adb shell su -c pm disable com.goodreads.kindle
adb shell su -c rm -r /system/priv-app/com.goodreads.kindle
# HERE Positioning
adb shell su -c pm disable com.here.odnp.service
adb shell su -c rm -r /system/priv-app/com.nokia.odnp.service
# IvonaTTSOrchestrator
adb shell su -c pm disable com.ivona.orchestrator
adb shell su -c rm -r /system/priv-app/IvonaTtsOrchestrator
# IVONA TTS
adb shell su -c pm disable com.ivona.tts.oem
adb shell su -c rm -r /system/priv-app/IvonaTTS
# WPS Office for Amazon
adb shell su -c pm disable com.kingsoft.office.amz
adb shell su -c rm -r /system/priv-app/moffice_7.1_default_en00105_multidex_217792
# Pico TTS
adb shell su -c pm disable com.svox.pico
adb shell su -c rm -r /system/app/PicoTts
# Fire Keyboard Simplified Chinese Pack
adb shell su -c pm disable jp.co.omronsoft.iwnnime.languagepack.zhcn_az
adb shell su -c rm -r /system/app/jp.co.omronsoft.iwnnime.languagepack.zhcn_az
# Fire Keyboard (Asian)
adb shell su -c pm disable jp.co.omronsoft.iwnnime.mlaz
adb shell su -c rm -r /system/app/jp.co.omronsoft.iwnnime.mlaz
# Mopria Print Service
adb shell su -c pm disable org.mopria.printplugin
adb shell su -c rm -r /system/app/MopriaPlugin
echo "Installing Emerald Launcher..."
adb install ./apks/ru.henridellal.emerald_*.apk # Emerald Launcher
echo "Installing Anysoft Keyboard..."
adb install ./apks/com.menny.android.anysoftkeyboard_*.apk # Anysoft Keyboard
echo "Installing Busybox Installer..."
adb install ./apks/ru.meefik.busybox_*.apk # Busybox
echo "Installing WebView..."
adb push ./apks/webview.apk /data/local/tmp
adb shell chmod 0644 /data/local/tmp/webview.apk
adb shell su -c mkdir /system/app/webview
adb shell su -c mv /data/local/tmp/webview.apk /system/app/webview
adb install ./apks/webview.apk # Bromite Webview
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
echo "${bold}Use the Busybox App to install it on your device.${normal}"
echo "${bold}Remember to allow apps you want to use the internet through AFWall firewall.${normal}"
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
echo "${bold}Check inside the app for a green checkmark and then you can install any modules you want to use.${normal}"
_pause
}

# ----------------------------------------------
# Stage #6:
# ----------------------------------------------
#six(){
#
#}

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