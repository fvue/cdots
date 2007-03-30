#!/bin/bash

pversion=cdots-$(cat VERSION)
ln -s . $pversion

	# @NOTE: Do not exclude all .svn directories since the test suite
    #        expects some .svn directories in the fixture directories
tar -cvzf $pversion.tar.gz \
	--exclude='.svn/*' \
	--exclude='log/*' \
	--exclude=test/.svn \
	--exclude=test/all/.svn \
	--exclude='*.swp' \
	${pversion}/cdots.sh ${pversion}/cdots-completion.sh ${pversion}/cdots-functions.sh ${pversion}/AUTHORS ${pversion}/COPYING ${pversion}/INSTALL ${pversion}/VERSION ${pversion}/RELEASE ${pversion}/test

    # Remove temporary directory
[ -h $pversion ] && rm $pversion

    # Link bashdots-1.0.current.tar.gz
[ -f cdots-1.0.current.tar.gz ] && rm cdots-1.0.current.tar.gz
ln -s $pversion.tar.gz cdots-1.0.current.tar.gz

    # Copy files to live server
scp $pversion.tar.gz fvulto@www.fvue.nl:~/www/www.fvue.nl/cdots/
scp cdots.sh fvulto@www.fvue.nl:~/www/www.fvue.nl/cdots/cdots.txt
