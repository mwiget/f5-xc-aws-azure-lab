#!/bin/bash
set -e
SECONDS=0

echo "============================="
echo "launching ./validate-nodes.sh"
echo "============================="
./validate-nodes.sh

echo "================================="
echo "launching ./validate-workload.sh"
echo "================================="
./validate-workload.sh

echo "Successfully completed in $SECONDS seconds"
