#!/bin/bash

NEW_SLOT=$(cat state/canary-slot.txt)

echo "🚀 Promovendo $NEW_SLOT para 100%"

echo "$NEW_SLOT" > state/active-slot.txt
echo "" > state/canary-slot.txt
echo "0" > state/canary-percent.txt

./deploy/_compose.sh up -d nginx
