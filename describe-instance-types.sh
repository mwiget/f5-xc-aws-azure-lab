#!/bin/bash
for type in c5 c5n t4g; do
  aws ec2 describe-instance-types \
    --filters "Name=instance-type,Values=$type.*" \
    --query "InstanceTypes[].{InstanceType:InstanceType, Speed:NetworkInfo.NetworkPerformance, MaxIntf:NetworkInfo.MaximumNetworkInterfaces, VCPU:VCpuInfo.DefaultVCpus}" \
    --output table
done
