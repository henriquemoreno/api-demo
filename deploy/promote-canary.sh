#!/bin/bash
set -e

echo "🚀 Promovendo canary para 100%"

echo "ACTIVE_SLOT=green" > state/active-slot.txt
echo "CANARY_PERCENT=0" > state/canary-percent.txt
echo "CANARY_SLOT=" > state/canary-slot.txt

export ACTIVE_SLOT=green
export CANARY_PERCENT=0
export CANARY_SLOT=

docker compose up -d nginx

echo "✅ Produção 100% em GREEN"
