#!/bin/bash
DATE=$(date '+%Y%m%d%H%M')
mkdir -p /mariadbbackup/$DATE
apk update
apk upgrade
apk add mariadb-client
az config set extension.use_dynamic_install=yes_without_prompt
mysqldump --host="$MYSQL_HOST" -u $MYSQL_USERNAME -p$MYSQL_PASSWORD --databases $MYSQL_DATABASE --single-transaction --compress --result-file=/mariadbbackup/$DATE/database.sql
az storage blob directory upload --container $CONTAINER -s /mariadbbackup/$DATE -d $BACKUP_PATH --auth-mode key --recursive
rm -rf /mariadbbackup/$DATE
