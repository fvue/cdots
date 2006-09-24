#!/bin/bash

pversion=bashdots-$(cat VERSION)
ln -s . $pversion

	# @NOTE: Do not exclude all .svn directories since the test suite
    #        expects some .svn directories in the fixture directories
tar -cvzf $pversion.tar.gz \
	--exclude='.svn/*' \
	--exclude='log/*' \
	--exclude=test/.svn \
	--exclude=test/all/.svn \
	--exclude='*.swp' \
	${pversion}/dots.sh ${pversion}/dots-completion.sh ${pversion}/dots-functions.sh ${pversion}/AUTHORS ${pversion}/VERSION ${pversion}/RELEASE ${pversion}/test

    # Remove temporary directory
[ -h $pversion ] && rm $pversion

    # Link bashdots-1.0.current.tar.gz
[ -f bashdots-1.0.current.tar.gz ] && rm bashdots-1.0.current.tar.gz
ln -s $pversion.tar.gz bashdots-1.0.current.tar.gz

    # Copy distribution to live server
scp $pversion.tar.gz fvulto@www.fvue.nl:~/www/www.fvue.nl/bashdots/download/
