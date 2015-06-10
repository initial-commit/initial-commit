#!/bin/zsh

# Script to generate the iptables configuration file.
# The port knocking sequence is taken from sensitive.sh.

source sensitive.sh
ports=(${=BOXROOT_KNOCK_SEQUENCE})
noOfPorts=${#ports}

echo "*filter"
echo ":INPUT DROP [0:0]"
echo ":FORWARD DROP [0:0]"
echo ":OUTPUT ACCEPT [0:0]"
echo ":TRAFFIC - [0:0]"
for ((arg = 1; arg < $noOfPorts; arg++))
do
    echo ":SSH-INPUT$arg - [0:0]"
done
echo ""
echo "-A INPUT -j TRAFFIC"
echo "-A TRAFFIC -p icmp --icmp-type any -j ACCEPT"
echo "-A TRAFFIC -m state --state ESTABLISHED,RELATED -j ACCEPT"
echo ""
echo "-A TRAFFIC -m state --state NEW -m tcp -p tcp --dport 22 -m recent --rcheck --seconds 30 --name SSH$(($noOfPorts - 1)) -j ACCEPT"
echo "-A TRAFFIC -m state --state NEW -m tcp -p tcp -m recent --name SSH$(($noOfPorts - 1)) --remove -j DROP"
echo ""
for ((arg = noOfPorts; arg > 1; arg--))
do
    echo "-A TRAFFIC -m state --state NEW -m tcp -p tcp --dport ${ports[arg]} -m recent --rcheck --name SSH$(($arg - 2)) -j SSH-INPUT$(($arg - 1))"
    echo "-A TRAFFIC -m state --state NEW -m tcp -p tcp -m recent --name SSH$(($arg - 1)) --remove -j DROP"
    echo ""
done
echo "-A TRAFFIC -m state --state NEW -m tcp -p tcp --dport $ports[1] -m recent --name SSH0 --set -j DROP"
echo ""
for ((arg = 1; arg < $noOfPorts; arg++))
do
    echo "-A SSH-INPUT$arg -m recent --name SSH$arg --set -j DROP"
done
echo "-A TRAFFIC -j DROP"
echo "COMMIT"
