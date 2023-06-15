#!/bin/bash

DATE=$(date '+%Y%m%d%H%M')
mkdir -p /mariadump/$DATE

apk update
apk upgrade
apk add mariadb-backup

az config set extension.use_dynamic_install=yes_without_prompt
#result=$(nslookup databases-mariadb.default.svc.cluster.local:3306 )
#echo $result
HOST=$(nslookup $MARIADB_HOST | awk '/Address: / { print $2 }')
echo '----------------'
groups
echo '----------------'
echo "host: $HOST"
socket_path=$(find / -type s -name 'mysql.sock')
echo "Socket path: $socket_path"

echo '----------------'
mariabackup  --user=$MARIA_USERNAME --password=$MARIA_PASSWORD --host=$HOST --port=$MARIA_PORT --databases=$MARIADB_DB --backup --target-dir=/mariadump/$DATE/ --compress 
#mariabackup --user=$MARIA_USERNAME --password=$MARIA_PASSWORD --port=$MARIA_PORT --databases=$MARIADB_DB --backup --target-dir=/mariadump/$DATE/ --compress
# mariabackup --backup \
#    --target-dir=/mariadump/$DATE/ \
#    --user=$MARIA_USERNAME --password=$MARIA_PASSWORD --host=$HOST --port=$MARIA_PORT
echo '----------------'
az storage blob directory upload --container $CONTAINER -s /mariadump/$DATE -d $BACKUP_PATH --auth-mode key --recursive

rm -rf /mariadump/$DATE
