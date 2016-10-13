# quindar-deploy
Files needed to deploy (install) Quindar.


## Architecture

Quindar has three components:

1. The front end (gui)          > quindar-ux
2. The backend (server)         > quindar-svr
3. The simulator (data source)  > quindar-src




## Install

To deploy quindar using docker, do the following:

1. Install Git, e.g. `yum install -y git`
2. Install Docker (see https://docs.docker.com/engine/installation/)
3. Clone this repository `git clone https://github.com/quindar/quindar-deploy`
5. Build the docker image `docker build -t "quindar:ux" .`
4. Run the image with ports mapped `docker run -d -t --cap-add SYS_PTRACE -v /proc:/host/proc:ro -v /sys:/host/sys:ro -p 80:80 -p 443:443 quindar:ux`


Note (1): 
to remove / clean old images use `docker rm $(docker ps -a -q)`

Note (2): 
to track the container hosts performance (versus the performance of the server in the container), add the following options to the docker run command `--cap-add SYS_PTRACE -v /proc:/host/proc:ro -v /sys:/host/sys:ro`

Note (3):
the netdata monitor is acessible via //hostname/netdata

