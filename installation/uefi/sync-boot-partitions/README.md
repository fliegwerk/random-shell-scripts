# Sync boot partitions

Holds the backup EFI boot partition with the default EFI boot partition in sync on a Full-System-RAID1 for redundancy purposes.

## Installation

You can simply execute the `installer.sh` script for automated install or manual copy the important files to their destination:
```
# cp ./sync-boot-partitions /usr/local/bin/
# chmod 755 /usr/local/bin/sync-boot-partitions
# cp ./sync-boot-partitions.conf /etc/
# chmod 644 /etc/sync-boot-partitions.conf
```

If you use [pacman](https://www.archlinux.org/pacman/) as your favorite package manager you can install the custom hook with:
```
cp ./999-sync-boot-partitions.hook /etc/pacman.d/hooks/
chmod 644 /etc/pacman.d/hooks/999-sync-boot-partitions.hook
```

## Usage

Simply call `sync-boot-partitions [--only-init]` as root user and the backup EFI boot partition will be synced with the default EFI boot partition. None of the files in the default boot partition were edited or removed only the content in the backup boot partition will be updated or removed according to the other boot partition. You also can only sync the initramfs' in the default boot partition with `sync-boot-partitions [--only-init]`.

This script is especially useful if you have a partitioning layout like:
```
Drive 1 (sda)          Middleware         Drive 2 (sdb)
+------------+                            +------------+
| 1 ESP      | <- sync boot partitions -> | 1 ESP      |
+------------+                            +------------+
| 2 MDRAID1  | <- mdraid kernel module -> | 2 MDRAID1  |
+------------+                            +------------+
|    ...     |                            |    ...     |
```

So do not forget to call `sync-boot-partitions` after you edited the EFI boot partition (e.g. the boot loader configuration).

## Configuration

In the configuration file at `/etc/sync-boot-partitions.conf` you can change the mount paths for default and backup boot partition.

## Issues and Contributing

If you have any issues or suggestions, feel free to open an [issue](https://github.com/fliegwerk/random-shell-scripts/issues) or write us: <https://www.fliegwerk.com/contact>
