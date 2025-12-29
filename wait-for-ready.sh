#!/bin/bash
set -e

SERVICE_NAME="$1"   # ex: api-demo-apidemo-green-1
MAX_RETRIES=30
SLEEP_TIME=2

if [ -z "$SERVICE_NAME" ]; then
  echo "❌ Nome do container não informado"
  echo "Uso: ./wait-for-ready.sh <container_name>"
  exit 1
fi

echo "⏳ Aguardando container '$SERVICE_NAME' ficar READY..."

for i in $(seq 1 $MAX_RETRIES); do
  if docker inspect "$SERVICE_NAME" >/dev/null 2>&1; then
    if docker exec "$SERVICE_NAME" curl -sf http://localhost:8080/ready >/dev/null; then
      echo "✅ Container '$SERVICE_NAME' está READY!"
      exit 0
    fi
  fi

  echo "Tentativa $i/$MAX_RETRIES - ainda não READY"
  sleep $SLEEP_TIME
done

echo "❌ Container '$SERVICE_NAME' NÃO ficou READY a tempo"
exit 1
