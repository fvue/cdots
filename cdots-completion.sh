#!/bin/bash
# --- cdots-completion.sh --------------------------------------------
# TAB completion for the .. ... .... etc commands: cdots-functions.sh
# Copyright (C) 2007  Freddy Vulto
# Version: 1.1.0
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
# along with this program; if not, write to the Free Software 
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, 
# MA  02110-1301, USA
#
# The latest version of this software can be obtained here:
# http://www.fvue.nl/cdots/


#--- _cdots() --------------------------------------------------------
# TAB completion for the .. ... .... etc commands
# @see cdots()
_cdots() {
        # ':1' = Ignore dot at pos 0
    local dots=${COMP_WORDS[COMP_CWORD-1]:1} IFS=$'\n' i j=0
        #      +-----------2---------+ : Remove trailing /*s from PWD
        #      |     +-------1------+| : Replace every . with /*
    local dir="${PWD%${dots//\./\/\*}}/"
        # If first `compgen' returns no matches, try second `compgen'
        # which allows for globbing characters
    for i in $(
        compgen -d -- "$dir${COMP_WORDS[COMP_CWORD]}" ||
        compgen -d -X '!'"$dir${COMP_WORDS[COMP_CWORD]}*" -- $dir
    ); do
            #  If i not dir in current dir, append extra slash '/'
            #  NOTE: With bash > v2, if i is also dir in current dir, 
            #+       'complete -o filenames' automatically appends 
            #+       slash '/'
        (( $BASH_VERSINFO == 2 )) || [ ! -d ${i#$dir} ] && i="$i/"
        COMPREPLY[j++]="${i#$dir}"
    done
} # _cdots()


    # Set completion of aliases .. ... .... etc to _cdots()
    # -o filenames: Escapes whitespace
complete -o filenames -o nospace -F _cdots $(
    cdotsAlias=.; cdotsDepth=7
    while ((cdotsDepth--)); do
        cdotsAlias=$cdotsAlias.
        echo $cdotsAlias
    done
)
