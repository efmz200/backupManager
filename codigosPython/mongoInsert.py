from pymongo import MongoClient

host = 'localhost'  # Cambia "nombre_del_servicio" por el nombre real del servicio de MongoDB
port = 57652
database = 'myDatabase'
collection = 'myColecion'
username = 'root'
password = 'jEpFg9sSkd'
url = 'mongodb://root:jEpFg9sSkd@localhost:57652/'
#print(url)
myclient = MongoClient(url)
myclient.list_database_names()
local_db = myclient.database_test
local_collection = local_db.test_collection
item_1 = {
"_id" : "U1IT00001",
"item_name" : "Blender",
"max_discount" : "10%",
"batch_number" : "RR450020FRG",
"price" : 340,
"category" : "kitchen appliance"
}

item_2 = {
"_id" : "U1IT00002",
"item_name" : "Egg",
"category" : "food",
"quantity" : 12,
"price" : 36,
"item_description" : "brown country eggs"
}
local_collection.insert_many([item_1,item_2])

myclient.close()
