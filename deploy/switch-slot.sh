#!/bin/bash
set -e

ACTIVE_SLOT=$(cat active-slot.txt)
NEW_SLOT=$1

if [ -z "$NEW_SLOT" ]; then
  echo "❌ Novo slot não informado (blue ou green)"
  exit 1
fi

if [ "$NEW_SLOT" = "$ACTIVE_SLOT" ]; then
  echo "ℹ️ Slot $NEW_SLOT já está ativo. Nada a fazer."
  exit 0
fi

echo "🔁 Slot ativo atual: $ACTIVE_SLOT"
echo "🚀 Preparando deploy do slot: $NEW_SLOT"

# Aguarda o novo slot ficar READY
./deploy/wait-for-ready.sh "api-demo-apidemo-$NEW_SLOT-1"

# Promove o slot
echo "$NEW_SLOT" > active-slot.txt
echo "✅ Tráfego trocado para $NEW_SLOT"

export IMAGE_TAG=${IMAGE_TAG:-latest}
docker compose up -d nginx
