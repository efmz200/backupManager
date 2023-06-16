#!/bin/bash
DATE=$(date '+%Y%m%d%H%M')
mkdir -p /couchdbbackup/$DATE
apk update
apk upgrade
apk add curl zip
az config set extension.use_dynamic_install=yes_without_prompt
echo "Starting backup"

for i in {0..2}; do
  db_pod="databases-couchdb-$i"
  echo "Backing up database $db_pod"

  # Perform backup of the database in the current pod
  curl -s -u "$COUCHDB_USERNAME:$COUCHDB_PASSWORD" -X GET http://$db_pod:$COUCHDB_PORT > /couchdbbackup/$DATE/$db_pod.json

  # Check if the backup was successful
  if [ $? -eq 0 ]; then
    echo "Backup of database $db_pod completed successfully"
  else
    echo "Backup of database $db_pod failed"
  fi
done

# Upload the compressed archive to Azure Blob storage
az storage blob directory upload --container $CONTAINER -s /couchdbbackup/$DATE -d $BACKUP_PATH --auth-mode key --recursive


# Remove the local backup directory and archive
rm -rf /couchdbbackup/$DATE


echo "Backup process completed"
