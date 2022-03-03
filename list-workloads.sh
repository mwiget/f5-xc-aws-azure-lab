#!/bin/bash

for site in marcel-aws-f5-xc-jumphost-1 marcel-aws-f5-xc-jumphost-2 marcel-aws-f5-xc-workload-1 marcel-aws-f5-xc-workload-2; do
  aws ec2 describe-instances \
  --filters \
    Name=tag:Name,Values=$site \
    Name=instance-state-name,Values=running \
  --query "Reservations[*].Instances[*].[Tags[?Key=='Name'].Value|[0],PublicIpAddress,PrivateIpAddress]" \
  --output=text | sort
done

