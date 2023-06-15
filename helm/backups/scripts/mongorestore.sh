#!/bin/bash
DATE= 202306150052
BACKUP_FILE="$DATE-dump.archive.gz"
DOWNLOAD_PATH="/mongorestore/$DATE"
RESTORE_PATH="/mongorestore/restored"

# Descargar el archivo de Azure Blob Storage
az storage blob download --container "$CONTAINER" --name "$BACKUP_PATH/$BACKUP_FILE" --file "$DOWNLOAD_PATH/$BACKUP_FILE" --auth-mode key

# Verificar que se haya descargado el archivo
if [ -f "$DOWNLOAD_PATH/$BACKUP_FILE" ]; then
    echo "El archivo de respaldo ha sido descargado exitosamente."
else
    echo "Error al descargar el archivo de respaldo."
    exit 1
fi

# Restaurar la base de datos utilizando mongorestore
mongorestore --gzip --archive="$DOWNLOAD_PATH/$BACKUP_FILE" --drop --db "$DATABASE" --dir="$RESTORE_PATH"

# Verificar que se haya realizado la restauración
if [ -d "$RESTORE_PATH/$DATABASE" ]; then
    echo "La restauración de la base de datos ha sido exitosa."
else
    echo "Error al restaurar la base de datos."
    exit 1
fi

# Eliminar los archivos descargados y restaurados
rm -rf "$DOWNLOAD_PATH" "$RESTORE_PATH"

echo "Proceso de restauración completado."
