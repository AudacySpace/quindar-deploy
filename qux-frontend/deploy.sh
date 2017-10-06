#!/bin/bash
#build docker test container
docker build -t "qux_test" -f "Dockerfile.test" --build-arg BRANCH=$1 .

#run and remove the docker test container
docker run --rm --name "qux_test" qux_test

RC=$?

#Remove test container image
docker rmi qux_test

#If tests successful, update the code in the docker container 
if [ $RC == 0 ]
then
  echo "====================================================================="
  echo "Updating code in the main docker container"
  echo "====================================================================="
  docker exec qux node-update.sh $1
else
  echo "====================================================================="
  echo "Test docker container failure. See above for more details."
  echo "====================================================================="
  exit 1	
fi
