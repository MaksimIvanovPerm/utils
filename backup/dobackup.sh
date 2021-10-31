#!/bin/bash

RSYNC="/usr/bin/rsync"
V_FORCE_TO_CREATE_STOREDIR="0" # 1 - create, if store-dir does not exist
V_EXCLUDES="--exclude='/dev/' --exclude='/proc/' --exclude='/tmp/*' --exclude='/cygdrive/' --exclude='/Backup/'"
#V_RSYNC_OPTION="-z --zl=6 --zc=zlib --checksum-choice=xxh64 --checksum --links --recursive --inplace --mkpath --delete --force --verbose"
V_RSYNC_OPTION="--checksum-choice=xxh64 --checksum --links --recursive --inplace --mkpath --delete --force --verbose"
V_FLAG="0"
V_DRYRUN="0"
V_BASEDIR=$(dirname "$0")
V_LOGFILE=$(basename "$0")".log"
V_LOGLINES_LIMIT=50000

usage() {
cat << __EOF__
$(basename "$0") options
-d|--dryrun		just show command which should be executed but do not execute it;
-w|--whatdir		what to backup, directory name with full path to one;
-s|--storedir		where to store backup of directory setted with help of -w|--whatdir key;
-c|--createsdir		Create store-dir if it doesn't exist;
-e|--excludelist	Full name of file, which should contains set of excludings, one in line
			Default value is equivalent to: --exclude='/proc/' --exclude='/tmp/*' --exclude='/cygdrive/'
			Special value: "none", it turns off default;
-h|--help		this help

Log-file will be created in current directory and named as: "$V_LOGFILE", lines amount limit is: "$V_LOGLINES_LIMIT"
TODO:
1+	Truncate logfile to settet amount of lines;
__EOF__
}


output() {
local v_msg="$1"
if [ ! -z "$v_msg" ]; then
	echo "$(date +%Y%m%d:%M%H%S) ${v_msg}" | tee -a "$V_LOGFILE"
fi
}
##### Main routine ####
while [ ! -z "$1" ]
do
	case "$1" in
		"-d"|"--dryrun")
		V_DRYRUN="1"
		shift 1
		;;
		"-c"|"--createsdir")
		V_FORCE_TO_CREATE_STOREDIR="1"
		shift 1
		;;
		"-e"|"--excludelist")
		if [ -z "$2" ]; then
			output "You have to set exclude-list, see $(basename "$0") -h"
			exit 1
		else
			V_EXCLUDES="$2"
			V_FLAG="1"
			shift 2
		fi
		;;
		"-h"|"--help")
			usage
			exit 0
		;;
		"-s"|"--storedir")
		if [ -z "$2" ]; then
			output "You have to set full path to storage-directory;"
			exit 1
		else
			V_STORAGEDIR="$2"
			shift 2
		fi
		;;
		"-w"|"--whatdir")
		if [ -z "$2" ]; then
			output "You have to set full path to backuped-directory;"
			exit 1
		else
			V_WHATDIR="$2"
			shift 2
		fi
		;;
		*)
		output "Unknown arguments ${1}"
		exit 1
		;;
	esac
done

#Checking
if [ ! -d "$V_WHATDIR" ]; then
	output "Object which setted in -w|--whatdir key: is not a directory;"
	exit 1
fi

if [ ! -d "$V_STORAGEDIR" ]; then
	if [ "$V_FORCE_TO_CREATE_STOREDIR" -eq "0" ]; then
		output "Object which setted in -s|--storedir key: is not a directory;"
		exit 1
	else
		mkdir -p "$V_STORAGEDIR"
		[ "$?" -ne "0" ] && {
			output "Can not execute mkdir -p \"$V_STORAGEDIR\""
			exit 1
		}
	fi
fi

output "Ok, let's start backuping ${V_WHATDIR} to ${V_STORAGEDIR}"
if [ "$V_BASEDIR" == "." ]; then
	V_BASEDIR=$(pwd)"/"
fi

if [ "$V_EXCLUDES" == "none" ]; then
	        V_EXCLUDES=""
elif [ ! -z "$V_EXCLUDES" -a "$V_FLAG" -eq "1 " ]; then
	if [ -f "$V_EXCLUDES" ]; then
		while read line
		do
			RSYNC=$( printf "%s --exclude='%s'" "$RSYNC" "$line" )
		done < <(cat "$V_EXCLUDES")
	else
		output "Can not open excludinds-list file: ${V_EXCLUDES}"
		exit 1
	fi
elif [ ! -z "$V_EXCLUDES" -a "$V_FLAG" -eq "0" ]; then
	RSYNC=$( printf "%s %s" "$RSYNC" "$V_EXCLUDES" )
fi

output "${RSYNC} ${V_RSYNC_OPTION} ${V_WHATDIR} ${V_STORAGEDIR}"
if [ "$V_DRYRUN" -eq "0" ]; then
	eval "${RSYNC} ${V_RSYNC_OPTION} \"$V_WHATDIR\" \"$V_STORAGEDIR\"" | tee -a "$V_LOGFILE"
fi

v_lines=$(cat "$V_LOGFILE" | wc -l)
if [ "$v_lines" -gt "$V_LOGLINES_LIMIT" ]; then
	v_lines=$((v_lines-V_LOGLINES_LIMIT))
	sed -i "1,$v_lines d" "$V_LOGFILE"
fi

output "Done with backuping ${V_WHATDIR} to ${V_STORAGEDIR}, logfile is: ${V_BASEDIR}${V_LOGFILE}"
