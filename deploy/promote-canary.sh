#!/bin/bash
set -e

echo "🚀 Promovendo deployment para 100% no slot GREEN"

# Atualiza estado
echo "green" > state/active-slot.txt
echo "0" > state/canary-percent.txt
echo "" > state/canary-slot.txt

# Exporta para o nginx
export ACTIVE_SLOT=green
export CANARY_PERCENT=0
export CANARY_SLOT=

# Recarrega apenas o nginx
docker compose up -d nginx

echo "✅ Produção estabilizada 100% em GREEN"
