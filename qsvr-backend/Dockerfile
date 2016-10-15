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

	

##############################################################################	

	
#**** start servers with container deploy
# 
# (1) netdata
#
# the last command can't exit, or the container will shutdown


EXPOSE 19999
CMD /usr/sbin/netdata -D -s /host -p 19999 
 
	


