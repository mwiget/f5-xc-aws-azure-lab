#!/bin/bash
site=$1
prefix="marcel-f5-xc"
if [ -z "$site" ]; then
  site=1
fi
shift

name="$prefix-bench-$site"
echo -n "ssh ubuntu@$name ... "
ip=$(aws ec2 describe-instances \
  --filters Name=instance-state-name,Values=running \
  Name=tag:Name,Values=$name \
  --query "Reservations[*].Instances[*].PublicIpAddress" \
  --output=text)
  echo -n "($ip) ... "

ssh ubuntu@$ip $@
