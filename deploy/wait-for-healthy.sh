#!/bin/bash

SERVICE_NAME="$1"

if [ -z "$SERVICE_NAME" ]; then
  echo "❌ Service name not provided"
  exit 1
fi

CONTAINER_ID=$(docker compose ps -q "$SERVICE_NAME")

if [ -z "$CONTAINER_ID" ]; then
  echo "❌ No container found for service $SERVICE_NAME"
  exit 1
fi

MAX_RETRIES=30
SLEEP_TIME=2

echo "⏳ Aguardando service '$SERVICE_NAME' ficar healthy..."

for i in $(seq 1 $MAX_RETRIES); do
  STATUS=$(docker inspect --format='{{.State.Health.Status}}' "$CONTAINER_ID" 2>/dev/null)

  if [ "$STATUS" = "healthy" ]; then
    echo "✅ Service '$SERVICE_NAME' está healthy!"
    exit 0
  fi

  echo "Tentativa $i/$MAX_RETRIES - status atual: ${STATUS:-desconhecido}"
  sleep $SLEEP_TIME
done

echo "❌ Service '$SERVICE_NAME' não ficou healthy a tempo"
docker logs "$CONTAINER_ID" || true
exit 1
