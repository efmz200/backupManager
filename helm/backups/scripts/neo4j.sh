#!/bin/bash
DATE=$(date '+%Y%m%d%H%M')
mkdir -p /neo4jbackup/$DATE
apk update
apk upgrade
apk add curl
az config set extension.use_dynamic_install=yes_without_prompt
curl --user "$NEO4J_USERNAME:$NEO4J_PASSWORD" --data "dbms.allow_format_migration=true" -H "Content-Type: application/json" -X POST http://databases-neo4j.default.svc.cluster.local:7474/db/manage/server/backup -o /neo4jbackup/$DATE/backup.zip
az storage blob directory upload --container $CONTAINER -s /neo4jbackup/$DATE -d $BACKUP_PATH --auth-mode key --recursive
rm -rf /neo4jbackup/$DATE

