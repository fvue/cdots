#!/bin/bash
# ---- cdots-functions.sh ----------------------------------------------------
# Change directory back - up the directory tree - 1-7 times.
# Version: 1.0.7
# Usage: ..[.[.[.[.[.[.]]]]]] [dir]
#
# Arguments: [dir]   Directory to go forth - down the directory tree again.
#                    For TAB-completion see: dots-completion.sh
#
# Example:   $/usr/share> .. local/share/   # .. lo[TAB]/sh[TAB])
#            $/usr/local/share>  
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software Foundation,
# Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
#
# The latest version of this software can be obtained here:
#
#     http://www.fvue.nl/cdots/


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
