#!/bin/bash

mkdir -p /postgresqlbackup
apk update
apk upgrade
apk add postgresql-client
az config set extension.use_dynamic_install=yes_without_prompt

az storage blob directory download -c "$CONTAINER" --account-name "$AZURE_STORAGE_ACCOUNT" -s postgres -d /postgresqlbackup --recursive --verbose --auth-mode key

export PGPASSWORD="$POSTGRES_PASSWORD"
echo '----------------'
echo password: $POSTGRES_PASSWORD
echo host: $POSTGRES_HOST
echo user: $POSTGRES_USERNAME
echo port: $POSTGRES_PORT
echo '----------------'
ls /postgresqlbackup/postgres/$DATE/
echo '----------------'
psql --username="$POSTGRES_USERNAME" --port="$POSTGRES_PORT" --host="databases-postgresql" --file="/postgresqlbackup/postgres/$DATE/backup.sql" "$POSTGRES_DATABASE"
#pg_restore --username="$POSTGRES_USERNAME"  --port="$POSTGRES_PORT" --host="$POSTGRES_HOST" --verbose -d template0 < "/postgresqlbackup/postgres/$DATE/backup.sql"
#pg_restore --username=$POSTGRES_USERNAME --dbname=$POSTGRES_DB --host=$POSTGRES_HOST --port=$POSTGRES_PORT --verbose "/postgresqlbackup/postgres/$DATE/backup.sql"

#pg_dumpall --username="$POSTGRES_USERNAME" --PGPASSWORD=="$POSTGRES_PASSWORD" --port="$POSTGRES_PORT" --host="$POSTGRES_HOST" < /postgresqlbackup/postgres/$DATE/backup.sql
exit_code=$?
echo "Código de salida: $exit_code"

#az storage blob directory upload --container $CONTAINER -s /postgresqlbackup/$DATE -d $BACKUP_PATH --auth-mode key --recursive
rm -rf /postgresqlbackup/$DATE


