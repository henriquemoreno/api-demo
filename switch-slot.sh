#!/bin/bash

ACTIVE_SLOT=$(cat active-slot.txt)
NEW_SLOT=$1

echo "🔁 Slot ativo atual: $ACTIVE_SLOT"
echo "🚀 Tentando ativar slot: $NEW_SLOT"

if ! ./wait-for-ready.sh "api-demo-apidemo-$NEW_SLOT-1"; then
  echo "❌ Novo slot não ficou READY. Mantendo $ACTIVE_SLOT"
  exit 1
fi

echo "$NEW_SLOT" > active-slot.txt
echo "✅ Tráfego trocado para $NEW_SLOT"

docker compose up -d nginx
