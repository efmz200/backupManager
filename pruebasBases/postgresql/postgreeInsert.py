import psycopg2

host = 'localhost'
port = '59838'
database = 'template0'
user = 'postgres'
password = 'guPfvKzAyp'

connection = psycopg2.connect(
    host=host,
    port=port,
    database='postgres',
    user=user,
    password=password
)

cursor = connection.cursor()

# Crear la tabla
create_table_query = '''
    CREATE TABLE mytable (
        id SERIAL PRIMARY KEY,
        columna1 VARCHAR(50),
        columna2 VARCHAR(50)
    );
'''
try:
    cursor.execute(create_table_query)
except :
    print('La tabla ya existe')

# Agregar datos a la tabla
insert_data_query = '''
    INSERT INTO mytable (columna1, columna2)
    VALUES (%s, %s);
'''
data1 = ('valor1', 'valor2')
data2 = ('valor3', 'valor4')

cursor.execute(insert_data_query, data1)
cursor.execute(insert_data_query, data2)

# Confirmar los cambios en la base de datos
connection.commit()
cursor.close()
connection.close()
