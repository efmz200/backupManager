import mysql.connector
host = 'localhost'

user = 'root'
password = '4ZzDUzxP1Y'
port = 53892
database = 'my_database'

cnx = mysql.connector.connect(host=host, port=port, user=user, password=password, database=database)

cursor = cnx.cursor()
    
create_table_query = '''
    CREATE TABLE nombre_de_la_tabla (
        id INT AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(255),
        edad INT,
        email VARCHAR(255)
    )
'''
#cursor.execute(create_table_query)

insert_query = '''
    INSERT INTO nombre_de_la_tabla (nombre, edad, email)
    VALUES (%s, %s, %s)
'''

# Datos a insertar
datos = [
    ('Juan', 25, 'juan@example.com'),
    ('María', 30, 'maria@example.com'),
    ('Carlos', 40, 'carlos@example.com')
]

# Ejecutar el query de inserción para cada conjunto de datos
cursor.executemany(insert_query, datos)

cnx.commit()
cursor.close()
cnx.close()

    
