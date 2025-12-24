#!/bin/bash

CONTAINER_NAME="apidemo"
MAX_RETRIES=30
SLEEP_TIME=2

echo "⏳ Aguardando container ficar healthy..."

for i in $(seq 1 $MAX_RETRIES); do
  STATUS=$(docker inspect --format='{{.State.Health.Status}}' $CONTAINER_NAME 2>/dev/null)

  if [ "$STATUS" = "healthy" ]; then
    echo "✅ Container está healthy!"
    exit 0
  fi

  echo "Tentativa $i/$MAX_RETRIES - status atual: ${STATUS:-desconhecido}"
  sleep $SLEEP_TIME
done

echo "❌ Container não ficou healthy a tempo"
docker logs $CONTAINER_NAME || true
exit 1
