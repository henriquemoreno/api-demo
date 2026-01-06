#!/bin/bash
set -e

ACTIVE_SLOT=$(cat active-slot.txt)

echo "🛑 ABORTANDO canary"
echo "↩️ Mantendo produção em: $ACTIVE_SLOT"

export ACTIVE_SLOT
unset CANARY_SLOT
unset CANARY_PERCENT

docker compose up -d nginx

echo "✅ Canary removido. Produção intacta."
