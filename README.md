# utils
## backup
It's rsync-based bash-script, for incrementally updating backup of given directory;

It uses rsync ability to determine (by checksum): has a given file changed or not, since moment of time when it was backed up last time;
So, after first and full backup, of a given directory, was made, all following backup-operations, of this directory and to this backup: are just updating changed files there, and deliting file(s) there, which was|were deleted in backuped directory;
In another words it's syncronising operations, whcih performed in incremental, fast way;

Technically backup operation is performed by `dobackup.sh` bash-script;
List of directories, which should be backed up, options of backup operation and backup-destination - where to backup given directory: all of this should be wroted in `execute_backups.sh` bash-script;
For manual launching backup operation bash-alias `dobackup` is defined, in `.bashrc`
## escp 
tcl-wrapper for scp-utility; 
It uses expect for sending password to scp;
Password, in my case, stored in pass-utility and obtained from there automatically;
It uses several env-variables:
```PASS_PATH=
SOURCE_FILE=
SOURCE_HOST_NAME=
SOURCE_OS_USER=
TARGET_FILE=
TARGET_HOST_NAME=
TARGET_OS_USER=```
And it usefull to define bash-alias, in your bashrc, for viewing this env-variable and their values:
```
alias show_escp='env | egrep "^(SOURCE|TARGET|PASS_PATH).*" | sort -k 1 -t "="'
```
2021.10.24 a bunch of bash-procedures and bash-aliases, for making work with escp-wrapper a bit easier, were added; 
I preferred to collect those proc and aliases to .bashrc
