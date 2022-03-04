#!/bin/bash
projectPrefix="marcel"
for site in $projectPrefix-f5-xc-bench-1 $projectPrefix-f5-xc-bench-2; do
  aws ec2 describe-instances \
  --filters \
    Name=tag:Name,Values=$site \
    Name=instance-state-name,Values=running \
  --query "Reservations[*].Instances[*].[Tags[?Key=='Name'].Value|[0],PublicIpAddress,PrivateIpAddress]" \
  --output=text | sort
done

