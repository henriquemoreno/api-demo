#!/bin/bash
set -e

ACTIVE_SLOT=$(cat active-slot.txt)

if [ "$ACTIVE_SLOT" = "blue" ]; then
  NEW_SLOT="green"
else
  NEW_SLOT="blue"
fi

echo "🔁 Slot ativo atual: $ACTIVE_SLOT"
echo "🚀 Novo slot: $NEW_SLOT"

# Atualiza nginx.conf apontando para o novo slot
sed -i "s/apidemo-$ACTIVE_SLOT/apidemo-$NEW_SLOT/g" infra/nginx/nginx.conf

# Atualiza o arquivo de estado
echo "$NEW_SLOT" > active-slot.txt

echo "✅ Tráfego trocado para $NEW_SLOT"
