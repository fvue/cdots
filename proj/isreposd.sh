#!/bin/bash
#--- isreposd -------------------------------------------------------------------------------------
# Determine whether project has been saved in version repository.
# @param string $1  Project path
# @return  Exit 0 if project has been saved in version repository, <> 0 if not.

. ./init.sh
. $PROJ_PATHVPROJLIB/isreposd.sh $PROJ_PATHV
