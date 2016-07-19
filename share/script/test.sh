#!/usr/bin/env bash

sudo su
set -x

cd /home/core/share/service

echo "##[test etcdctl]####################################"
etcdctl ls
etcdctl ls --recursive
etcdctl set /test hello
etcdctl get /test
etcdctl rm /test
etcdctl get /test
etcdctl watch /test &
#etcdctl -o extended watch /test &  # debugging
etcdctl set /test hello --ttl 10
etcdctl get /test
etcdctl set /_test hello   # hidden
etcdctl get /_test

etcdctl exec-watch --recursive /test -- sh -c "env | grep ETCD"
etcdctl set /test/bar 1

echo "##[test systemctl]####################################"
cd /etc/systemd/system
cp /home/core/share/service/hello.service .
systemctl enable hello.service
systemctl disable hello.service
systemctl enable hello.service
systemctl start hello.service
#systemctl status hello.service
#journalctl -u hello.service #-f
docker ps -a
exit
#systemctl stop hello.service
#docker ps -a

echo "##[test service with fleet]####################################"
fleetctl start app.1.service
fleetctl start app.2.service
# fleetctl start app*

docker ps -a
fleetctl list-units
fleetctl journal app.1.service # fleetctl journal -f app.1.service
fleetctl stop app*
fleetctl destroy app*

echo "##[test global service with fleet]####################################"
fleetctl start global.service
docker ps -a
fleetctl list-units
fleetctl stop global.service

echo "##[test service with fleet template]####################################"
fleetctl submit app@.service
fleetctl list-unit-files
fleetctl start app@{1..2}.service
fleetctl list-units
fleetctl journal app@1.service

echo "##[test discovery with fleet]####################################"
fleetctl start web.service
fleetctl load web-discovery.service  # only save
fleetctl start web-discovery.service
etcdctl get /services/web/nginx
fleetctl cat web-discovery.service

echo "##[system monitoring]####################################"
systemctl status -l fleet
systemctl status -l etcd
journalctl -b -u etcd

vi .toolboxrc
TOOLBOX_DOCKER_IMAGE=debian
TOOLBOX_DOCKER_TAG=jessie
TOOLBOX_DOCKER_USER=root
toolbox






exit 0
