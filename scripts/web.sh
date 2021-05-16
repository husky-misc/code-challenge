#!/bin/sh
set -e

sed -i -e s/\$APP_DOMAIN/$APP_DOMAIN/g ./scripts/nginx/default.conf
cp ./scripts/nginx/default.conf /etc/nginx/conf.d/default.conf

echo "starting NGINX"
mkdir -p /run/nginx
nginx

echo "starting PUMA"
bundle exec puma -C config/puma.rb
