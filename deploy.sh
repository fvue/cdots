#!/bin/bash

    # Exit when simple command fails.  Same as `set -e'.
set -o errexit
    # Trigger error when expanding unset variables.  Same as `set -u'.
set -o nounset

v=$(cat VERSION)
ln -s . $v

	# @NOTE: Do not exclude all .svn directories since the test suite
    #        expects some .svn directories in the fixture directories
tar -cvzf $v.tar.gz \
	--exclude=.svn \
	--exclude=*.log \
	--exclude=*.sum \
	--exclude=*.swp \
	${v}/cdots.sh ${v}/cdots-completion.sh ${v}/cdots-function.sh ${v}/AUTHORS ${v}/COPYING ${v}/INSTALL ${v}/VERSION ${v}/RELEASE ${v}/test

    # Remove temporary directory
[ -h $v ] && rm $v

    # Link bashdots-1.0.current.tar.gz
#[ -f cdots-1.0.current.tar.gz ] && rm cdots-1.0.current.tar.gz
#ln -s $v.tar.gz cdots-1.0.current.tar.gz

    # Copy files to live server
#scp $v.tar.gz RELEASE fvue:fvue/cdots/
#scp cdots.sh fvue:fvue/cdots/$v.txt
