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



# qux Install

```
cd quindar-deploy/qux-frontend
docker build -t "quindar-qux" .
docker run -d -t --name qux --cap-add SYS_PTRACE -v /proc:/host/proc:ro -v /sys:/host/sys:ro -p 80:80 -p 443:443 quindar-qux
```

The quindar gui will be running on http://hostname

You can update the node application after the docker container is deployed (running) from the host by running the following command (on the host); the last parameter is the name of the repo branch you want to use for the update; either "master" for production, or "develop" for the development branch. This is useful for either scheduled updates or build automation via Jenkins, etc. 

```
docker exec qux node-update.sh <branch>
```


# qsvr Install

```
cd quindar-deploy/qsvr-backend
docker build -t "quindar-qsvr" .
docker run -d -t --name qsvr --cap-add SYS_PTRACE -v /proc:/host/proc:ro -v /sys:/host/sys:ro -p 80:80 -p 443:443 -p 27017:27017 quindar-qsvr
```
The database will be available on port 27017, and the server gui will be running on http://hostname. To connect to the database admin interface, click on the "Login" link (forwards to https://hostname) and use the following connection string in the admin gui to link the database:

```
mongodb://admin@localhost
```

To update the quindar proxy node app inside the container after deployment, use the following command (on the host).

```
docker exec qsvr proxy-update.sh <branch>
```


# qsrc Install


```
cd quindar-deploy/qsrc-simulator
docker build -t "quindar-qsrc" .
docker run -d -t --name qsrc --cap-add SYS_PTRACE -v /proc:/host/proc:ro -p 80:80 -p 443:443 -p 5901:5901 quindar-qsrc
```

Connect to the server at http://hostname or you can access the VNC server directly with a [VNC client](https://www.realvnc.com/download/viewer/) at hostname:5901 using password "vncpassword".

You can update GMAT inside the docker container while running from the host with the following command (on the host); the last parameter is the name of the repo branch you want to use for the update; either "master" for production, or "develop" for the development branch. This is useful for either scheduled updates or build automation via Jenkins, etc. 

```
sudo docker exec qsrc gmat-update.sh <branch>
```

