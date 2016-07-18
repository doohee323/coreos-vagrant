#!/usr/bin/env bash

set -x

### [update certs] ############################################################################################################
cd /home/core/share/resources
sudo cp /home/core/share/resources/domain.crt /etc/ssl/certs/domain.pem
sudo update-ca-certificates | grep domain

### [pull test image from external server with https] ##########################################################################
sudo docker login --username=testuser --password=testpassword --email= https://registry.tz.com:5000

sudo docker pull registry.tz.com:5000/testnode:0.1
sudo docker images

sudo docker run -d -p 3000:3000 --name node3 \
    registry.tz.com:5000/testnode:0.1

sleep 3
curl http://172.17.8.101:3000

exit 0