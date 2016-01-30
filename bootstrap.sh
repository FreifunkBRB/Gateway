#!/usr/bin/env bash

#
# add repositories
#
cat >> /etc/apt/sources.list.d/freifunk.list <<EOF
deb http://http.debian.net/debian jessie-backports main
deb-src http://security.debian.org/ jessie/updates main

deb http://ftp.de.debian.org/debian/ jessie main contrib non-free
deb-src http://ftp.de.debian.org/debian/ jessie main contrib non-free

deb http://ftp.de.debian.org/debian/ jessie-updates main
deb-src http://ftp.de.debian.org/debian/ jessie-updates main
EOF

apt-get update
apt-get upgrade

#
# install dependencies
#
apt-get install -y build-essential linux-headers-amd64 git gnupg-curl 

#
# install batman-adv
#
cd ~ 
git clone https://github.com/freifunk-gluon/batman-adv-legacy
cd batman-adv-legacy 
make
make install

#
# enable batman-adv
#
modprobe batman-adv 
echo 'batman-adv' > /etc/modules

#
# at this point the kernel module ist loaded and we can spin up the docker containers
#
apt-get install -y docker.io


#
# Setup the network bridges
#

