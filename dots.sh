#!/bin/bash
# --- dots.sh -----------------------------------------------------------------
# Change directory back - up the directory tree - 1-7 times.
# Version: 1.0.3
# Usage: ..[.[.[.[.[.[.]]]]]] [dir]
#
# Arguments: [dir]   Directory to go forth - down the directory tree again,
#                    with TAB-completion.
#
# Example:   $/usr/share> .. local/share/   # .. lo[TAB]/sh[TAB])
#            $/usr/local/share>  
#
# See also:  http://www.fvue.nl/wiki/index.php/bashdots/


DOTS_DEPTH=7

    # TAB completion for the .. ... .... etc commands
_completeDots() {
    local dots=${COMP_WORDS[COMP_CWORD-1]:2}  # ':2' = Ignore two dots at pos 0
	COMPREPLY=( $(
		cd ${dots//./..\/}.. > /dev/null
		compgen -o nospace -S '/' -d -- "${COMP_WORDS[COMP_CWORD]}"
	) )
} # _completeDots


	# Define functions .. ... .... etc
dotsFunctions=
for ((i = 1; i <= $DOTS_DEPTH; i++)); do
	dots=.; dotsPath=
	for ((j = 1; j <= $i; j++)); do
		dots=$dots.; dotsPath=$dotsPath../
	done	
		# Make sure aliases .. ... .... etc are unaliased
	alias $dots &> /dev/null && unalias $dots
		# Function definition
	eval "$dots() { if [ $dotsPath\$1 ]; then cd $dotsPath\$1; fi }"
	export -f $dots
	dotsFunctions="$dotsFunctions $dots"
done
	# Link functions .. ... .... etc with '_completeDots()'.
complete -o nospace -F _completeDots $dotsFunctions
unset DOTS_DEPTH dots dotsFunctions dotsPath i j
