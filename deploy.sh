#!/bin/bash

	# @NOTE: Do not exclude all .svn directories since the test suite
    #        expects some .svn directories in the fixture directories
tar -cvzf bashdots-1.0.2.tar.gz \
	--exclude=.svn/* \
	--exclude=log/* \
	--exclude=test/.svn \
	--exclude=test/all/.svn \
	--exclude='*.swp' \
	dots.bash test

scp bashdots-1.0.2.tar.gz fvulto@www.fvue.nl:~/www/www.fvue.nl/bashdots/download/
