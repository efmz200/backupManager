# Setup
##### NOTA: Preferiblemente usar una consola de Visual Studio Code

Abrir una consola dentro de la carpeta unitTestApi

En caso de no tenerlo, debe instalar el virtualenv de python con el siguiente comando:

``` 
pip3 install virtualenv
```

Luego debe ejecutar los siguientes comandos:

``` 
python -m virtualenv venv
```

Este comando debe ser ejecutado en el bash: 
```
./venv/Scripts/activate
```

Ejecute los siguientes comandos para instalar las dependencias necesarias de python
```
pip install pytest 

pip install mysql-connector-python

pip3 install pymongo

pip3 install psycopg2

pip3 install neo4j

pip3 install couchdb
```

# Ejecucion
Para ejecutar las pruebas unitarias utilice el siguiente comando:

``` 
pytest src/tests/test_main.py 
```