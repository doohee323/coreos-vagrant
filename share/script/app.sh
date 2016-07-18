#!/usr/bin/env bash

set -x

### [update certs] ############################################################################################################
sudo cp /home/core/share/resources/domain.pem /etc/ssl/certs/domain.pem
#echo "domain.crt" | sudo tee -a /etc/ca-certificates.conf
sudo update-ca-certificates | grep domain

### [pull test image from external server with https] ##########################################################################
sudo docker login --username=testuser --password=testpassword https://registry.tz.com:5000






exit 0