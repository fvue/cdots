#!/bin/bash
# --- cdots.sh ----------------------------------------------------------------
# Change directory back - up the directory tree - 1-7 times.
# Version: 1.0.8
# Usage: ..[.[.[.[.[.[.]]]]]] [dir]
#
# Arguments: [dir]   Directory to go forth - down the directory tree again,
#                    with TAB-completion.
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


CDOTS_DEPTH=7


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


# Change directory to specified directories back and forth
# @param $1 string   Directory back
# @param $2 string   Directory forth
# @see _cdots()
function cdots() {
    cd "$1$2"
} # cdots()


	# Define aliases .. ... .... etc
    # NOTE: Functions are not defined directly as .. ... .... etc, because
    #       these are not valid identifiers when `POSIX mode' is in effect
cdotsAliases=
cdotsAlias=.
cdotsDir=
for ((i = 1; i <= $CDOTS_DEPTH; i++)); do
	cdotsAlias=$cdotsAlias.
    cdotsDir=$cdotsDir../
	alias $cdotsAlias="cdots $cdotsDir"
	cdotsAliases="$cdotsAliases $cdotsAlias"
done
	# Link aliases .. ... .... etc with '_cdots()'.
    # -o filenames: Escapes whitespace
complete -o filenames -o nospace -F _cdots $cdotsAliases
unset -v CDOTS_DEPTH cdotsAlias cdotsAliases cdotsDir i j
