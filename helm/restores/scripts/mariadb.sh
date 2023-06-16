#!/bin/bash
apk update
apk upgrade
apk add mysql-client
az config set extension.use_dynamic_install=yes_without_prompt

mkdir -p /mariarestore/$DATE
az storage blob directory download -c "$CONTAINER" --account-name "$AZURE_STORAGE_ACCOUNT" -s mariaBackup -d /mariarestore --recursive --verbose --auth-mode key
mysqldump -u "$MARIA_USERNAME" -p"$MARIA_PASSWORD" --host="$MARIADB_HOST" --port="$MARIA_PORT" --all-databases < "/mariarestore/mariaBackup/$DATE/backup.sql"
exit_code=$?
echo "Código de salida: $exit_code"

rm -rf /mariarestore