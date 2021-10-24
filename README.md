# utils
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
2021.10.24 a bunch of bash-procedures and aliases, for making work with escp-wrapper a bit easier, were added;
