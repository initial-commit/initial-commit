#!/bin/zsh

# Tool to open the port 22 on the server.
#
# Requires as argument the host name/ip address of the server.
#
# The port knocking sequence is taken from sensitive.sh.

source sensitive.sh
setopt shwordsplit

host=$1
for port in $BOXROOT_KNOCK_SEQUENCE
do
    nmap -Pn --host_timeout 100 --max-retries 0 -p $port $host
done
