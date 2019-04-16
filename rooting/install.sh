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
retry_(){
echo 0 >> /sdcard/retry_
echo "Retrying..."
exit
}
rm /sdcard/retry_ 2>/dev/null
mount -o remount -rw /system
[ -w /system ] && echo "Mounted. Copying files..." || retry_
cp /data/local/tmp/su /system/xbin/su
cp /data/local/tmp/su /system/xbin/daemonsu
cp /data/local/tmp/supolicy /system/xbin/
cp /data/local/tmp/libsupol.so /system/lib/
cp /data/local/tmp/libsupol.so /system/lib64/
echo "Setting permissions..."
chmod 0755 /system/xbin/su
chcon u:object_r:system_file:s0 /system/xbin/su
chmod 0755 /system/xbin/daemonsu
chcon u:object_r:system_file:s0 /system/xbin/daemonsu
clear
echo "Congratulations! Rooting successful!"
echo "Open SuperSU app and update the binary using normal mode, you don't have to reboot when prompted.${normal}"
echo "Set SuperSU default access mode to 'Grant' the prompt mode doesn't work on FireOS.${normal}"
echo "Done. Press CTRL+C to exit and start Stage 3: Block Amazon Spying"
daemonsu --auto-daemon
exit