#!/bin/bash
DATE=$(date '+%Y%m%d%H%M')
mkdir -p /postgresqlbackup/$DATE
apk update
apk upgrade
apk add postgresql-client
az config set extension.use_dynamic_install=yes_without_prompt



pg_dumpall --username="$POSTGRES_USERNAME" --password="$POSTGRES_PASSWORD" --port="$POSTGRES_PORT" --host="$POSTGRES_HOST" > /postgresqlbackup/$DATE/backup.sql
echo '----------------'
ls /postgresqlbackup/$DATE
echo '----------------'
az storage blob directory upload --container $CONTAINER -s /postgresqlbackup/$DATE -d $BACKUP_PATH --auth-mode key --recursive
rm -rf /postgresqlbackup/$DATE


