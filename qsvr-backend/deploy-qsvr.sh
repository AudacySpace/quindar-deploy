#!/bin/bash
#
# install script for qux server deployment
#


# get absolute path where this file is
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "building in " $DIR

# change working dir
pushd $DIR

# build the container
sudo docker build -t "quindar-qsvr" .

# deploy it
sudo docker run -d -t --name qsvr --cap-add SYS_PTRACE -v /proc:/host/proc:ro -v /sys:/host/sys:ro -p 80:80 -p 443:443 quindar-qsvr

# return to where we were called from 
popd
