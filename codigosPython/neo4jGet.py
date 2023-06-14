from neo4j import GraphDatabase

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
print(salida)