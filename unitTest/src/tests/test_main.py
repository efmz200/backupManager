from src.main import pruebaMysql, pruebaMongo, pruebaPostgree, pruebaNeo4j, pruebaCoudhDB
from src.tests.variables import *

def test_Mariadb ():
    assert pruebaMysql() == mariaResult

def test_Mongo ():
    assert pruebaMongo() == mongoResult

def test_Postgres ():
    assert pruebaPostgree() == postgresResult

def test_Neo4j ():
    assert pruebaNeo4j() == neo4jResult or pruebaNeo4j() == neo4jResult2
    
def test_CouchDB ():
    assert pruebaCoudhDB() == couchDBResult