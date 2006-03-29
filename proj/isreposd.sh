#!/bin/bash
#--- isreposd -------------------------------------------------------------------------------------
# Determine whether project has been saved in version repository.
# @param string $1  Project path
# @return  Exit 0 if project has been saved in version repository, <> 0 if not.

   # cd to script dir
scriptPath="`which \"$0\"`"
scriptDir="`dirname \"$scriptPath\"`"
cd $scriptDir

. ./init.sh
. $PROJ_PATHVPROJLIB/isreposd.sh $PROJ_PATHV
