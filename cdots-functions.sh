#!/bin/bash
# --- cdots.sh -------------------------------------------------------
# Change directory back - 1-7 times - and forth with TAB-completion.
# For TAB-completion see: dots-completion.sh
# Copyright (C) 2006  Freddy Vulto
# Version: 1.0.8
# Usage: ..[.[.[.[.[.[.]]]]]] [dir]
#
# Arguments: [dir]   Directory to go forth - down the directory tree
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
# along with this program; if not, write to the Free Software 
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, 
# MA 02110-1301, USA
#
# The latest version of this software can be obtained here:
# http://www.fvue.nl/cdots/


CDOTS_DEPTH=7


#--- cdots() ---------------------------------------------------------
# Change directory to specified directories back, and forth
# @param $1 string   Directory back
# @param $2 string   Directory forth
# @see _cdots() for TAB-completion
function cdots() {
    cd "$1$2"
} # cdots()


    # Define aliases .. ... .... etc
    # NOTE: Functions are not defined directly as .. ... .... etc, 
    #       because these are not valid identifiers under `POSIX'
cdotsAlias=.; cdotsAliases=; cdotsDir=
for ((i = 1; i <= $CDOTS_DEPTH; i++)); do
    cdotsAlias=$cdotsAlias.; cdotsDir=$cdotsDir../
    alias $cdotsAlias="cdots $cdotsDir"
    cdotsAliases="$cdotsAliases $cdotsAlias"
done
unset -v CDOTS_DEPTH cdotsAlias cdotsAliases cdotsDir i
