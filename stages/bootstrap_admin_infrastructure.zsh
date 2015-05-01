#!/bin/zsh

local -a packages_to_install
packages_to_install=(rxvt-unicode tree htop lsof iotop cpupower hdparm lshw wget curl net-tools ethtool)

for package in "${packages_to_install[@]}"; do
    installpkg "${package}"
done
