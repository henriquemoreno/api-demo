#!/bin/bash
set -e

SERVICE=$1
MAX_RETRIES=60
SLEEP=2

if [ -z "$SERVICE" ]; then
  echo "❌ Serviço não informado"
  exit 1
fi

echo "⏳ Aguardando $SERVICE ficar READY..."

for i in $(seq 1 $MAX_RETRIES); do
  if curl -sf http://localhost:8080/health > /dev/null; then
    echo "✅ $SERVICE está READY"
    exit 0
  fi

  echo "⏳ Aguardando $SERVICE ($i/$MAX_RETRIES)"
  sleep $SLEEP
done

echo "❌ $SERVICE não ficou READY a tempo"
exit 1
