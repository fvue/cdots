#!/bin/bash
#--- init.sh ------
# Initialize project

export PROJ_NAME=`xmllint --xinclude ../conf/conf.all.xml | xml sel -t -m '/all' -v 'project/name'`
export PROJ_VERSION=`xmllint --xinclude ../conf/conf.all.xml | xml sel -t -m '/all' -v 'project/version'`
export PROJ_PATH=`cd ..;/bin/pwd`
export PROJ_PATHV=${PROJ_PATH}${PROJ_VERSION:+/}$PROJ_VERSION
export PROJ_PATHVPROJ=$PROJ_PATHV/proj
export PROJ_PATHVPROJLIB=$PROJ_PATHVPROJ/lib
