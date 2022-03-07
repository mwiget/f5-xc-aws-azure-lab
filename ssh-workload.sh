#!/bin/bash
site=$1
prefix="marcel-aws-f5-xc-jumphost"
if [ -z "$site" ]; then
  site=1
fi
shift

name="$prefix-$site"
echo -n "ssh ubuntu@$name ... "
ip=$(aws ec2 describe-instances \
  --filters Name=instance-state-name,Values=running \
  Name=tag:Name,Values=$name \
  --query "Reservations[*].Instances[*].PublicIpAddress" \
  --output=text)
  echo "($ip) ... "

ssh ubuntu@$ip $@
