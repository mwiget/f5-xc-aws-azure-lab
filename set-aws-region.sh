#!/bin/bash
region=$1
current=$(grep awsRegion */*tfvars | cut -d\" -f2| uniq)
if [ -z "$region" ]; then
  echo "Usage: $0 region"
  echo ""
  echo "current region set to $current"
  exit 1
fi
if [ -z "$(echo $region | cut -d- -sf3)" ]; then
  echo "$region doesn't look like a valid region"
  exit 1
fi
echo "changing region from $current -> $region ..."
for file in $(ls tgw*/*\.tf tgw*/*\.tfvars base-aws*/*\.tf base-aws*/*\.tfvars); do
  sed -i "s/$current/$region/" $file
done
