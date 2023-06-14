import couchdb

# Establecer conexión con la base de datos de CouchDB
server = couchdb.Server('http://admin:BbvzPSilnxftLFMfDZ2h@localhost:59159')  # Reemplaza con la URL de tu servidor CouchDB
database_name = 'baseprueba'  # Reemplaza con el nombre de tu base de datos

db = server[database_name]
database = server[database_name]

# Realizar la consulta de todos los documentos en la base de datos
result = database.view('_all_docs', include_docs=True)
resultado = []

# Recorrer los documentos y mostrar su contenido
for row in result.rows:
    doc_id = row.id
    doc = row.doc
    resultado += [{"Data": str(doc)}]
print(resultado)