# quindar-deploy
Files needed to deploy (install) Quindar; the complete Quindar platform has three components:

1. The front end (gui)          > quindar-ux
2. The backend (server)         > quindar-svr
3. The simulator (data source)  > quindar-src

## pre-requisites

Step 1 - prepare the hosts
Install the pre-requisites on the host server(s). You can deploy all three components (source, server, ux) on one host running docker or run individual machines for each. If you want to remove old images first use `docker rm $(docker ps -a -q)`. 

* Install Git, e.g. `yum install -y git`
* Install Docker (see https://docs.docker.com/engine/installation/)

Step 2 - Clone this repository 

```
git clone https://github.com/quindar/quindar-deploy
```

The nginx servers are deployed with self-signed certificates which will throw security warnings in your browser. In a production environment, SSH into the servers and (1) update server name, (2) install your own certs. 

```
server certificate  /etc/ssl/server.crt
server key          /etc/ssl/server.key
restart nginx       nginx -s reload
```

## qux Install
```
chmod +x ./quindar-deploy/qux-frontend/deploy-qux.sh
sudo ./quindar-deploy/qux-frontend/deploy-qux.sh
```

Or doing it by hand (rather than using a script) if you are on a windows host:
```
cd quindar-ux
docker build -t "quindar-qux" .
docker run -d -t --name qux --cap-add SYS_PTRACE -v /proc:/host/proc:ro -v /sys:/host/sys:ro -p 80:80 -p 443:443 quindar-qux
```


You can update the node application after the docker container is deployed (running) from the host by running the following command (on the host). This is useful for either scheduled updates or build automation via Jenkins, etc. 

```
sudo docker exec qux node-update.sh
```

## qsvr Install

```
chmod +x ./quindar-deploy/qsvr-backend/deploy-qsvr.sh
sudo ./quindar-deploy/qsvr-backend/deploy-qsvr.sh
```

You can update the node application after the docker container is deployed (running) from the host by running the following command (on the host). This is useful for either scheduled updates or build automation via Jenkins, etc. 

```
sudo docker exec qux node-update.sh
```

## qsrc Install

To be added.


