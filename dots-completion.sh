#!/bin/bash
# --- dots-completion.sh ------------------------------------------------------
# TAB completion for the .. ... .... etc commands, as defined in dots-functions.sh
# Version: 1.0.6
#
# Example:   $/usr/share> .. lo[TAB]/sh[TAB])
#            $/usr/local/share>  
#
# See also:  http://www.fvue.nl/wiki/bashdots/


DOTS_DEPTH=7


    # TAB completion for the .. ... .... etc commands
_cdots() {
    local dots=${COMP_WORDS[COMP_CWORD-1]:2}  # ':2' = Ignore two dots at pos 0
    local i IFS=$'\012' j k=0 cur=${COMP_WORDS[COMP_CWORD]}
    for j in $( 
        cd ${dots//./..\/}.. > /dev/null
        compgen -d -- "${COMP_WORDS[COMP_CWORD]}"
    ); do
            # If j not directory in current working directory, append slash '/'
            # NOTE: If j is also directory in current working directory, 
            #       'complete -o filenames' automatically appends slash '/'
        [ ! -d $j ] && j="$j/"
        COMPREPLY[k++]="$j"
    done
} # _cdots()

    # Link '_cdots()' to aliases .. ... .... etc
complete -o filenames -o nospace -F _cdots $(
	for ((i = 1; i <= DOTS_DEPTH; i++)); do
		dots=$dots.
		echo $dots.
	done
)
unset -v DOTS_DEPTH dots i
