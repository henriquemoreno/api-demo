#!/bin/bash
set -e

NEW_SLOT=$1
CANARY_PERCENT=10

if [ -z "$NEW_SLOT" ]; then
  echo "❌ Informe o slot (blue|green)"
  exit 1
fi

ACTIVE_SLOT=$(cat active-slot.txt)

echo "🟡 Ativando CANARY"
echo "➡️ Produção: $ACTIVE_SLOT"
echo "➡️ Canary: $NEW_SLOT (${CANARY_PERCENT}%)"

export ACTIVE_SLOT
export CANARY_SLOT=$NEW_SLOT
export CANARY_PERCENT

docker compose up -d nginx

echo "✅ Canary ativo (${CANARY_PERCENT}% → $NEW_SLOT)"
echo "⏸️ Aguardando decisão: promover ou abortar"
