#!/bin/bash
projectPrefix='marcel'

for site in $projectPrefix-aws-tgw-site-1 $projectPrefix-aws-tgw-site-2; do
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

for site in $projectPrefix-aws-f5-xc-jumphost-1 $projectPrefix-aws-f5-xc-jumphost-2 $projectPrefix-f5-xc-bench-1 $projectPrefix-f5-xc-bench-2; do
  aws ec2 describe-instances \
  --filters \
    Name=tag:Name,Values=$site \
    Name=instance-state-name,Values=running \
  --query "Reservations[*].Instances[*].[Tags[?Key=='Name'].Value|[0],PublicIpAddress,PrivateIpAddress]" \
  --output=text | sort
done
