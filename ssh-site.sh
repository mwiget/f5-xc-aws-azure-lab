#!/bin/bash
prefix="marcel-aws-tgw-site"
site="$prefix-$1"
if [ -z "$site" ]; then
  ./list-sites.sh
  exit
fi
shift
name=$1
if [ -z "$name" ]; then
  name="master-0"
fi
shift
echo -n "$site $name ..."

ip=$(aws ec2 describe-instances \
  --filters Name=tag:ves-io-creator-id,Values=m.wiget@f5.com \
  Name=tag:ves-io-site-name,Values=$site \
  Name=tag:Name,Values=$name \
  --query "Reservations[*].Instances[*].PublicIpAddress" \
  --output=text)
echo "$ip"
echo ssh -i ~/.ves-internal/staging/id_rsa vesop@$ip $@
ssh -q -i ~/.ves-internal/staging/id_rsa vesop@$ip $@
