#!/bin/bash
set -e

SLOT=$1
PERCENT=$2

echo "$SLOT" > canary-slot.txt
echo "$PERCENT" > canary-percent.txt

docker compose up -d nginx

echo "🧪 Canary $PERCENT% ativo para $SLOT"
