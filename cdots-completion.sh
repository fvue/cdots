#!/bin/bash
# --- cdots-completion.sh -----------------------------------------------------
# TAB completion for the .. ... .... etc commands, as defined in cdots-functions.sh
# Version: 1.0.7
#
# Example:   $/usr/share> .. lo[TAB]/sh[TAB])
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

    # Link '_cdots()' to aliases .. ... .... etc
complete -o filenames -o nospace -F _cdots $(
	for ((i = 1; i <= DOTS_DEPTH; i++)); do
		dots=$dots.
		echo $dots.
	done
)
unset -v DOTS_DEPTH dots i
