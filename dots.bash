#!/usr/bin/bash
# --- dots.bash ---
# Change directory back - up the directory tree - 1-7 times.
# Usage: ..[.[.[.[.[.[.]]]]]] [dir]
#
# Arguments:
# 
#    [dir]   Directory to go forth - down the directory tree again,
#            with TAB-completion!
#
# Example:
#
#    $/usr/share> .. local/share/   # .. lo[TAB]/sh[TAB])
#    $/usr/local/share>  
#
# Install: Save this file as ~/dots.bash and add the line underneath to ~/.bashrc:
#
#    source ~/dots.bash
#


	# If aliases exist for the 'change directory 1-7 up' commands, unalias them
for nup in .. ... .... ..... ...... ....... ........; do
	if alias $nup &> /dev/null; then
		unalias $nup
	fi
done


# Change directory 1 up
function ..() {
	if [ ../$1 ]; then cd ../$1; fi
} # ..()

# Change directory 2 up
function ...() {
	if [ ../../$1 ]; then cd ../../$1; fi
} # ...()

# Change directory 3 up
function ....() {
	if [ ../../../$1 ]; then cd ../../../$1; fi
} # ....()

# Change directory 4 up
function .....() {
	if [ ../../../../$1 ]; then cd $1; fi
} # .....()

# Change directory 5 up
function ......() {
	if [ ../../../../../$1 ]; then cd $1; fi
} # .....()

# Change directory 6 up
function .......() {
	if [ ../../../../../../$1 ]; then cd $1; fi
} # .....()

# Change directory 7 up
function ........() {
	if [ ../../../../../../../$1 ]; then cd $1; fi
} # .....()


    # TAB completion for the 'change directory n up' commands
_..() {
    local arg_to_complete prev_arg

    COMPREPLY=()
    arg_to_complete=${COMP_WORDS[COMP_CWORD]}
    prev_arg=${COMP_WORDS[COMP_CWORD-1]}
    case $prev_arg in
        '..')       cd_dir=..                   ;;
        '...')      cd_dir=../..                ;;
        '....')     cd_dir=../../..             ;;
        '.....')    cd_dir=../../../..          ;;
        '......')   cd_dir=../../../../..       ;;
        '.......')  cd_dir=../../../../../..    ;;
        '........') cd_dir=../../../../../../.. ;;
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
complete -o nospace -F _.. .. ... .... ..... ...... ....... ........
