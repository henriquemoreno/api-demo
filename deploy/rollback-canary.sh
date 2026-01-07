#!/bin/bash
set -e

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT_DIR"

echo "❌ Rollback para BLUE"

echo "blue" > state/active-slot.txt
echo "0" > state/canary-percent.txt
echo "" > state/canary-slot.txt

export ACTIVE_SLOT=blue
export CANARY_PERCENT=0
export CANARY_SLOT=

docker compose up -d nginx

echo "✅ Rollback concluído"
