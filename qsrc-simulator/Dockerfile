# Quindar SRC source (simulation) Server Dockerfile
#

FROM centos:latest
MAINTAINER quindar@audacy.space
LABEL vendor="Audacy"


# run system update & install utils
RUN yum -y update --setopt=tsflags=nodocs   && \
	yum -y install git wget nano curl make  && \
    yum -y update; yum clean all

##############################################################################


#**** install xfce ****
ENV TERM xterm
RUN yum -y install epel-release && \
	yum --enablerepo=epel -y -x gnome-keyring --skip-broken groups install "Xfce"  && \
	yum -y groupinstall "Desktop" "Desktop Platform" "X Window System" "Fonts" && \
    yum -y update; yum clean all


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
	
	
#**** install vnc server ****
# VNC server port      : 5901
# start command        : /root/scripts/vnc_startup.sh
# default vnc password : vncpassword
# NoVNC web URL        : http://localhost:6901/vnc_auto.html?password=vncpassword

ENV DISPLAY :1
ENV VNC_COL_DEPTH 24
ENV VNC_RESOLUTION 1280x1024
ENV VNC_PW vncpassword

RUN yum -y install tigervnc-server net-tools  && \
    yum -y update; yum clean all

ADD ./vnc/.vnc /root/.vnc
ADD ./vnc/.config /root/.config
ADD ./vnc/scripts /root/scripts
RUN mkdir -p /root/Desktop
RUN chmod +x  /root/scripts/*.sh /root/.vnc/xstartup /etc/xdg/xfce4/xinitrc
RUN /bin/dbus-uuidgen > /etc/machine-id


	
#**** noVNC HTML5 based VNC viewer ****
#	
# https://github.com/kanaka/noVNC
#
ENV NO_VNC_HOME /root/noVNC
RUN yum -y install which  && \
    yum -y update; yum clean all

RUN mkdir -p $NO_VNC_HOME/utils/websockify && \
    wget -qO- https://github.com/kanaka/noVNC/archive/master.tar.gz | tar xz --strip 1 -C $NO_VNC_HOME  && \
    wget -qO- https://github.com/kanaka/websockify/archive/v0.7.0.tar.gz | tar xz --strip 1 -C $NO_VNC_HOME/utils/websockify && \
    chmod +x -v /root/noVNC/utils/*.sh	
	

	
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

COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./nginx/server.crt /etc/ssl/server.crt
COPY ./nginx/server.key /etc/ssl/server.key
COPY ./nginx/index.html /usr/share/nginx/html
COPY ./nginx/redirect.html $NO_VNC_HOME/index.html
RUN  chmod 600  /etc/ssl/server.key


#**** install Python ****
# 
RUN yum -y groupinstall "Development Tools" && \
	yum -y install csh 						&& \
	yum -y install gtk3-devel				&& \
	yum -y install freeglut-devel			&& \
	yum -y install cmake					&& \	
    yum -y update; yum clean all	

RUN wget https://www.python.org/ftp/python/3.4.3/Python-3.4.3.tar.xz
RUN tar xf Python-3.* 
RUN /bin/sh -c 'cd /Python-3.*; ./configure --enable-shared'
RUN /bin/sh -c 'cd /Python-3.*; LD_RUN_PATH=/usr/local/lib make'
RUN /bin/sh -c 'cd /Python-3.*; make altinstall'


#**** install GMAT ****
# 
# deploy from github under /gmat
#
ENV  repo https://github.com/quindar/quindar-gmat.git
RUN  mkdir -p /gmat  && \
	 git clone --verbose $repo /gmat  

COPY gmat-update.sh /bin/gmat-update.sh
RUN  chmod a+x /bin/gmat-update.sh
RUN  cd /gmat && ln -s /gmat /root/Desktop/NASA-GMAT


	

##############################################################################	

	
#**** start servers with container deploy
# 
# (1) nginx (80,443)
# (2) xvnc [5901] > NoVNC [6901] server > nginx [443]
# (3) netdata [19999] > nginx [80]
#
# the last command can't exit, or the container will shutdown


EXPOSE 80 443
CMD /usr/sbin/nginx && \
	/root/scripts/vnc_startup.sh  && \
	/usr/sbin/netdata -D -s /host -p 19999 
 
	


