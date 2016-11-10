#!/bin/bash
#
# server update script, can be called by Jenkins on updates, cron as scheduled,
# or executed by hand manually by running this script.
#


echo " "
echo "====================================================================="
echo "Updating GMAT code via GitHub pull"
echo "---------------------------------------------------------------------"
cd /gmat

if [ "$#" -gt 0 ]; then
	echo "switching to branch $1"
	git checkout $1
fi

git pull




