import mysql.connector
from pymongo import MongoClient
import psycopg2
from neo4j import GraphDatabase
import couchdb

def pruebaMysql():
    host = 'localhost'
    user = 'root'
    password = '4ZzDUzxP1Y'
    port = 53892
    database = 'my_database'
    cnx = mysql.connector.connect(host=host, port=port, user=user, password=password, database=database)
    cursor = cnx.cursor()
    query = 'SELECT * FROM nombre_de_la_tabla'  
    cursor.execute(query)
    rows = cursor.fetchall()
    salida = []
    for row in rows:
        salida += [row]
    cursor.close()
    cnx.close()
    return (salida)

def pruebaMongo():
    url = 'mongodb://root:jEpFg9sSkd@localhost:57652/'
    myclient = MongoClient(url)
    local_db = myclient.database_test
    local_collection = local_db['test_collection']
    cursor = local_collection.find({})
    salida = []
    for document in cursor:
        salida += [document]

    myclient.close()
    return (salida)

def pruebaPostgree():
    host = 'localhost'
    port = '59838'
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

    return (salida)

def pruebaNeo4j():
    uri = 'bolt://localhost:7687'  # Reemplaza "neo4j-service" con el nombre del servicio de Neo4j en tu clúster
    username = 'neo4j'
    password = 'PaWZgPpwZyMGy6'
    driver = GraphDatabase.driver(uri, auth=(username, password))
    with driver.session() as session:
        # Ejemplo de consulta para obtener las personas y las ciudades en las que viven
        result = session.run("MATCH (p:Person)-[:LIVES_IN]->(c:City) RETURN p.name AS person, c.name AS city")
        salida = []
        # Iterar sobre los resultados
        for record in result:
            person = record["person"]
            city = record["city"]
            salida += [f"{person} vive en {city}"]
    driver.close()
    return(salida)


def pruebaCoudhDB():
    # Establecer conexión con la base de datos de CouchDB
    server = couchdb.Server('http://admin:BbvzPSilnxftLFMfDZ2h@localhost:59159')  # Reemplaza con la URL de tu servidor CouchDB
    database_name = 'baseprueba'  # Reemplaza con el nombre de tu base de datos
    database = server[database_name]

    # Realizar la consulta de todos los documentos en la base de datos
    result = database.view('_all_docs', include_docs=True)
    resultado = []

    # Recorrer los documentos y mostrar su contenido
    for row in result.rows:
        doc = row.doc
        resultado += [{"Data": str(doc)}]
    return(resultado)