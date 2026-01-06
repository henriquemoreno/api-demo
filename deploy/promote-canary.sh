#!/bin/bash
set -e

NEW_SLOT=$1

if [ -z "$NEW_SLOT" ]; then
  echo "❌ Informe o slot a promover (blue|green)"
  exit 1
fi

echo "🚀 PROMOVENDO slot: $NEW_SLOT"

echo "$NEW_SLOT" > active-slot.txt

export ACTIVE_SLOT=$NEW_SLOT
unset CANARY_SLOT
unset CANARY_PERCENT

docker compose up -d nginx

echo "✅ $NEW_SLOT agora é PRODUÇÃO (100%)"
