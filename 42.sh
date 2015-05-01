#!/bin/zsh

source variables.sh

function wait_reboot() {
    # TODO: functions to manage -e/-x state
    set +e
    echo 'D means waiting for host to go down, U means waiting to go up'
    # wait for box to go down first
    while ping -c 1 ${1} &>/dev/null; do
        sleep 0.5
        echo -n 'D'
    done
    echo ''
    # wait until it gets back up again
    while ! ping -c 1 ${1} &>/dev/null; do
        echo -n 'U'
    done
    set -e
}

set -e

wait_reboot ${BOXROOT_FQDN}
# starting sshd also takes a while, wait for it
set +e
nc -zw 90 ${BOXROOT_FQDN} 22
set -e
./sysinstall
wait_reboot ${BOXROOT_FQDN}
set +e
nc -zw 90 ${BOXROOT_FQDN} 22
set -e
./bootstrap
./install
