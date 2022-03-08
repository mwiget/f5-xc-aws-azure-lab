#!/bin/bash
projectPrefix="marcel"

set -e
SECONDS=0

echo -n "gathering private IP addresses from tgw sites and workloads ... "
tgwIp=$(for site in aws-tgw-site-1 aws-tgw-site-2; do
  aws ec2 describe-instances \
  --filters \
    Name=tag:ves-io-site-name,Values=$projectPrefix-$site \
    Name=instance-state-name,Values=running \
  --query "Reservations[*].Instances[*].[PrivateIpAddress]" \
  --output=text
  done)
echo $tgwIp

echo "testing node to node connectivity across clusters ..."
for site in aws-tgw-site-1 aws-tgw-site-2; do
  node=$(aws ec2 describe-instances \
  --filters \
    Name=tag:ves-io-site-name,Values=$projectPrefix-$site \
    Name=instance-state-name,Values=running \
  --query "Reservations[*].Instances[*].[PublicIpAddress]" \
  --output=text)
  for nodeIp in $node; do
    for ip in $tgwIp; do
      echo "ping node $ip from $site ($nodeIp)..."
      ssh -q -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null" -i ~/.ves-internal/staging/id_rsa vesop@$nodeIp ping -c3 -i 0.2 $ip
      if [ 0 == $? ]; then
        echo "SUCCESS"
      else
        echo "FAILED"
      fi
      echo ""
    done
  done
done

echo "Successfully completed in $SECONDS seconds"
