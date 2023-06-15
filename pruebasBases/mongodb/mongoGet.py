from pymongo import MongoClient

host = 'localhost'  
port = 57916
database = 'myDatabase'
collection = 'myColecion'
username = 'root'
password = 'snskz7chVU'
url = 'mongodb://root:snskz7chVU@localhost:57916/'
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
