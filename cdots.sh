#!/bin/bash
# --- cdots.sh ----------------------------------------------------------------
# Change directory back - up the directory tree - 1-7 times.
# Version: 1.0.7
# Usage: ..[.[.[.[.[.[.]]]]]] [dir]
#
# Arguments: [dir]   Directory to go forth - down the directory tree again,
#                    with TAB-completion.
#
# Example:   $/usr/share> .. local/share/   # .. lo[TAB]/sh[TAB])
#            $/usr/local/share>  
#
# See also:  http://www.fvue.nl/wiki/bashdots/


DOTS_DEPTH=7


    # TAB completion for the .. ... .... etc commands
_cdots() {
        # ':2' = Ignore two dots at pos 0, $'\012' = newline (\n)
    local dots=${COMP_WORDS[COMP_CWORD-1]:2} IFS=$'\012' i j k=0
    local dir=${dots//./..\/}../  # Replace . with ../
    for j in $(compgen -d -- "$dir${COMP_WORDS[COMP_CWORD]}"); do
            # If j not directory in current working directory, append extra slash '/'
            # NOTE: If j is also directory in current working directory, 
            #       'complete -o filenames' automatically appends slash '/'
        [ ! -d ${j#$dir} ] && j="$j/"
        COMPREPLY[k++]="${j#$dir}"
    done
} # _cdots()


# Change directory to specified directory at [level] directories back
# @param $1 integer  Level
# @param $2 string   Directory
function cdots() {
    local i dir
    for ((i = 0; i < $1; i++)); do dir="../$dir"; done
    cd "$dir$2"
} # cdots()


	# Define aliases .. ... .... etc
    # NOTE: Functions are not defined directly as .. ... .... etc, because
    #       these are not valid identifiers when `POSIX mode' is in effect
dotsAliases=
for ((i = 1; i <= $DOTS_DEPTH; i++)); do
	dots=.
	for ((j = 1; j <= $i; j++)); do dots=$dots.; done
	alias $dots="cdots $i"
	dotsAliases="$dotsAliases $dots"
done
	# Link aliases .. ... .... etc with '_cdots()'.
    # -o filenames: Escapes whitespace
complete -o filenames -o nospace -F _cdots $dotsAliases
unset -v DOTS_DEPTH dots dotsAliases i j
