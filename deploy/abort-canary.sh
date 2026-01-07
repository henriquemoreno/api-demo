#!/bin/bash
set -e

rm -f canary-slot.txt canary-percent.txt

docker compose up -d nginx

echo "❌ Canary abortado"
