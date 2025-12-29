#!/bin/bash
set -e

SERVICE_NAME=$1
MAX_ATTEMPTS=60
SLEEP_TIME=2

if [ -z "$SERVICE_NAME" ]; then
  echo "❌ Nome do service não informado"
  exit 1
fi

echo "⏳ Aguardando service '$SERVICE_NAME' ficar READY..."

for i in $(seq 1 $MAX_ATTEMPTS); do
  CONTAINER_ID=$(docker compose ps -q "$SERVICE_NAME" | head -n 1)

  if [ -n "$CONTAINER_ID" ]; then
    STATUS=$(docker exec "$CONTAINER_ID" curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/ready || true)

    if [ "$STATUS" = "200" ]; then
      echo "✅ Service '$SERVICE_NAME' está READY!"
      exit 0
    fi
  fi

  echo "Tentativa $i/$MAX_ATTEMPTS - ainda não READY"
  sleep $SLEEP_TIME
done

echo "❌ Service '$SERVICE_NAME' NÃO ficou READY a tempo"
exit 1
