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

ADD .vnc /root/.vnc
ADD .config /root/.config
ADD Desktop /root/Desktop
ADD scripts /root/scripts
RUN chmod +x  /root/scripts/*.sh /root/.vnc/xstartup /etc/xdg/xfce4/xinitrc /root/Desktop/*.desktop
RUN /bin/dbus-uuidgen > /etc/machine-id


	
#**** noVNC HTML5 based VNC viewer ****
#	
# https://github.com/kanaka/noVNC
#
ENV NO_VNC_HOME /root/noVNC

RUN mkdir -p $NO_VNC_HOME/utils/websockify && \
    wget -qO- https://github.com/kanaka/noVNC/archive/master.tar.gz | tar xz --strip 1 -C $NO_VNC_HOME  && \
    wget -qO- https://github.com/kanaka/websockify/archive/v0.7.0.tar.gz | tar xz --strip 1 -C $NO_VNC_HOME/utils/websockify && \
    chmod +x -v /root/noVNC/utils/*.sh	
	

	

##############################################################################	

	
#**** start servers with container deploy
# 
# (1) netdata [19999]
# (2) xvnc [5901] & NoVNC [6901] servers
#
# the last command can't exit, or the container will shutdown


EXPOSE 5901 6901 19999
CMD /root/scripts/vnc_startup.sh  && \
	/usr/sbin/netdata -D -s /host -p 19999 
 
	


