Mtk-su is a superuser tool for some Mediatek 64-bit Android devices,
developed by diplomatic.

OPTIONS

mtk-su [-v] [-s | -c <command>]

-v
	Verbose mode
-s
	Print kernel symbol table
-c
	Try to run command <command> as superuser. Default /system/bin/sh.


To get a temporary privileged shell:
1. Push mtk-su to /data/local/tmp
2. Give exec permissions to mtk-su
3. Run ./mtk-su
