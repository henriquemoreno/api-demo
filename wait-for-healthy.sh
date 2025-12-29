#!/bin/bash

CONTAINER_NAME="${1}"

if [ -z "$CONTAINER_NAME" ]; then
  echo "❌ Container name not provided"
  exit 1
fi

MAX_RETRIES=30
SLEEP_TIME=2

echo "⏳ Aguardando container '$CONTAINER_NAME' ficar healthy..."

for i in $(seq 1 $MAX_RETRIES); do
  STATUS=$(docker inspect --format='{{.State.Health.Status}}' "$CONTAINER_NAME" 2>/dev/null)

  if [ "$STATUS" = "healthy" ]; then
    echo "✅ Container '$CONTAINER_NAME' está healthy!"
    exit 0
  fi

  echo "Tentativa $i/$MAX_RETRIES - status atual: ${STATUS:-desconhecido}"
  sleep $SLEEP_TIME
done

echo "❌ Container '$CONTAINER_NAME' não ficou healthy a tempo"
docker logs "$CONTAINER_NAME" || true
exit 1
