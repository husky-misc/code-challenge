#!/bin/sh
set -e

cp ./scripts/nginx/default.conf /etc/nginx/conf.d/default.conf

echo "starting NGINX"
mkdir -p /run/nginx
nginx

echo "starting PUMA"
bundle exec puma -C config/puma.rb
