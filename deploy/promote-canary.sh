#!/bin/bash
set -e

SLOT=$(cat canary-slot.txt)

echo "$SLOT" > active-slot.txt
rm -f canary-slot.txt canary-percent.txt

docker compose up -d nginx

echo "🚀 Slot $SLOT promovido para 100%"
