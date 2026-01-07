#!/bin/bash
set -e

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT_DIR"

SLOT=$1
PERCENT=$2

echo "⚠️ Habilitando canary: $PERCENT% → $SLOT"

echo "$SLOT" > state/canary-slot.txt
echo "$PERCENT" > state/canary-percent.txt

export ACTIVE_SLOT=$(cat state/active-slot.txt)
export CANARY_SLOT=$SLOT
export CANARY_PERCENT=$PERCENT

docker compose up -d nginx
