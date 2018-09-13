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
	curl --silent --location https://rpm.nodesource.com/setup_8.x | bash - && \
	yum -y install nodejs  && \
	npm install -g bower && \
	npm install -g gulp  && \
	npm install -g mean-cli && \
	npm install -g pm2

#**** deploy quindar proxy app ****
# deploy from github under /node/proxy
# node server should run on port 5000 > proxied via nginx to 443
# start command: npm start
#
ENV  repo https://github.com/AudacySpace/quindar-proxy.git
COPY proxy-update.sh /bin/proxy-update.sh

RUN  dos2unix  /bin/proxy-update.sh  && \
	 chmod a+x /bin/proxy-update.sh
	 
RUN  mkdir -p /node/proxy  && \
	 git clone --verbose $repo /node/proxy && \
	 cd /node/proxy && \
	 npm install	
	
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

# create volume to share nginx logs with filebeat
RUN  chmod 755  /var/log/nginx
VOLUME /var/log/nginx

# create a directory to store the uploaded files
RUN  mkdir -p /tmp/uploads

#**** install logrotate for pm2 ****
RUN pm2 install pm2-logrotate && \
	pm2 set pm2-logrotate:compress true && \
	pm2 set pm2-logrotate:retain 7
	
##############################################################################	

	
#**** start servers with container deploy
# 
# (1) nginx
# (2) netdata 				[19999] > [ 80]
# (3) node > proxyApp       [ 5000] > [443]
#
# the last command can't exit, or the container will shutdown


EXPOSE 80 443
CMD /usr/sbin/nginx && \
	cd /node/proxy && (pm2 start index.js --no-daemon --watch --log-date-format "YYYY-MM-DD HH:mm:ss Z" &) && \
	/usr/sbin/netdata -D -s /host -p 19999
