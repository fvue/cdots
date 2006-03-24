# bashrc
# There are 3 different types of shells in bash: the login shell, normal shell
# and interactive shell. Login shells read ~/.profile and interactive shells
# read ~/.bashrc; in our setup, /etc/profile sources ~/.bashrc - thus all
# settings made here will also take effect in a login shell.
#
# NOTE: It is recommended to make language settings in ~/.profile rather than
# here, since multilingual X sessions would not work properly if LANG is over-
# ridden in every subshell.


# For some news readers it makes sense to specify the NEWSSERVER variable here
#export NEWSSERVER=your.news.server

	# My favourite text editor
export EDITOR=/usr/bin/vim
export PATH=$PATH:/sbin
export PROJ_DIRS="$HOME/proj/cdpath/current/paths \
				  $HOME/proj"
export TMP=/tmp/proj
export VIM=~/.vim

#export PS1=$PS1"\[\e]30;\H:\w\a\]"

	# Operate bash in vi editing mode
set -o vi

test -f ~/.alias && . ~/.alias

    # Change directory to project
function cdp() {
    local is_cded=0
    for dir in $PROJ_DIRS; do
        if [ -r "$dir/$1" ]; then
            cd -P "$dir/$1"
            is_cded=1
            break
        fi
    done
    if [ $is_cded = 0 ]; then
        echo $FUNCNAME: $1: No such file or directory
    fi
} # cdp()


    # TAB completion for the cdp() command
_cdp() {
    local arg_to_complete prev_arg

    COMPREPLY=()
    arg_to_complete=${COMP_WORDS[COMP_CWORD]}
    prev_arg=${COMP_WORDS[COMP_CWORD-1]}
    case $prev_arg in
        'cdp')
            for dir in $PROJ_DIRS; do
                COMPREPLY=( "${COMPREPLY[@]}" $(
                    cd "$dir"
                    compgen -S '/' -d -- "${arg_to_complete}"
                ) )
            done
        ;;
    esac

    return 0
} # _cdp()
complete -o nospace -F _cdp cdp


	# If aliases exist for the 'change directory n up' commands, unalias them
if alias .. &> /dev/null;  then
	unalias ..
fi
if alias ... &> /dev/null;  then
	unalias ...
fi
if alias .... &> /dev/null;  then
	unalias ....
fi
if alias ..... &> /dev/null;  then
	unalias .....
fi

# Change directory up
function ..() {
	cd ..
	if [ $1 ]; then
		cd $1
	fi
} # ..()

# Change directory 2 up
function ...() {
	cd ../..
	if [ $1 ]; then
		cd $1
	fi
} # ...()

# Change directory 3 up
function ....() {
	cd ../../..
	if [ $1 ]; then
		cd $1
	fi
} # ....()

# Change directory 4 up
function .....() {
	cd ../../../..
	if [ $1 ]; then
		cd $1
	fi
} # .....()

    # TAB completion for the 'change directory n up' commands
_..() {
    local arg_to_complete prev_arg

    COMPREPLY=()
    arg_to_complete=${COMP_WORDS[COMP_CWORD]}
    prev_arg=${COMP_WORDS[COMP_CWORD-1]}
    case $prev_arg in
        '..')    cd_dir=..          ;;
        '...')   cd_dir=../..       ;;
        '....')  cd_dir=../../..    ;;
        '.....') cd_dir=../../../.. ;;
    esac
	if [ $cd_dir ]; then
		prev_dir=`pwd`
		cd $cd_dir
		COMPREPLY=( $(
			compgen -S '/' -d -- "${arg_to_complete}"
		) )
		cd $prev_dir
	fi

    return 0
} # _cdp()
complete -o nospace -F _.. .. ... .... .....
