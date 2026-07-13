#!/usr/bin/env bash
set -e

APP_DIR="/home/zenenperaza/primero"
APP_CONTAINER="primero-application-1"
WORKER_CONTAINER="primero-worker-1"
CONTAINER_DIR="/srv/primero/application"

cd "$APP_DIR"

echo "1. Actualizando código desde GitHub..."
git pull --ff-only origin main

echo "2. Copiando archivos modificados al contenedor..."
docker cp app/javascript/components/record-list/create-record-dialog/component.jsx "$APP_CONTAINER:$CONTAINER_DIR/app/javascript/components/record-list/create-record-dialog/component.jsx"
docker cp config/locales/es.yml "$APP_CONTAINER:$CONTAINER_DIR/config/locales/es.yml"
docker cp config/locales/en.yml "$APP_CONTAINER:$CONTAINER_DIR/config/locales/en.yml"

echo "3. Regenerando traducciones y assets dentro del contenedor..."
docker exec "$APP_CONTAINER" sh -lc "cd $CONTAINER_DIR && rails primero:i18n_js && npm run build"

echo "4. Reiniciando Primero..."
docker restart "$APP_CONTAINER" "$WORKER_CONTAINER"

echo "5. Verificando..."
curl -I https://sistemaprimero.online/v2/login

echo "Listo. Actualización rápida aplicada."
