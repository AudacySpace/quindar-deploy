# Quindar UX Front End Server Dockerfile
#

FROM centos:latest
MAINTAINER quindar@audacy.space
EXPOSE 22 10000 19999

# run system update & open SSH
RUN yum -y update --setopt=tsflags=nodocs 




# #**** install webmin ****
# RUN yum  -y install wget
# RUN yum  -y install perl perl-Net-SSLeay openssl perl-IO-Tty 
# RUN wget http://prdownloads.sourceforge.net/webadmin/webmin-1.810-1.noarch.rpm
# RUN rpm  -U webmin-1.810-1.noarch.rpm 
# # set webmin login
# RUN /usr/libexec/webmin/changepass.pl /etc/webmin root quindartone
# # start server
# RUN /etc/webmin/start
# #**** install webmin ****


#**** install netdata ****
# https://github.com/firehol/netdata/wiki/Installation

# prep system
RUN yum -y install zlib-devel libuuid-devel libmnl-devel gcc make git autoconf autoconf-archive autogen automake pkgconfig curl

# download it - the directory 'netdata' will be created
RUN git clone https://github.com/firehol/netdata.git --depth=1
RUN cd netdata && ./netdata-installer.sh --dont-wait && /
	ln -sf /dev/stdout /var/log/netdata/access.log && /
	ln -sf /dev/stdout /var/log/netdata/debug.log && /
	ln -sf /dev/stderr /var/log/netdata/error.log

