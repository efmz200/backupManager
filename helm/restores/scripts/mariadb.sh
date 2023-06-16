#!/bin/bash
mkdir -p /mariadump/$DATE
apk update
apk upgrade
apk add mysql-client
az config set extension.use_dynamic_install=yes_without_prompt

mkdir -p /mariarestore/$DATE

az storage blob directory download --container $CONTAINER -s /mariarestore/$DATE --file "$DESTINATION_PATH" --auth-mode key

mysqldump -u "$MARIA_USERNAME" -p"$MARIA_PASSWORD" --host="$MARIADB_HOST" --port="$MARIA_PORT" --all-databases > "/mariadump/$DATE/backup.sql"

rm -rf /mariarestore/$DATE