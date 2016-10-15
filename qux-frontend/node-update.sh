#!/bin/bash
#
# server update script, can be called by Jenkins on updates, cron as scheduled,
# or executed by hand manually by running this script.
#


echo " "
echo "====================================================================="
echo "Updating node code via GitHub pull"
echo "---------------------------------------------------------------------"
echo " "

echo "---------------------------------------------------------------------"
echo "cloning into temp dir ..."
echo "---------------------------------------------------------------------"
mkdir -p /tmp/github-update
cd /tmp/github-update
git clone --verbose https://github.com/quindar/quindar-ux.git ./new

echo "---------------------------------------------------------------------"
echo "cleaning node dir ..."
echo "---------------------------------------------------------------------"
rm -rf /node/*

echo "---------------------------------------------------------------------"
echo "installing new code  ..."
echo "---------------------------------------------------------------------"
cp -fvR /tmp/github-update/new/* /node/
cd /node
npm install

echo "---------------------------------------------------------------------"
echo "cleaning up temp dir ..."
echo "---------------------------------------------------------------------"
rm -rf /tmp/github-update


echo "---------------------------------------------------------------------"
echo "bouncing node server  ..."
echo "---------------------------------------------------------------------"
npm stop
npm start &
exit 0
