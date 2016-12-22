# Quindar SVR Back End Server (proxy) Dockerfile
#

FROM centos:latest
MAINTAINER quindar@audacy.space
LABEL vendor="Audacy"


# run system update & install utils
RUN yum -y update --setopt=tsflags=nodocs   && \
	yum -y install git wget nano curl make dos2unix


##############################################################################
	
#**** install netdata ****
# https://github.com/firehol/netdata/wiki/Installation
# https://github.com/firehol/netdata/wiki/Running-behind-nginx
# netdata is proxied behind nginx, and accessible at \\hostname\netdata
# start command /usr/sbin/netdata -D -s /host -p 19999
#
 RUN yum -y install zlib-devel libuuid-devel libmnl-devel gcc autoconf autoconf-archive autogen automake pkgconfig python tc python-yaml  && \
	git clone https://github.com/firehol/netdata.git --depth=1    && \
	cd netdata && \
	./netdata-installer.sh --dont-wait --dont-start-it 


#**** install node ****
# https://nodejs.org/en/download/package-manager/#enterprise-linux-and-fedora
# 
# start command: npm start & 

RUN yum install -y gcc-c++    && \
	curl --silent --location https://rpm.nodesource.com/setup_4.x | bash - && \
	yum -y install nodejs  && \
	npm install -g bower && \
	npm install -g gulp  && \
	npm install -g mean-cli && \
	npm install -g pm2


#**** install Mongo db ****
# https://docs.mongodb.com/v3.2/tutorial/install-mongodb-on-red-hat/
# 
# NOTE: in a production setup you should use a separate db server / service. 
# This included db is just used for demonstration & development use. 
# 
# server config  /etc/mongod.conf
# start command  /usr/bin/mongod
# file location  /data/db
# logs location  /var/log/mongodb
# port number    27017

# Create a /etc/yum.repos.d/mongodb-org-3.2.repo file so that you can install MongoDB directly, using yum.
RUN echo $'[mongodb-org-3.2] \n\
name	=	MongoDB Repository	\n\
baseurl	=	https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/3.2/x86_64/ \n\
gpgcheck=	1 \n\
enabled	=	1 \n\
gpgkey	=	https://www.mongodb.org/static/pgp/server-3.2.asc' > /etc/yum.repos.d/mongodb-org-3.2.repo
		  
RUN yum install -y mongodb-org && \
	mkdir -p /data/db
	

#**** deploy quindar proxy app ****
# deploy from github under /node/proxy
# node server should run on port 5000 > proxied via nginx to 443
# start command: npm start
#
ENV  repo https://github.com/quindar/quindar-proxy.git
COPY proxy-update.sh /bin/proxy-update.sh

RUN  dos2unix  /bin/proxy-update.sh  && \
	 chmod a+x /bin/proxy-update.sh
	 
RUN  mkdir -p /node/proxy  && \
	 git clone --verbose $repo /node/proxy && \
	 cd /node/proxy && \
	 npm install	

	 
#**** setup adminMongo on node
# deploy under /node/adminMongo
# node server runs on port 1234 > proxied via nginx to 443
# start command: npm start
# connection string for db : mongodb://admin@localhost
# the UI will be up on https://hostname/adminMongo/
RUN  mkdir -p /node/adminMongo  && \
	 cd /node/adminMongo && \
	 npm install admin-mongo

# file needed to proxy adminMongo in a subfolder URL
# see http://adminmongo.com/docs/
COPY ./node/app.json /node/adminMongo/config/app.json
	 
	
#**** install nginx ****
# server root    /usr/share/nginx/html
# server config  /etc/nginx/nginx.conf
# start command  /usr/sbin/nginx
#
# NOTE: the server is deployed with self-signed certificates which will throw
#       security warnings in your browser. In a production environment, SSH into
#       the server and (1) update server name, (2) install your own certs.
# 		Self-signed certs for your specific org can be generated using:
#
# openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/server.key -out /etc/ssl/server.crt
# nginx -s reload
#

RUN yum install -y epel-release && \
	yum install -y nginx && \
	mkdir -p /etc/ssl

COPY nginx/server.crt /etc/ssl/server.crt
COPY nginx/server.key /etc/ssl/server.key
COPY nginx/index.html /usr/share/nginx/html
COPY nginx/nginx.conf /etc/nginx/nginx.conf
RUN  chmod 600  /etc/ssl/server.key

	
##############################################################################	

	
#**** start servers with container deploy
# 
# (1) nginx
# (2) netdata 				[19999] > [ 80]
# (3) node > adminMongo		[ 1234] > [443/db]
# (4) node > proxyApp       [ 5000] > [443]
# (5) mongodb 				[27017]
#
# the last command can't exit, or the container will shutdown


EXPOSE 80 443 27017
CMD /usr/sbin/nginx && \
	/usr/sbin/netdata -s /host -p 19999 && \
	cd /node/proxy && (pm2 start index.js --no-daemon --watch --log-date-format "YYYY-MM-DD HH:mm:ss Z" &) && \
	cd /node/adminMongo && (npm start &)  && \
	/usr/bin/mongod
 
	


