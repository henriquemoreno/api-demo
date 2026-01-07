#!/bin/bash
set -e

SERVICE=$1
MAX=60

for i in $(seq 1 $MAX); do
  if docker compose exec -T $SERVICE curl -sf http://localhost:8080/ready > /dev/null; then
    echo "✅ $SERVICE READY"
    exit 0
  fi
  sleep 2
done

echo "❌ $SERVICE NÃO ficou READY"
exit 1
