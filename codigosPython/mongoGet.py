from pymongo import MongoClient

host = 'localhost'
port = 57652
database = 'myDatabase'
collection = 'myColecion'
username = 'root'
password = 'jEpFg9sSkd'

url = 'mongodb://root:jEpFg9sSkd@localhost:57652/'
#print(url)
myclient = MongoClient(url)
local_db = myclient.database_test
local_collection = local_db['test_collection']
cursor = local_collection.find({})
salida = []
for document in cursor:
    salida += [document]

print (salida)
myclient.close()
