#!/usr/bin/env bash

set -x

echo '##########' >> /home/core/.profile
echo 'alias "ll=ls -al"' >> /home/core/.profile

cd /home/core
source .profile

# install shipyard
#curl -sSL https://shipyard-project.com/deploy | bash -s

ip addr show | grep 'inet 172.'

ssh-keygen -b 4096 -t rsa -f ~/.ssh/id_rsa -q -N ""
ssh-add ~/.ssh/id_rsa
ID_RSD=/home/core/share/resources/$HOSTNAME
cat ~/.ssh/id_rsa.pub > $ID_RSD

if [ "$HOSTNAME" = "core-02" ]; then
	cat /home/core/share/resources/core-01 >> ~/.ssh/authorized_keys
fi

if [ "$HOSTNAME" = "core-01" ]; then
	cat /home/core/share/resources/core-02 >> ~/.ssh/authorized_keys
fi

bash /home/core/share/script/app.sh

exit 0
