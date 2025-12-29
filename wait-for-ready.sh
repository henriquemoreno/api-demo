#!/bin/bash
set -e

CONTAINER_NAME=$1
MAX_ATTEMPTS=30
SLEEP_TIME=2

if [ -z "$CONTAINER_NAME" ]; then
  echo "❌ Nome do container não informado"
  exit 1
fi

echo "⏳ Aguardando container '$CONTAINER_NAME' ficar READY..."

for i in $(seq 1 $MAX_ATTEMPTS); do
  STATUS=$(docker exec "$CONTAINER_NAME" curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/ready || true)

  if [ "$STATUS" = "200" ]; then
    echo "✅ Container '$CONTAINER_NAME' está READY!"
    exit 0
  fi

  echo "Tentativa $i/$MAX_ATTEMPTS - ainda não READY (HTTP $STATUS)"
  sleep $SLEEP_TIME
done

echo "❌ Container '$CONTAINER_NAME' NÃO ficou READY a tempo"
exit 1
