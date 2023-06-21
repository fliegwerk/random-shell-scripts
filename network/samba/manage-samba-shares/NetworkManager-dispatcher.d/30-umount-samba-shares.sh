#!/bin/sh

UUID1="0e51c112-3eee-4f06-a8f6-bb9e4040c547"  # wired profile enp2s0_Testsignal_AW
UUID2="8257a10f-ed4e-4e63-bb06-6d8603502d80"  # wireless profile wlp3s0_Testsignal_AW

case "$2" in
    pre-down|down)
        if [ "$CONNECTION_UUID" = "$UUID1" ] || [ "$CONNECTION_UUID" = "$UUID2" ]; then
            /usr/local/bin/manage-samba-shares umount
        fi
        ;;
esac
