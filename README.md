# quindar-deploy
Files needed to deploy (install) Quindar.


## Architecture

Quindar has three components:

1. The front end (gui)          > quindar-ux
2. The backend (server)         > quindar-svr
3. The simulator (data source)  > quindar-src




## Install

To deploy quindar using docker, do the following:

### Pre-Requisits
1. Install Git, e.g. `yum install -y git`
2. Install Docker (see https://docs.docker.com/engine/installation/)

### Docker Deploy
1. Clone this repository 
```
git clone https://github.com/quindar/quindar-deploy
```

2. Build & Deploy the frontend server
```
cd qux-frontend
docker build -t "quindar:ux" .
docker run -d -t --cap-add SYS_PTRACE -v /proc:/host/proc:ro -v /sys:/host/sys:ro -p 80:80 -p 443:443 quindar:ux
```

Note: to remove / clean old images use `docker rm $(docker ps -a -q)`

3. Notes on Security

The server is deployed with self-signed certificates which will throw security warnings in your browser. In a production environment, SSH into the server and (1) update server name, (2) install your own certs. 

```
server certificate  /etc/ssl/server.crt
server key          /etc/ssl/server.key
restart nginx       nginx -s reload
```



### Monitor

Note : the netdata monitor is acessible via //hostname/netdata

