#!/bin/bash
# ---- dots-functions.sh --------------------------------
# Change directory back - up the directory tree - 1-7 times.
# Version: 1.0.3
# Usage: ..[.[.[.[.[.[.]]]]]] [dir]
#
# Arguments: [dir]   Directory to go forth - down the directory tree again.
#                    For TAB-completion see: dots-completion.sh
#
# Example:   $/usr/share> .. local/share/   # .. lo[TAB]/sh[TAB])
#            $/usr/local/share>  
#
# Install:   For all users:
#            - Store this file in /etc/profile.d
#
# See also:  http://www.fvue.nl/wiki/index.php/bashdots/


DOTS_DEPTH=7

	# Define functions .. ... .... etc
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
done
	# Clear variables
unset DOTS_DEPTH dots dotsPash i j
