#!/bin/bash
site=$1
prefix="marcel-aws-f5-xc"
if [ -z "$site" ]; then
  site=1
fi
shift

name="$prefix-jumphost-$site"
echo -n "ssh ubuntu@$name ... "
ipj=$(aws ec2 describe-instances \
  --filters Name=instance-state-name,Values=running \
  Name=tag:Name,Values=$name \
  --query "Reservations[*].Instances[*].PublicIpAddress" \
  --output=text)
  echo -n "(via $ipj) ... "

name="$prefix-workload-$site"
ip=$(aws ec2 describe-instances \
  --filters Name=instance-state-name,Values=running \
  Name=tag:Name,Values=$name \
  --query "Reservations[*].Instances[*].PrivateIpAddress" \
  --output=text)
  echo "($ip) ... "

echo "ssh -J ubuntu@$ipj ubuntu@$ip $@"
ssh -J ubuntu@$ipj ubuntu@$ip $@
