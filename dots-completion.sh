#!/bin/bash
# --- dots-completion.sh ----------------------------------------------------------------
# TAB completion for the .. ... .... etc commands, as defined in dots-functions.sh
# Version: 1.0.5
#
# Example:   $/usr/share> .. lo[TAB]/sh[TAB])
#            $/usr/local/share>  
#
# See also:  http://www.fvue.nl/wiki/bashdots/


DOTS_DEPTH=7


    # TAB completion for aliases .. ... .... etc
_completeDots() {
    local dots=${COMP_WORDS[COMP_CWORD-1]:2}  # ':2' = Ignore two dots at pos 0
    COMPREPLY=( $(
        cd ${dots//./..\/}.. > /dev/null
        compgen -o nospace -S '/' -d -- "${COMP_WORDS[COMP_CWORD]}"
    ) )
} # _completeDots

    # Link '_completeDots()' to aliases .. ... .... etc
complete -o nospace -F _completeDots $(
	for ((i = 1; i <= DOTS_DEPTH; i++)); do
		dots=$dots.
		echo $dots.
	done
)
unset -v dots i
