#!/bin/bash
SLOT=$1
PERCENT=$2

echo "$SLOT" > state/canary-slot.txt
echo "$PERCENT" > state/canary-percent.txt

./deploy/_compose.sh up -d nginx
