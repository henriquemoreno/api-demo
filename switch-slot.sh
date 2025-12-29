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
echo "🚀 Tentando ativar slot: $NEW_SLOT"

# Aguarda o container novo ficar READY
./wait-for-ready.sh "apidemo-$NEW_SLOT"

# Só troca tráfego se passou no READY
echo "$NEW_SLOT" > active-slot.txt
echo "✅ Tráfego trocado para $NEW_SLOT"

# Garante que o nginx suba com a imagem correta
export IMAGE_TAG=${GITHUB_SHA:-latest}

docker compose up -d nginx
