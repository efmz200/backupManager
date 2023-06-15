#!/bin/bash
DATE=$(date '+%Y%m%d%H%M')
mkdir -p /neo4jbackup/$DATE
apk update
apk upgrade
apk add curl
az config set extension.use_dynamic_install=yes_without_prompt

#curl --user "$NEO4J_USERNAME:$NEO4J_PASSWORD" --data "dbms.allow_format_migration=true" -H "Content-Type: application/json" -X POST bolt://localhost:7687/db/manage/server/backup -o /neo4jbackup/$DATE/backup.zip
HOST=$(nslookup $NEO4J_CONNECTION_STRING | awk '/Address: / { print $2 }')
echo '----------------'
echo "$HOST"

neo4j-admin backup --database=graph.db --to=/neo4jbackup/$DATE/backup --username=NEO4J_USERNAME --password=NEO4J_PASSWORD

az storage blob directory upload --container $CONTAINER -s /neo4jbackup/$DATE -d $BACKUP_PATH --auth-mode key --recursive
rm -rf /neo4jbackup/$DATE

