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

# 1️⃣ Garante IMAGE_TAG ANTES de qualquer compose
export IMAGE_TAG=${GITHUB_SHA:-latest}

# 2️⃣ Sobe o novo slot com a imagem correta
docker compose up -d apidemo-$NEW_SLOT

# 3️⃣ Aguarda o novo slot ficar READY
./wait-for-ready.sh "apidemo-$NEW_SLOT"

# 4️⃣ Só agora troca o tráfego
echo "$NEW_SLOT" > active-slot.txt
echo "✅ Tráfego trocado para $NEW_SLOT"

docker compose up -d nginx
