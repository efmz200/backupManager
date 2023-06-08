#!/bin/bash
DATE=$(date '+%Y%m%d%H%M')
mkdir -p /couchdbdump/$DATE
apk update
apk upgrade
apk add  curl
az config set extension.use_dynamic_install=yes_without_prompt
curl -X POST http://databases-couchdb.default.svc.cluster.local:5984/_replicate -H "Content-Type: application/json" -d '{
  "source": "http://localhost:5984",
  "target": "/couchdbdump/'$DATE'",
  "create_target": true
}'
az storage blob directory upload --container $CONTAINER -s /couchdbdump/$DATE -d $BACKUP_PATH --auth-mode key --recursive
rm -rf /couchdbdump/$DATE
