#!/usr/bin/env bash

sudo su
set -x

echo '##########' >> /home/core/.profile
echo 'alias "ll=ls -al"' >> /home/core/.profile

cd /home/core
source .profile

# install shipyard
#curl -sSL https://shipyard-project.com/deploy | bash -s

ip addr show | grep 'inet 172.'

mkdir -p /home/core/share/resources
ssh-keygen -b 4096 -t rsa -f ~/.ssh/id_rsa -q -N ""
ssh-add ~/.ssh/id_rsa
ID_RSD=/home/core/share/resources/$HOSTNAME
cat ~/.ssh/id_rsa.pub > $ID_RSD

exit 0

# install shipyard
ACTION=deploy PORT=5003 DISCOVERY=etcd://192.168.1.5:4001 bash shipyard.sh
curl http://10.0.2.15:5003

# update firewall iptable info
cd /home/core/share/resources
coreos-cloudinit --from-file=user-data
# call iptable update
cd /home/core/share/service
fleetctl start firewall.service
