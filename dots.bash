#!/usr/bin/bash
# --- dots.bash -----------------------------------------------------------
# Change directory back - down the directory tree - 1-7 times.
# Usage: ..[.[.[.[.[.[.]]]]]] [dir]
#
# Arguments: [dir]   Directory to go forth - up the directory tree again,
#                    with TAB-completion!
#
# Example:   $/usr/share> .. local/share/   # .. lo[TAB]/sh[TAB])
#            $/usr/local/share>  
#
# Install:   Add the code underneath to your ~/.bashrc


    # TAB completion for the .., ..., ...., etc. commands
_completeDots() {
    local argToComplete prevArg

    COMPREPLY=()
    argToComplete=${COMP_WORDS[COMP_CWORD]}
    dots=${COMP_WORDS[COMP_CWORD-1]:1}  # ':1' = Ignore first dot at pos 0
	cd ${dots//./..\/}                  # Replace . with ../, and cd
	COMPREPLY=( $(
		compgen -S '/' -d -- "${argToComplete}"
	) )
	cd -  # cd to prev dir
} # _completeDots


	# Define functions for .., ..., ...., etc. and associate _completeDots() with 'em
dotsFunctions=
for ((i = 1; i <= 7; i++)); do
	dots=.; dotsPath=
	for ((j = 1; j <= $i; j++)); do
		dots=$dots.; dotsPath=$path../
	done	
		# Make sure .., ..., ...., etc. is unaliased
	alias $dots &> /dev/null && unalias $dots
		# Define functions for .., ..., ...., etc.
	eval "$dots() { if [ $dotsPath\$1 ]; then cd $dotsPath\$1; fi }"
	dotsFunctions="$dotsFunctions $dots"
done
complete -o nospace -F _completeDots $dotsFunctions
