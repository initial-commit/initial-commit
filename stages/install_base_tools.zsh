#!/bin/zsh

./configs/iptables.sh | ssh root@${BOXROOT_FQDN} "/bin/zsh -ic 'cat - > /etc/iptables/iptables.rules'"

pushd /etc/iptables > /dev/null
git add iptables.rules
git commit -m "Generated iptables config"
popd > /dev/null

