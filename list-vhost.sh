#!/bin/bash
site=$1
if [ -z $site ]; then
  site=1
fi
for node in 0 1 2; do
  echo site-$site master-$node ...
  ./ssh-site.sh $site master-$node /sbin/ip -br addr show|grep vhost
done
