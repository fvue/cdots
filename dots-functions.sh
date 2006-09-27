#!/bin/bash
# ---- dots-functions.sh --------------------------------
# Change directory back - up the directory tree - 1-7 times.
# Version: 1.0.6
# Usage: ..[.[.[.[.[.[.]]]]]] [dir]
#
# Arguments: [dir]   Directory to go forth - down the directory tree again.
#                    For TAB-completion see: dots-completion.sh
#
# Example:   $/usr/share> .. local/share/   # .. lo[TAB]/sh[TAB])
#            $/usr/local/share>  
#
# See also:  http://www.fvue.nl/wiki/bashdots/


DOTS_DEPTH=7


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
unset -v DOTS_DEPTH dots dotsAliases i j
