#!/bin/bash
set -e

echo "🚀 Promovendo produção para 100% GREEN"

echo "green" > state/active-slot.txt
echo "0" > state/canary-percent.txt
echo "" > state/canary-slot.txt

export ACTIVE_SLOT=green
export CANARY_PERCENT=0
export CANARY_SLOT=

docker compose up -d nginx

echo "✅ Produção estabilizada"
