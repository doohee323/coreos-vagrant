#!/usr/bin/env bash

sudo su
set -x

# with fleetctl
# fleetctl start nodejs.service

### [update certs] ############################################################################################################
cd /home/core/share/resources
cp /home/core/share/resources/domain.crt /etc/ssl/certs/domain.pem
update-ca-certificates | grep domain

### [pull test image from external server with https] ##########################################################################
docker login --username=testuser --password=testpassword --email= https://registry.tz.com:5000

docker pull registry.tz.com:5000/testnode:0.1
docker images

docker run -d -p 3000:3000 --name node3 \
    registry.tz.com:5000/testnode:0.1

sleep 3
curl http://172.17.8.101:3000

exit 0