#!/bin/zsh

ssh 'rm -rf /tmp/bootstrap' root@${BOXROOT_IP}
#TODO long term: when it's done, use git archive - only versioned files get in
rm -rf /tmp/bootstrap.tar
tar --exclude-vcs --exclude-vcs-ignore --create --file /tmp/bootstrap.tar .
scp -q -B /tmp/bootstrap.tar root@${BOXROOT_IP}:/tmp
ssh 'mkdir /tmp/bootstrap/; cd /tmp/bootstrap/; tar -xf ../bootstrap.tar' root@${BOXROOT_IP}
