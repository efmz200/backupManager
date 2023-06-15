import subprocess

# Definir los parámetros del backup
user = 'root'
password = 'ASbXWEJhho'
host = 'localhost'
port = 53892
target_dir = '/backpups'

# Construir el comando mariabackup
command = f"mariabackup --user={user} --password={password} --host={host} --port={port} --backup --target-dir={target_dir}"

# Ejecutar el comando
try:
    subprocess.run(command, shell=True, check=True)
    print("Backup completado con éxito.")
except subprocess.CalledProcessError as e:
    print(f"Error al realizar el backup: {e}")
