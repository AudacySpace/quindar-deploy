#!/bin/bash
#
# server update script, can be called by Jenkins on updates, cron as scheduled,
# or executed by hand manually by running this script.
#


echo " "
echo "====================================================================="
echo "Updating node code via GitHub pull"
echo "---------------------------------------------------------------------"
cd /node

if [ "$#" -gt 0 ]; then
	echo "switching to branch $1"
	git checkout $1
fi

git pull

echo "---------------------------------------------------------------------"
echo "installing new code  ..."
echo "---------------------------------------------------------------------"
npm install

# note that in order to call this script from the docker host, remote SSH, etc
# it must start the node server as a background services and immediately return
# the last command below accomplishes that by startig in the background and 
# redirecting both terminal input and output to the bit bucket.

echo "---------------------------------------------------------------------"
echo "bouncing node server  ..."
echo "---------------------------------------------------------------------"
npm stop
(npm start) </dev/null >/dev/null 2>/dev/null &


