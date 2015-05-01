#!/bin/zsh

local -a packages_to_install
packages_to_install=(rxvt-unicode tree htop lsof iotop cpupower hdparm lshw wget curl net-tools ethtool)

local -a ssh_command
for package in "${packages_to_install[@]}"; do
    ssh_command+=( "installpkg ${package}" )
done

set -x

ssh root@${BOXROOT_FQDN} "/bin/zsh -ic '${(j:; :)ssh_command}'"
