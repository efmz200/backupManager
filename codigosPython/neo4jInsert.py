from neo4j import GraphDatabase

uri = 'bolt://localhost:7687'  # Reemplaza "neo4j-service" con el nombre del servicio de Neo4j en tu clúster
username = 'neo4j'
password = 'PaWZgPpwZyMGy6'

driver = GraphDatabase.driver(uri, auth=(username, password))
with driver.session() as session:
    
    # Ejemplo de inserción de nodos
    session.run("CREATE (n1:Person {name: 'John Doe'})")
    session.run("CREATE (n2:Person {name: 'Jane Smith'})")
    session.run("CREATE (n3:City {name: 'New York'})")
    session.run("CREATE (n4:City {name: 'Los Angeles'})")

    # Ejemplo de inserción de relaciones
    session.run("MATCH (a:Person), (b:City) WHERE a.name = 'John Doe' AND b.name = 'New York' CREATE (a)-[:LIVES_IN]->(b)")
    session.run("MATCH (a:Person), (b:City) WHERE a.name = 'Jane Smith' AND b.name = 'Los Angeles' CREATE (a)-[:LIVES_IN]->(b)")



driver.close()
