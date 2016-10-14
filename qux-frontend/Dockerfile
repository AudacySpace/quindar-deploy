# Quindar UX Front End Server Dockerfile
#

FROM centos:latest
MAINTAINER quindar@audacy.space
LABEL vendor="Audacy"


# run system update & install utils
RUN yum -y update --setopt=tsflags=nodocs   && \
	yum -y install git wget nano curl make


#**** install netdata ****
# https://github.com/firehol/netdata/wiki/Installation
# https://github.com/firehol/netdata/wiki/Running-behind-nginx
# netdata is proxied behind nginx, and accessible at \\hostname\netdata
# start command /usr/sbin/netdata -D -s /host -p 19999
#
 RUN yum -y install zlib-devel libuuid-devel libmnl-devel gcc make autoconf autoconf-archive autogen automake pkgconfig   && \
	git clone https://github.com/firehol/netdata.git --depth=1    && \
	cd netdata && \
	./netdata-installer.sh --dont-wait --dont-start-it 
	
	
	
#**** install nginx ****
# server root    /usr/share/nginx/html
# server config  /etc/nginx/nginx.conf
# vhost  config  /etc/nginx/conf.d/default.conf
# start command  /usr/sbin/nginx

RUN yum install -y epel-release && \
	yum install -y nginx
	COPY nginx.conf /etc/nginx/nginx.conf
	
# Download certificate and copy to the build context
# ADD nginx-repo.crt /etc/ssl/nginx/
# ADD nginx-repo.key /etc/ssl/nginx/
	

	
#**** install node ****
# https://nodejs.org/en/download/package-manager/#enterprise-linux-and-fedora

RUN yum install -y gcc-c++    && \
	curl --silent --location https://rpm.nodesource.com/setup_4.x | bash - && \
	yum -y install nodejs  && \
	npm install -g bower && \
	npm install -g gulp  && \
	npm install -g mean-cli



#**** deploy quindar app ****
# TBA
	
	
	
#**** start servers with container deploy
# the last command can't exit, or the container will shutdown

EXPOSE 80 443
CMD /usr/sbin/nginx && \
	/usr/sbin/netdata -D -s /host -p 19999
	


