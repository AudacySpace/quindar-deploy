# Quindar UX Front End Server Dockerfile
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

	

#**** deploy quindar app ****
# deploy from github under /node
# node server should run on port 5000 > proxied via nginx to 443
# start command: npm start
#
ENV  repo https://github.com/quindar/quindar-ux.git
COPY node-update.sh /bin/node-update.sh
RUN  chmod a+x /bin/node-update.sh
RUN  mkdir -p /node  && \
	 git clone --verbose $repo /node  && \
	 cd /node && \
	 npm install
		
	

##############################################################################	

	
#**** start servers with container deploy
# 
# (1) nginx
# (2) node
# (3) netdata
#
# the last command can't exit, or the container will shutdown


EXPOSE 80 443
CMD /usr/sbin/nginx && \
	cd /node && (npm start &)  && \
	/usr/sbin/netdata -D -s /host -p 19999 
 
	


