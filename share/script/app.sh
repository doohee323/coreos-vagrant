#!/usr/bin/env bash

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
etcdctl set /test hello --ttl 10
etcdctl get /test
etcdctl set /_test hello   # hidden
etcdctl get /_test

echo "##[test systemctl]####################################"
#systemctl start app.1.service
#journalctl -u app.1.service #-f
#docker ps -a

#systemctl stop app.1.service
#docker ps -a

echo "##[test service with fleet]####################################"
fleetctl start app.1.service
fleetctl start app.2.service
# fleetctl start app*

docker ps -a
fleetctl list-units
fleetctl journal app.1.service # fleetctl journal -f app.1.service
fleetctl stop app*

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

exit 0
