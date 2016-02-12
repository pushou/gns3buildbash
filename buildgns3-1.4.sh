#!/bin/bash
#


apt-get update && apt-get upgrade -y  && apt-get install -y \
 git  \
 wget \
 bzip2 \
 build-essential \
 libpcap-dev \
 uuid-dev \
 libelf-dev \
 cmake \
 python3-setuptools \
 python3-pyqt5 \
 python3-pyqt5.qtsvg \
 python3-ws4py \
 python3-netifaces \
 python3-zmq \
 python3-tornado \
 python3-dev \
 bison \
 flex \
 lib32z1 \
 lib32ncurses5 \
 lxterminal \
 telnet \
 python \
 wireshark \ 
 debconf \
 locales \
 flex \
 bison \ 
 apt-utils \
 debconf-utils \
 iproute2 \
 net-tools \
 libpcap-dev \
 cpulimit \
 vpcs


#
# -----------------------------------------------------------------
# compile and install dynamips, gns3-server, gns3-gui
#
mkdir /opt/gns3
cd /opt/gns3; git clone https://github.com/GNS3/dynamips.git
cd /opt/gns3/dynamips ; git checkout v0.2.15
mkdir /opt/gns3/dynamips/build
cd /opt/gns3/dynamips/build ;  cmake .. ; make ; make install
#
cd /opt/gns3; git clone https://github.com/GNS3/gns3-gui.git
cd /opt/gns3; git clone https://github.com/GNS3/gns3-server.git
cd /opt/gns3/gns3-server ; git checkout v1.4.0 ; python3 setup.py install
cd /opt/gns3/gns3-gui ; git checkout v1.4.0 ; python3 setup.py install
#
#-----------------------------------------------------------------------
# compile and install vpcs, 64 bit version
#
#cd /opt/gns3 ; \
#    wget -O - http://sourceforge.net/projects/vpcs/files/0.8/vpcs-0.8-src.tbz/download \
#    | bzcat | tar -xvf -
#cd /opt/gns3/vpcs-*/opt/gns3 ; ./mk.sh 64
# cp /opt/gns3/vpcs-*/opt/gns3/vpcs /usr/local/bin/vpcs
#
# --------------------------------------------------------------------
# compile and install iniparser (needed for iouyap) and 
# iouyap (needed to run iou without additional virtual machine)
#
git clone http://github.com/ndevilla/iniparser.git
cd iniparser ; make; \
cp libiniparser.* /usr/lib ; \
cp src/iniparser.h /usr/local/include/ ; \
cp src/dictionary.h /usr/local/include/
#
cd /opt/gns3 ; git clone https://github.com/GNS3/iouyap.git
#COPY iniparser.h /opt/gns3/iouyap/iniparser/iniparser.h
cd /opt/gns3/iouyap ; make
ls /opt/gns3/iouyap
cd /opt/gns3/iouyap ; cp iouyap /usr/local/bin
#
# to run iou 32 bit support is needed so add i386 repository, cannot be done
# before compiling dynamips
#
dpkg --add-architecture i386
apt-get update && apt-get -y install \ 
   libssl-dev:i386 \
   libssl1.0.0:i386 \
   qemu \
   uml-utilities \
   iptables
#
# ---------------------------------------------------------------------------
# these links are needed to run IOU

ln -s /usr/lib/i386-linux-gnu/libcrypto.so /usr/lib/i386-linux-gnu/libcrypto.so.4
#


#
# prepare startup files /opt/gns3/misc
#
mkdir /opt/gns3/misc
#
# install gnome connection manager
#
cd /opt/gns3/misc; wget http://kuthulu.com/gcm/gnome-connection-manager_1.1.0_all.deb
#RUN cd /opt/gns3/misc; wget http://va.ler.io/myfiles/deb/gnome-connection-manager_1.1.0_all.deb
apt-get -y install expect python-vte python-glade2
mkdir -p /usr/share/desktop-directories
(while true;do echo;done) | perl -MCPAN -e 'install JSON::Tiny'
(while true;do echo;done) | perl -MCPAN -e 'install File::Slurp'

cd /opt/gns3
git clone https://github.com/GNS3/ubridge.git

cd ubridge
make && make install
