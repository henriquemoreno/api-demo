#!/bin/bash
set -e

ACTIVE=$(cat state/active-slot.txt)

echo "❌ Rollback para $ACTIVE"
echo "0" > state/canary-percent.txt

docker compose up -d nginx
