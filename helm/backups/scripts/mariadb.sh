#!/bin/bash

DATE=$(date '+%Y%m%d%H%M')
mkdir -p /mariadbbackup/$DATE

apk update
apk upgrade
apk add mariadb-backup

az config set extension.use_dynamic_install=yes_without_prompt

mariabackup --backup \
   --target-dir=/mariadbbackup/$DATE/ \
   --user=$MARIADB_USERNAME --password=$MARIA_PASSWORD --port=$MARIA_PORT --host=$MARIADB_HOST

# mysqldump --host="$MYSQL_HOST" -u $MYSQL_USERNAME -p$MYSQL_PASSWORD --databases $MYSQL_DATABASE --single-transaction --compress --result-file=/mariadbbackup/$DATE/database.sql

az storage blob directory upload --container $CONTAINER -s /mariadbbackup/$DATE -d $BACKUP_PATH --auth-mode key --recursive

rm -rf /mariadbbackup/$DATE
