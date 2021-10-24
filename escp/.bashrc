
# To the extent possible under law, the author(s) have dedicated all
# copyright and related and neighboring rights to this software to the
# public domain worldwide. This software is distributed without any warranty.
# You should have received a copy of the CC0 Public Domain Dedication along
# with this software.
# If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

# base-files version 4.3-3

# ~/.bashrc: executed by bash(1) for interactive shells.

# The latest version as installed by the Cygwin Setup program can
# always be found at /etc/defaults/etc/skel/.bashrc

# Modifying /etc/skel/.bashrc directly will prevent
# setup from updating it.

# The copy in your home directory (~/.bashrc) is yours, please
# feel free to customise it to create a shell
# environment to your liking.  If you feel a change
# would be benifitial to all, please feel free to send
# a patch to the cygwin mailing list.

# User dependent .bashrc file

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Shell Options
#
# See man bash for more options...
#
# Don't wait for job termination notification
# set -o notify
#
# Don't use ^D to exit
# set -o ignoreeof
#
# Use case-insensitive filename globbing
# shopt -s nocaseglob
#
# Make bash append rather than overwrite the history on disk
# shopt -s histappend
#
# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
# shopt -s cdspell

# Programmable completion enhancements are enabled via
# /etc/profile.d/bash_completion.sh when the package bash_completetion
# is installed.  Any completions you add in ~/.bash_completion are
# sourced last.

# History Options
#
# Don't put duplicate lines in the history.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
#
# Ignore some controlling instructions
# HISTIGNORE is a colon-delimited list of patterns which should be excluded.
# The '&' is a special pattern which suppresses duplicate entries.
# export HISTIGNORE=$'[ \t]*:&:[fb]g:exit'
# export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls' # Ignore the ls command as well
#
# Whenever displaying the prompt, write the previous line to disk
# export PROMPT_COMMAND="history -a"

# Aliases
#
# Some people use a different file for aliases
# if [ -f "${HOME}/.bash_aliases" ]; then
#   source "${HOME}/.bash_aliases"
# fi
#
# Some example alias instructions
# If these are enabled they will be used instead of any instructions
# they may mask.  For example, alias rm='rm -i' will mask the rm
# application.  To override the alias instruction use a \ before, ie
# \rm will call the real rm not the alias.
#
# Interactive operation...
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'
#
# Default to human readable figures
# alias df='df -h'
# alias du='du -h'
#
# Misc :)
# alias less='less -r'                          # raw control characters
# alias whence='type -a'                        # where, of a sort
# alias grep='grep --color'                     # show differences in colour
# alias egrep='egrep --color=auto'              # show differences in colour
# alias fgrep='fgrep --color=auto'              # show differences in colour
#
# Some shortcuts for different directory listings
# alias ls='ls -hF --color=tty'                 # classify files in colour
# alias dir='ls --color=auto --format=vertical'
# alias vdir='ls --color=auto --format=long'
# alias ll='ls -l'                              # long list
# alias la='ls -A'                              # all but . and ..
# alias l='ls -CF'                              #

# Umask
#
# /etc/profile sets 022, removing write perms to group + others.
# Set a more restrictive umask: i.e. no exec perms for others:
# umask 027
# Paranoid: neither group nor others have any perms:
# umask 077

