#!/bin/bash

DATE=$(date '+%Y%m%d%H%M')
mkdir -p /mariadump/$DATE
apk update
apk upgrade
apk add mysql-client
az config set extension.use_dynamic_install=yes_without_prompt
echo '----------------'
ls mariadump/$DATE
echo '----------------'
echo "host: $HOST"
echo "user: $MARIA_USERNAME"
echo "password: $MARIA_PASSWORD"
echo "port: $MARIA_PORT"
echo "container: $CONTAINER"
echo "backup path: $BACKUP_PATH"	
echo '----------------'

mysqldump -u "$MARIA_USERNAME" -p"$MARIA_PASSWORD" --host="$MARIADB_HOST" --port="$MARIA_PORT" --all-databases > "/mariadump/$DATE/backup.sql" && zip "/mariadump/$DATE/backup.zip" "/mariadump/$DATE/backup.sql"
echo '----------------'
ls mariadump/$DATE
echo '----------------'
ls mariadump/
echo '----------------'
az storage blob directory upload --container $CONTAINER -s /mariadump/$DATE -d $BACKUP_PATH --auth-mode key --recursive


rm -rf /mariadump/$DATE
