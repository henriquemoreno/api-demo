#!/bin/sh
set -e

echo "▶️ Gerando nginx.conf com envsubst"
envsubst < /etc/nginx/templates/nginx.conf.template \
  > /etc/nginx/conf.d/default.conf

exec nginx -g 'daemon off;'
