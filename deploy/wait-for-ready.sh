#!/bin/bash
SERVICE=$1

for i in {1..60}; do
  STATUS=$(./deploy/_compose.sh ps --format json | jq -r ".[] | select(.Service==\"$SERVICE\") | .Health")
  if [ "$STATUS" = "healthy" ]; then
    echo "✅ $SERVICE está READY"
    exit 0
  fi
  echo "⏳ Aguardando $SERVICE ($i/60)"
  sleep 2
done

echo "❌ $SERVICE não ficou READY"
exit 1
