import mysql.connector
host = 'localhost'

user = 'root'
password = '4ZzDUzxP1Y'
port = 53892
database = 'my_database'

cnx = mysql.connector.connect(host=host, port=port, user=user, password=password, database=database)

cursor = cnx.cursor()
query = 'SELECT * FROM nombre_de_la_tabla'  # Cambia "nombre_de_la_tabla" por el nombre real de la tabla que deseas consultar
cursor.execute(query)
rows = cursor.fetchall()
salida = []
for row in rows:
    salida += [row]

cursor.close()

cnx.close()

print (salida)
