#!/bin/bash

for site in marcel-aws1-tgw-site-1 marcel-aws2-tgw-site-2; do
  echo "$site:" 
  aws ec2 describe-instances \
  --filters Name=tag:ves-io-creator-id,Values=m.wiget@f5.com \
  --filters Name=tag:ves-io-site-name,Values=$site \
  --query "Reservations[*].Instances[*].[Tags[?Key=='Name'].Value|[0],PublicIpAddress,PrivateIpAddress]" \
  --output=text | sort
  echo ""
done

