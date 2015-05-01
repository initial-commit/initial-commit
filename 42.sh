#!/bin/zsh

source variables.sh

set -e
set -x

nc -zw 60 ${BOXROOT_FQDN} 22
./sysinstall
nc -zw 60 ${BOXROOT_FQDN} 22
./bootstrap
#nc -zw 60 ${BOXROOT_FQDN} 22
#./install
