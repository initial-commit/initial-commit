#!/bin/zsh

set +e
ssh root@${BOXROOT_IP} 'rm -rf /tmp/bootstrap'
set -e

#TODO long term: when it's done, use git archive - only versioned files get in
rm -rf /tmp/bootstrap.tar
tar --exclude-vcs --exclude-vcs-ignore --create --file /tmp/bootstrap.tar .
scp -q -B /tmp/bootstrap.tar root@${BOXROOT_IP}:/tmp
ssh root@${BOXROOT_IP} 'mkdir /tmp/bootstrap/; cd /tmp/bootstrap/; tar -xf ../bootstrap.tar'
