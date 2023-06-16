#!/bin/bash
DATE=$(date '+%Y%m%d%H%M')
mkdir -p /postgresqlbackup/$DATE
apk update
apk upgrade
apk add postgresql-client
az config set extension.use_dynamic_install=yes_without_prompt
export PGPASSWORD="$POSTGRES_PASSWORD"
echo '----------------'
echo password: $POSTGRES_PASSWORD
echo '----------------'
pg_dump --username=$POSTGRES_USERNAME --dbname=$POSTGRES_DB  --host=databases-postgresql --file=/postgresqlbackup/$DATE/backup.sql


az storage blob directory upload --container $CONTAINER -s /postgresqlbackup/$DATE -d $BACKUP_PATH --auth-mode key --recursive
rm -rf /postgresqlbackup/$DATE


