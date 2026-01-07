#!/bin/bash

ACTIVE=$(cat state/active-slot.txt)

echo "❌ Rollback para $ACTIVE"

echo "" > state/canary-slot.txt
echo "0" > state/canary-percent.txt

./deploy/_compose.sh up -d nginx
