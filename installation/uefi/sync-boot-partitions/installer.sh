#!/bin/sh

set -e

## installer for sync boot partitions
## by fliegwerk
## (c) 2020. MIT License

[ "$(id -u)" -ne 0 ] && { printf "Root privileges required\n"; exit 1; }
[ -d "/etc" ] || { printf "/etc does not exist\n"; exit 1; }
[ -d "/usr/local/bin" ] || { printf "/usr/local/bin does not exist\n"; exit 1; }

printf "Install configuration files\n"
cp ./sync-boot-partitions.conf /etc
chmod 644 /sync-boot-partitions.conf

printf "Install executable script file\n"
cp ./sync-boot-partitions /usr/local/bin
chmod 755 /usr/local/bin/sync-boot-partitions

if [ -d "/etc/pacman.d/hooks" ]; then
    printf "Pacman detected. Install hook\n"
    cp ./999-sync-boot-partitions.hook /etc/pacman.d/hooks
    chmod 644 /etc/pacman.d/hooks/999-sync-boot-partitions.hook
fi

printf "Finished\n"
