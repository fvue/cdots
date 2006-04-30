#!/bin/bash

	# @NOTE: Do not exclude all .svn directories since the test suite
    #        expects some .svn directories in the fixture directories
tar -cvzf bashdots-$(cat VERSION).tar.gz \
	--exclude=.svn/* \
	--exclude=log/* \
	--exclude=test/.svn \
	--exclude=test/all/.svn \
	--exclude='*.swp' \
	dots.sh dots-completion.sh dots-functions.sh VERSION RELEASE test

scp bashdots-$(cat VERSION).tar.gz fvulto@www.fvue.nl:~/www/www.fvue.nl/bashdots/download/
