#!/usr/bin/env bash

set -x

echo '##########' >> /home/core/.profile
echo 'alias "ll=ls -al"' >> /home/core/.profile

cd /home/core
source .profile

cd share/script
bash app.sh

exit 0
