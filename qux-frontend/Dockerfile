# Quindar UX Front End Server Dockerfile
#

FROM centos:latest
MAINTAINER quindar@audacy.space


# run system update & open SSH
RUN yum -y update --setopt=tsflags=nodocs 
EXPOSE 22



# #**** install webmin ****
# RUN yum  -y install wget
# RUN yum  -y install perl perl-Net-SSLeay openssl perl-IO-Tty 
# RUN wget http://prdownloads.sourceforge.net/webadmin/webmin-1.810-1.noarch.rpm
# RUN rpm  -U webmin-1.810-1.noarch.rpm 
# EXPOSE 10000
# # set webmin login
# RUN /usr/libexec/webmin/changepass.pl /etc/webmin root quindartone
# # start server
# RUN /etc/webmin/start
# #**** install webmin ****


#**** install netdata ****
# https://github.com/firehol/netdata

# prep system
RUN yum -y install zlib-devel libuuid-devel libmnl-devel gcc make git autoconf autoconf-archive autogen automake pkgconfig curl

# download it - the directory 'netdata' will be created
RUN git clone https://github.com/firehol/netdata.git --depth=1
RUN cd netdata

# build it, install it, start it
RUN ./netdata-installer.sh

EXPOSE 19999
