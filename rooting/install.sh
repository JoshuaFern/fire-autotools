echo "Remounting /system to read/write..."
mount -o remount -rw /system
echo "Copying su binaries into /system/xbin..."
cp /data/local/tmp/su /system/xbin/su
cp /data/local/tmp/su /system/xbin/daemonsu
cp /data/local/tmp/supolicy /system/xbin/
cp /data/local/tmp/libsupol.so /system/lib/
cp /data/local/tmp/libsupol.so /system/lib64/
echo "Setting permissions..."
chmod 0755 /system/xbin/su
chcon u:object_r:system_file:s0/system/xbin/su
chmod 0755 /system/xbin/daemonsu
chcon u:object_r:system_file:s0 /system/xbin/daemonsu
echo "Starting daemonsu..."
daemonsu --auto-daemon
echo "If you saw permission errors the root failed, try again."
echo "Otherwise you're rooted! Type exit to end this session."