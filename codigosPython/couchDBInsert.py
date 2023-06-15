import couchdb

# Establecer conexión con la base de datos de CouchDB
server = couchdb.Server('http://admin:C0WQSmJEsrTaeqFzmUUL@localhost:59159')  # Reemplaza con la URL de tu servidor CouchDB
database_name = 'baseprueba'  # Reemplaza con el nombre de tu base de datos

# Crear la base de datos
try:
    db = server.create(database_name)
    print(f"La base de datos '{database_name}' ha sido creada exitosamente.")
except couchdb.PreconditionFailed:
    print(f"La base de datos '{database_name}' ya existe.")

db = server[database_name]

# Datos a ingresar
data = [
    {
        'name': 'John Doe',
        'age': 30,
        'city': 'New York'
    },
    {
        'name': 'Jane Smith',
        'age': 25,
        'city': 'Los Angeles'
    },
    {
        'name': 'Mark Johnson',
        'age': 35,
        'city': 'Chicago'
    },
    {
        'name': 'Sarah Williams',
        'age': 28,
        'city': 'San Francisco'
    }
]

# Ingresar los documentos en la base de datos
for document in data:
    db.save(document)

print("Documentos ingresados con éxito.")
