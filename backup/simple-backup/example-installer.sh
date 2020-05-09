#!/bin/sh
set -e

## example installer script for simple backup
## by fliegwerk
## (c) 2020. MIT License

[ "$(id -u)" -ne 0 ] && { printf "Root privileges required\n"; exit 1; }
[ -d "/etc" ] || { printf "/etc does not exist\n"; exit 1; }
[ -d "/usr/local/bin" ] || { printf "/usr/local/bin does not exist\n"; exit 1; }

printf "Install configuration files\n"
cp -r ./etc/simple-backup.conf ./etc/simple-backup.d /etc
chmod 644 /etc/simple-backup.conf
chmod 755 /etc/simple-backup.d
chmod 644 /etc/simple-backup.d/*

printf "Install executable script file\n"
cp ./simple-backup /usr/local/bin
chmod 755 /usr/local/bin/simple-backup

printf "Finished\n"
