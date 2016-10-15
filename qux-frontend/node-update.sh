#/bin/bash
#
# server update script, can be called by Jenkins on updates, cron as scheduled,
# or executed by hand manually by running this script.
#

echo "---------------------------------------------------------------------"
echo "making temp dir ..."
echo "---------------------------------------------------------------------"
mkdir -p /tmp/github-update
cd /tmp/github-update


echo "pulling code from github ..."
echo "---------------------------------------------------------------------"
git clone --verbose https://github.com/quindar/quindar-ux.git ./new

echo "---------------------------------------------------------------------"
echo "cleaning node dir ..."
echo "---------------------------------------------------------------------"
rm -rf /node/*

echo "moving new code  ..."
echo "---------------------------------------------------------------------"
cp -fvR /tmp/github-update/new/* /node
cd /node

echo "---------------------------------------------------------------------"
npm install

echo "---------------------------------------------------------------------"
echo "cleaning up temp dir ..."
echo "---------------------------------------------------------------------"
rm -rf /tmp/github-update


# restart the node server to load new code 
# TBA