#!/bin/bash
projectPrefix="marcel"

SECONDS=0

set -e    # exit script on error

echo -n "gathering public ip ... "
bench1=$(aws ec2 describe-instances \
  --filters \
    Name=tag:Name,Values=$projectPrefix-f5-xc-bench-1 \
    Name=instance-state-name,Values=running \
  --query "Reservations[*].Instances[*].[PublicIpAddress]" \
  --output=text)
bench2=$(aws ec2 describe-instances \
  --filters \
    Name=tag:Name,Values=$projectPrefix-f5-xc-bench-2 \
    Name=instance-state-name,Values=running \
  --query "Reservations[*].Instances[*].[PublicIpAddress]" \
  --output=text)

echo "bench1 ($bench1) bench2 ($bench2)"

echo ""
echo "testing connectivity via VPC peering ..."
echo "from bench1 -> bench2 ..."
ssh -q -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null" ubuntu@$bench1 ping -c3 -i 0.2 10.64.32.102
echo "from bench2 -> bench1 ..."
ssh -q -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null" ubuntu@$bench2 ping -c3 -i 0.2 10.64.0.101
echo ""

echo "testing connectivity via tgw sites ..."
echo "from bench1 -> bench2 ..."
ssh -q -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null" ubuntu@$bench1 ping -c3 -i 0.2 10.0.34.102
echo "from bench2 -> bench1 ..."
ssh -q -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null" ubuntu@$bench2 ping -c3 -i 0.2 10.0.2.101
echo ""

echo "iperf3 via VPC peering connection (baseline 20 parallel streams) ..."
ssh -q -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null" ubuntu@$bench1 iperf3 --parallel 20 --interval 0 -c 10.64.32.102 | grep SUM|grep receiver
ssh -q -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null" ubuntu@$bench1 iperf3 --parallel 20 --interval 0 -c 10.64.32.102 --reverse | grep SUM|grep receiver
echo ""

echo "iperf3 via aws tgw sites (20 parallel streams) ..."
ssh -q -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null" ubuntu@$bench1 iperf3 --parallel 20 --interval 0 -c 10.0.34.102 | grep SUM|grep receiver
ssh -q -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null" ubuntu@$bench1 iperf3 --parallel 20 --interval 0 -c 10.0.34.102 --reverse | grep SUM|grep receiver
echo ""

echo "Successfully completed in $SECONDS seconds"
