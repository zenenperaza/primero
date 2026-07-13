#!/usr/bin/env bash
set -e

cd /home/zenenperaza/primero

echo "1. Actualizando código desde GitHub..."
git pull --ff-only origin main

echo "2. Construyendo imagen de Primero..."
docker build -f docker/application/Dockerfile . \
  -t primeroims/application:latest \
  --build-arg APP_ROOT=/srv/primero/application \
  --build-arg RAILS_LOG_PATH=/srv/primero/application/log/primero \
  --build-arg APP_UID=1000 \
  --build-arg APP_GID=1000 \
  --build-arg BUILD_REGISTRY=

echo "3. Reiniciando application y worker..."
cd /home/zenenperaza/primero/docker

docker compose -p primero --profile solr --profile db --profile app \
  -f docker-compose.yml \
  -f docker-compose.db.yml \
  -f docker-compose.prod.yml \
  up -d --force-recreate application worker

echo "4. Verificando servicio..."
docker ps

curl -I https://sistemaprimero.online/v2/login

echo "Listo. Primero actualizado."

