# Simple Backup

A very simple backup script with configurable profiles and backup paths that uses tar as file compressor

## Installation

You can simply execute the `example-installer.sh` script for automated install or manual copy the important files to their destination:
```
# cp ./simple-backup /usr/local/bin/
# chmod 755 /usr/local/bin/simple-backup
# cp -r ./etc/{simple-backup.conf,simple-backup.d} /etc/
```

## Usage

Simply call `simple-backup [profile-name(s)]` with your profile name(s) to back up. You can specify multiple profiles at once and _simple-backup_ iterates through every given profile, search for its backup paths and compresses them into one backup file that is stored in the root backup directory in a profile name directory.

You can simply add more profiles and paths by adding a new config file in the config directory which defaults to `/etc/simple-backup.d/` or editing existing files. See [Configuration](#configuration) for more infos.

In the global configuration file which defaults to `/etc/simple-backup.conf` you can adjust the behaviour of simple-backup as you like.See [Configuration](#configuration) for more infos, too.

You can list all available profiles with:
```
$ simple-backup -l|--list
system-config
root-home
log
...
```
and backup all available profiles with:
```
# simple-backup all
Backup directory: /var/backup
...
```

## Configuration

A profile config file can hold up as many profiles as you like where are profile entry is defined as `[profile-name]=[path1] [path2] [path3] ...`. Every profile entry obtain its own line.

A typical profile config file can look like:
```
system-config=/etc /usr/local
root-home=/root
log=/var/log
```

You can add many more profile config files, for example:
```
/etc/simple-backup.d/
|-- system.conf
|-- user.conf
|-- www.conf
|-- server1.conf
|-- ...
```

When profile names overlap then the profile entry in the first profile config file (alphabethical sorted) will be used.

You can also configure simple-backup globally in the main configuration file (default `/etc/simple-backup.conf`).

## Issues and Contributing

If you have any issues or suggestions, feel free to open an [issue](https://github.com/fliegwerk/random-shell-scripts/issues) or write us: <https://www.fliegwerk.com/contact>
