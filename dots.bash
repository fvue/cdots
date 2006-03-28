#!/usr/bin/bash
# --- dots.bash -----------------------------------------------------------
# Change directory back - up the directory tree - 1-7 times.
# Version: 1.0.1
# Usage: ..[.[.[.[.[.[.]]]]]] [dir]
#
# Arguments: [dir]   Directory to go forth - down the directory tree again,
#                    with TAB-completion.
#
# Example:   $/usr/share> .. local/share/   # .. lo[TAB]/sh[TAB])
#            $/usr/local/share>  
#
# Install:   Add the code underneath to your ~/.bashrc


    # TAB completion for the .. ... .... etc commands
_completeDots() {
    local argToComplete prevArg

    COMPREPLY=()
    argToComplete=${COMP_WORDS[COMP_CWORD]}
    dots=${COMP_WORDS[COMP_CWORD-1]:2}  # ':2' = Ignore two dots at pos 0
	cd ${dots//./..\/}..                # Replace . with ../, and cd
	COMPREPLY=( $(compgen -S '/' -d -- "${argToComplete}") )
	cd - > /dev/null                    # Restore current dir
} # _completeDots


	# Define functions .. ... .... etc
dotsFunctions=
for ((i = 1; i <= 7; i++)); do
	dots=.; dotsPath=
	for ((j = 1; j <= $i; j++)); do
		dots=$dots.; dotsPath=$dotsPath../
	done	
		# Make sure .. ... .... etc is unaliased
	alias $dots &> /dev/null && unalias $dots
		# Function definition
	eval "$dots() { if [ $dotsPath\$1 ]; then cd $dotsPath\$1; fi }"
	dotsFunctions="$dotsFunctions $dots"
done
	# Link functions .. ... .... etc with '_completeDots()'.
complete -o nospace -F _completeDots $dotsFunctions
