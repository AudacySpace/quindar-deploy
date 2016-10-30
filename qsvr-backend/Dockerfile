# Quindar SVR Back End Server Dockerfile
#

FROM centos:latest
MAINTAINER quindar@audacy.space
LABEL vendor="Audacy"


# run system update & install utils
RUN yum -y update --setopt=tsflags=nodocs   && \
	yum -y install git wget nano curl make


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
	npm install -g mean-cli

	
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

COPY nginx.conf /etc/nginx/nginx.conf
COPY server.crt /etc/ssl/server.crt
COPY server.key /etc/ssl/server.key
RUN  chmod 600  /etc/ssl/server.key
COPY index.html /usr/share/nginx/html


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
	
# create default admin user
COPY mongo_init.js /data/mongo_init.js
RUN mongo admin /data/mongo_init.js


#**** setup adminMongo
# deploy under /node/adminMongo
# node server runs on port 1234 > proxied via nginx to 443
# start command: npm start
#
RUN  mkdir -p /node/adminMongo  && \
	 cd /node/adminMongo && \
	 npm install admin-mongo
	

##############################################################################	

	
#**** start servers with container deploy
# 
# (1) nginx
# (2) netdata
# (3) node
# (4) mongodb
#
# the last command can't exit, or the container will shutdown


EXPOSE 80 443 27017
CMD /usr/sbin/nginx && \
	/usr/sbin/netdata -s /host -p 19999 && \
	cd /node/adminMongo && (npm start &)  && \
	/usr/bin/mongod
 
	