# Functions
#
# Some people use a different file for functions
# if [ -f "${HOME}/.bash_functions" ]; then
#   source "${HOME}/.bash_functions"
# fi
#
# Some example functions:
#
# a) function settitle
# settitle ()
# {
#   echo -ne "\e]2;$@\a\e]1;$@\a";
# }
#
# b) function cd_func
# This function defines a 'cd' replacement function capable of keeping,
# displaying and accessing history of visited directories, up to 10 entries.
# To use it, uncomment it, source this file and try 'cd --'.
# acd_func 1.0.5, 10-nov-2004
# Petar Marinov, http:/geocities.com/h2428, this is public domain
# cd_func ()
# {
#   local x2 the_new_dir adir index
#   local -i cnt
#
#   if [[ $1 ==  "--" ]]; then
#     dirs -v
#     return 0
#   fi
#
#   the_new_dir=$1
#   [[ -z $1 ]] && the_new_dir=$HOME
#
#   if [[ ${the_new_dir:0:1} == '-' ]]; then
#     #
#     # Extract dir N from dirs
#     index=${the_new_dir:1}
#     [[ -z $index ]] && index=1
#     adir=$(dirs +$index)
#     [[ -z $adir ]] && return 1
#     the_new_dir=$adir
#   fi
#
#   #
#   # '~' has to be substituted by ${HOME}
#   [[ ${the_new_dir:0:1} == '~' ]] && the_new_dir="${HOME}${the_new_dir:1}"
#
#   #
#   # Now change to the new dir and add to the top of the stack
#   pushd "${the_new_dir}" > /dev/null
#   [[ $? -ne 0 ]] && return 1
#   the_new_dir=$(pwd)
#
#   #
#   # Trim down everything beyond 11th entry
#   popd -n +11 2>/dev/null 1>/dev/null
#
#   #
#   # Remove any other occurence of this dir, skipping the top of the stack
#   for ((cnt=1; cnt <= 10; cnt++)); do
#     x2=$(dirs +${cnt} 2>/dev/null)
#     [[ $? -ne 0 ]] && return 0
#     [[ ${x2:0:1} == '~' ]] && x2="${HOME}${x2:1}"
#     if [[ "${x2}" == "${the_new_dir}" ]]; then
#       popd -n +$cnt 2>/dev/null 1>/dev/null
#       cnt=cnt-1
#     fi
#   done
#
#   return 0
# }
#
# alias cd=cd_func

export escp_dump_file="$HOME/.escp_env"
[ ! -f "$escp_dump_file"  ] && touch "$escp_dump_file" 1>/dev/null 2>&1

save_escp_env() {
	if [ -f "$escp_dump_file" ]; then
		cat << __EOF__ > "$escp_dump_file"
export SOURCE_OS_USER="$SOURCE_OS_USER"
export SOURCE_HOST_NAME="$SOURCE_HOST_NAME"
export PASS_PATH="$PASS_PATH"
export SOURCE_FILE="$SOURCE_FILE"
export TARGET_OS_USER="$TARGET_OS_USER"
export TARGET_HOST_NAME="$TARGET_HOST_NAME"
export TARGET_FILE="$TARGET_FILE"
__EOF__
	else
		echo "No file ${escp_dump_file} to source escp-variables"
	fi
}

source_from_escp_dump() {
if [ -f "$escp_dump_file" ]; then
	source "$escp_dump_file"
else
	echo "No file ${escp_dump_file} to source escp-variables"
fi
}

set_empty_envvar() {
	export SOURCE_OS_USER=""
	export SOURCE_HOST_NAME=""
	export PASS_PATH="WorkEnv/Hosts/"
	export SOURCE_FILE=""
	export TARGET_OS_USER=""
	export TARGET_HOST_NAME=""
	export TARGET_FILE=""
}
set_empty_envvar

swap_vals() {
	local V_TMP="$SOURCE_OS_USER"
	SOURCE_OS_USER="$TARGET_OS_USER"; TARGET_OS_USER="$V_TMP"
	export SOURCE_OS_USER
	export TARGET_OS_USER

	V_TMP="$SOURCE_HOST_NAME"; SOURCE_HOST_NAME="$TARGET_HOST_NAME"; TARGET_HOST_NAME="$V_TMP"
	export SOURCE_HOST_NAME
	export TARGET_HOST_NAME

	V_TMP="$SOURCE_FILE"; SOURCE_FILE="$TARGET_FILE"; TARGET_FILE="$V_TMP"
	export SOURCE_FILE
	export TARGET_FILE
}

show_envvar() {
	env | egrep "^(SOURCE|TARGET|PASS_PATH).*" | sort -k 1 -t "="
}


export PATH=$PATH:$ORACLE_HOME:$HOME/wrappers:$HOME/Backup:/cygdrive/c/Users/Documents/Documents/R/bin

alias sqlshell='rlwrap -c -D 1 -H $HOME/.sqlhistory -s 1024 sqlplus /nolog'
alias etns='vim $TNS_ADMIN/tnsnames.ora'

#escp expect wrapper for scp
alias show_escp='show_envvar'
alias del_escp='set_empty_envvar; show_envvar'
alias swap_escp='swap_vals; show_envvar'
alias save_escp='save_escp_env; [ -f "$escp_dump_file" ] && cat "$escp_dump_file"'
alias load_escp='set_empty_envvar; source_from_escp_dump; show_envvar'
alias edit_escp='vim "$escp_dump_file";'

#rsync-backup
alias dobackup='v_current_dir=$(pwd); cd $HOME/Backup; ./execute_backups.sh; cd $v_current_dir'

