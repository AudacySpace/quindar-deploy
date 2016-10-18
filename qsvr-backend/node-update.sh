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
git pull

echo "---------------------------------------------------------------------"
echo "installing new code  ..."
echo "---------------------------------------------------------------------"
npm install

echo "---------------------------------------------------------------------"
echo "bouncing node server  ..."
echo "---------------------------------------------------------------------"
npm stop
cmd="npm start"
nohup cmd >server.log 2>&1 </dev/null &


