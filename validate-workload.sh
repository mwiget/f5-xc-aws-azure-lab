#!/bin/bash
projectPrefix="marcel"

set -e
SECONDS=0

#echo -n "gathering private IP addresses from tgw sites and workloads ... "
#tgwIp=$(for site in aws-tgw-site-1 aws-tgw-site-2; do
#  aws ec2 describe-instances \
#  --filters \
#    Name=tag:ves-io-site-name,Values=$projectPrefix-$site \
#    Name=instance-state-name,Values=running \
#  --query "Reservations[*].Instances[*].[PrivateIpAddress]" \
#  --output=text
#  done)
#echo $tgwIp

echo -n "gathering workload IP addresses ... "
workloadIp=$(for site in aws-f5-xc-workload-1 aws-f5-xc-workload-2; do
  aws ec2 describe-instances \
  --filters \
    Name=tag:Name,Values=$projectPrefix-$site \
    Name=instance-state-name,Values=running \
  --query "Reservations[*].Instances[*].[PrivateIpAddress]" \
  --output=text
  done)
echo $workloadIp

for site in 1 2; do
  jumphost=$(aws ec2 describe-instances \
  --filters \
    Name=tag:Name,Values=$projectPrefix-aws-f5-xc-jumphost-$site \
    Name=instance-state-name,Values=running \
  --query "Reservations[*].Instances[*].[PublicIpAddress]" \
  --output=text)
  workload=$(aws ec2 describe-instances \
  --filters \
    Name=tag:Name,Values=$projectPrefix-aws-f5-xc-workload-$site \
    Name=instance-state-name,Values=running \
  --query "Reservations[*].Instances[*].[PrivateIpAddress]" \
  --output=text)

  echo -n "gathering tgw node IP addresses ... "
  nodes=$(aws ec2 describe-instances \
    --filters \
      Name=tag:ves-io-site-name,Values=$projectPrefix-aws-tgw-site-$site \
      Name=instance-state-name,Values=running \
    --query "Reservations[*].Instances[*].[PrivateIpAddress]" \
  --output=text)
  echo $nodes
  echo ""

  for ip in $nodes $workloadIp; do
    echo "ping $ip from workload-$site ($workload) via jumphost-$site ($jumphost) ..."
    ssh -q -o ProxyCommand="ssh -q -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -W %h:%p ubuntu@$jumphost" -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null" ubuntu@$workload ping -c3 -i 0.2 $ip
    if [ 0 == $? ]; then
      echo "SUCCESS"
    else
      echo "FAILED"
    fi
    echo ""
  done

done

echo "Successfully completed in $SECONDS seconds"
