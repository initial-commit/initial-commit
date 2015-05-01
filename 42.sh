#!/bin/zsh

source variables.sh

set -e
set -x

nc -zw 60 ${BOXROOT_FQDN} 22
./sysinstall
# wait for box to go down first
set +x
while ping -c 1 ${BOXROOT_FQDN} &>/dev/null; do
    echo -n 'W'
done
# wait until it gets back up again
while ! ping -c 1 ${BOXROOT_FQDN} &>/dev/null; do
    echo -n 'U'
done
set -x
# starting sshd also takes a while, wait for it
nc -zw 60 ${BOXROOT_FQDN} 22
./bootstrap
#nc -zw 60 ${BOXROOT_FQDN} 22
#./install
