#!/bin/bash
#
# server update script, can be called by Jenkins on updates, cron as scheduled,
# or executed by hand manually by running this script.
#


echo " "
echo "====================================================================="
echo "Updating node/proxy code via GitHub pull"
echo "---------------------------------------------------------------------"
cd /node/proxy
git checkout -- package-lock.json || rm -f package-lock.json

if [ "$#" -gt 0 ]; then
	echo "switching to branch $1"
	git checkout $1
fi

if [ "${ENVIRONMENT}" == "" ]
then
  ENVIRONMENT="development"
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

# the node server is run in autostart using pm2. However, if the branch is switched
# or a new module is installed via npm update, it is possible that pm2 already 
# exited with the max number of restarts at this point. The command below brings 
# the process back from the dead if needed.

echo "---------------------------------------------------------------------"
echo "bouncing node server (via pm2) ..."
echo "---------------------------------------------------------------------"
pm2 restart proxy || (pm2 start ecosystem.config.js --env ${ENVIRONMENT} &)
