#!/bin/bash

DATE=$(date '+%Y%m%d%H%M')
mkdir -p /mariadump/$DATE

apk update
apk upgrade
#apk add mariadb-backup
apk add mysql-client
az config set extension.use_dynamic_install=yes_without_prompt
#result=$(nslookup databases-mariadb.default.svc.cluster.local:3306 )
#echo $result
HOST=$(nslookup $MARIADB_HOST | awk '/Address: / { print $2 }')
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

#mysqldump -u "$MARIA_USERNAME" -p "$MARIA_PASSWORD" --host= "$MARIADB_HOST" --port="$MARIA_PORT"  > "/mariadump/$DATE/backup.sql"  
mysqldump -u "$MARIA_USERNAME" -p"$MARIA_PASSWORD" --host="$MARIADB_HOST" --port="$MARIA_PORT" --all-databases > "/mariadump/$DATE/backup.sql" && zip "/mariadump/$DATE/backup.zip" "/mariadump/$DATE/backup.sql"
echo '----------------'
ls mariadump/$DATE
#mariabackup  --user=$MARIA_USERNAME --password=$MARIA_PASSWORD --host=$HOST --port=$MARIA_PORT --socket='/opt/bitnami/mariadb/tmp/mysql.sock' --databases=$MARIADB_DB --backup --target-dir=/mariadump/$DATE/ --compress 
#mariabackup --user=$MARIA_USERNAME --password=$MARIA_PASSWORD --port=$MARIA_PORT --databases=$MARIADB_DB --backup --target-dir=/mariadump/$DATE/ --compress
# mariabackup --backup \
#    --target-dir=/mariadump/$DATE/ \
#    --user=$MARIA_USERNAME --password=$MARIA_PASSWORD --host=$HOST --port=$MARIA_PORT
echo '----------------'
az storage blob directory upload --container $CONTAINER -s /mariadump/$DATE/backup.sql -d $BACKUP_PATH --auth-mode key --recursive

rm -rf /mariadump/$DATE
