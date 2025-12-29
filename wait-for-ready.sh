#!/bin/bash

SERVICE=$1
MAX_ATTEMPTS=30
SLEEP_TIME=2

echo "⏳ Aguardando service '$SERVICE' ficar READY..."

for i in $(seq 1 $MAX_ATTEMPTS); do
  STATUS=$(docker inspect --format='{{.State.Health.Status}}' "$SERVICE" 2>/dev/null)

  echo "Tentativa $i/$MAX_ATTEMPTS - health: $STATUS"

  if [ "$STATUS" = "healthy" ]; then
    READY=$(docker exec "$SERVICE" curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/ready)

    if [ "$READY" = "200" ]; then
      echo "✅ Service '$SERVICE' está READY!"
      exit 0
    fi
  fi

  sleep $SLEEP_TIME
done

echo "❌ Service '$SERVICE' NÃO ficou READY a tempo"
exit 1
