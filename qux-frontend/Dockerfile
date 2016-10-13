# Quindar UX Front End Server Dockerfile
#

FROM centos:latest
MAINTAINER quindar@audacy.space


# run system update & open SSH
RUN yum -y update --setopt=tsflags=nodocs 
EXPOSE 22

## install webmin
RUN yum  -y install wget
RUN yum  -y install perl perl-Net-SSLeay openssl perl-IO-Tty 
RUN wget http://prdownloads.sourceforge.net/webadmin/webmin-1.810-1.noarch.rpm
RUN rpm  -U webmin-1.810-1.noarch.rpm 
EXPOSE 10000

## set webmin login
RUN /usr/libexec/webmin/changepass.pl /etc/webmin root quindartone

## start server
RUN /etc/webmin/start




# install netdata
# RUN curl -Ss 'https://raw.githubusercontent.com/firehol/netdata-demo-site/master/install-required-packages.sh' >/tmp/kickstart.sh && bash /tmp/kickstart.sh netdata
# RUN curl -Ss 'https://raw.githubusercontent.com/firehol/netdata-demo-site/master/install-required-packages.sh' >/tmp/kickstart.sh && bash /tmp/kickstart.sh netdata-all
# EXPOSE 19999
