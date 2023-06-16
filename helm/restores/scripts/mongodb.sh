#!/bin/bash

mkdir -p /mongodump
apk update
apk upgrade
apk add  mongodb-tools
az config set extension.use_dynamic_install=yes_without_prompt

az storage blob directory download -c "$CONTAINER" --account-name "$AZURE_STORAGE_ACCOUNT" -s mongoBackup -d /mongodump --recursive --verbose --auth-mode key

ls mongodump/mongoBackup/$DATE

mongorestore --host "$MONGO_CONNECTION_STRING" --username $MONGO_USERNAME --password $MONGO_PASSWORD --gzip --archive=mongodump/mongoBackup/$DATE/archive.gz
#mongodump --host="$MONGO_CONNECTION_STRING" -u $MONGO_USERNAME -p $MONGO_PASSWORD --gzip --archive=/mongodump/$DATE
#az storage blob directory upload --container $CONTAINER -s /mongodump/$DATE -d $BACKUP_PATH --auth-mode key --recursive
rm -rf /mongodump