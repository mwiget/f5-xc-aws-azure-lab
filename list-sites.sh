#!/bin/bash

for site in marcel-aws-tgw-site-1 marcel-aws-tgw-site-2; do
  echo "$site:" 
  aws ec2 describe-instances \
  --filters \
    Name=tag:ves-io-creator-id,Values=m.wiget@f5.com \
    Name=tag:ves-io-site-name,Values=$site \
    Name=instance-state-name,Values=running \
  --query "Reservations[*].Instances[*].[Tags[?Key=='Name'].Value|[0],PublicIpAddress,PrivateIpAddress]" \
  --output=text | sort
  echo ""
done

