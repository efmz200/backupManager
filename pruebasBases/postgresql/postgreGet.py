import psycopg2

host = 'localhost'
port = '59838'
database = 'template0'
user = 'postgres'
password = 'q4S3UQLQL9'

connection = psycopg2.connect(
    host=host,
    port=port,
    database='postgres',
    user=user,
    password=password
)

cursor = connection.cursor()

# Realizar la consulta
select_query = "SELECT * FROM mytable;"
cursor.execute(select_query)

# Obtener los resultados de la consulta
results = cursor.fetchall()

# Imprimir los resultados
salida = []
for row in results:
    salida += [row]

# Cerrar el cursor y la conexión
cursor.close()
connection.close()

print (salida)
