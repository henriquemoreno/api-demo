#!/bin/bash
set -e

CANARY_SLOT=$1
PERCENT=$2

echo "$CANARY_SLOT" > state/canary-slot.txt
echo "$PERCENT" > state/canary-percent.txt

echo "🐤 Canary $PERCENT% → $CANARY_SLOT"
docker compose up -d nginx
