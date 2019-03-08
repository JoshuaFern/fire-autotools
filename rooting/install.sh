mount -o remount -rw /system
cp /data/local/tmp/su /system/xbin/su
cp /data/local/tmp/su /system/xbin/daemonsu
cp /data/local/tmp/supolicy /system/xbin/
cp /data/local/tmp/libsupol.so /system/lib/
cp /data/local/tmp/libsupol.so /system/lib64/
chmod 0755 /system/xbin/su
chcon u:object_r:system_file:s0 /system/xbin/su
chmod 0755 /system/xbin/daemonsu
chcon u:object_r:system_file:s0 /system/xbin/daemonsu
daemonsu --auto-daemon
exit