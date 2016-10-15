# quindar-deploy
Files needed to deploy (install) Quindar.


## Architecture

Quindar has three components:

1. The front end (gui)          > quindar-ux
2. The backend (server)         > quindar-svr
3. The simulator (data source)  > quindar-src




## qux Install

Step 1 - Install the pre-requisites on the host server

* Install Git, e.g. `yum install -y git`
* Install Docker (see https://docs.docker.com/engine/installation/)

Step 2 - Clone this repository 
```
git clone https://github.com/quindar/quindar-deploy
```

Step 3 - Build & Deploy the frontend server
```
cd quindar-deploy/qux-frontend
docker build -t "quindar:ux" .
docker run -d -t --cap-add SYS_PTRACE -v /proc:/host/proc:ro -v /sys:/host/sys:ro -p 80:80 -p 443:443 quindar:ux
```

If you want to remove old images use `docker rm $(docker ps -a -q)`. The nginx server is deployed with self-signed certificates which will throw security warnings in your browser. In a production environment, SSH into the server and (1) update server name, (2) install your own certs. 

```
server certificate  /etc/ssl/server.crt
server key          /etc/ssl/server.key
restart nginx       nginx -s reload
```



## qsvr Install

To be added.



## qsrc Install

To be added.