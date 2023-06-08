#!/bin/bash
DATE=$(date '+%Y%m%d%H%M')
mkdir -p /postgresqlbackup/$DATE
apk update
apk upgrade
apk add postgresql-client
az config set extension.use_dynamic_install=yes_without_prompt
pg_dump --host="$POSTGRESQL_HOST" -U $POSTGRESQL_USERNAME -d $POSTGRESQL_DATABASE --file=/postgresqlbackup/$DATE/database.sql
az storage blob directory upload --container $CONTAINER -s /postgresqlbackup/$DATE -d $BACKUP_PATH --auth-mode key --recursive
rm -rf /postgresqlbackup/$DATE