### **Base de Datos II (IC4302)** – Semestre 1, 2023
### **Proyecto #3** 
### Erick Madrigal Zavala – 2018146983

## **Guía de instalación y uso del proyecto**

Antes de iniciar debe asegurarse de contar con los siguientes programas instalados:

    - [DockerDesktop] (https://www.docker.com/products/docker-desktop/)
    - [Lens] (https://k8slens.dev)
    - [Python] (https://www.python.org/downloads/)
    - [Visual Studio Code] (https://code.visualstudio.com/download) preferiblemente*
  
Tambien debera contar con una cuenta de Microsft Azure que contenga un Storage account.

Otro factor importante antes de iniciar es contar con el Helm instalado en el equipo para poder hacer las intalaciones de k8s.

Una vez que se tenga todo instalado debe iniciar Docker Desktop y en la parte de extensiones debe presionar los 3 puntos donde aparecera un menu donde debe seleccionar la opcion settings. Una vez en esa parte debera seleccionar Kubernetes y seleccionar la opcion de "Enable Kubernetes" luego debe aplicar y reiniciar.

Una vez que se reinició el servicio podra ver en la parte inferior que aparece tanto el logo de docker como de kubernetes en verde. Abra una terminal en la carpeta helm del proyecto. Una vez ahí debe utilizar los siguientes comandos: 
- Instalacion de boostrap
  
  Es importante que ingrese a su cuenta de azure, al Storage account y vaya a la sección de Acces keys y copie el Storage Account Name y el Key para utilizar los siguientes comandos:

![Azure Keys](https://i.imgur.com/BbMiG1I.png)

- ```echo 'Storage Account Name' | base64```
- ```echo 'key' | base64```
Los resultados de estos comandos deberá agregarlos en el archivo de values.yaml ubicado en la carpeta boostrap

```
helm install boostrap boostrap
```
- Instalacion de las bases de datos
```
helm dependency update databases
helm dependency build databases
helm install databases databases
```
En este punto podra ingresar al lens, en la seccion de catalogo, clusters, docker desktop e ingresar a los pods. En esta sección podra ver las distintas instalaciones de las bases de datos 
![Imagen bases de datos](https://i.imgur.com/QhiFIVG.png)

- Instalacion de los Jobs y Cronjos de los backups
  
En esta sección es importante que ingrese a la carpeta helm/backups y entre al archivo values.yaml. En este archivo encontrará las configuraciones de los backups de las bases de datos, los cuales se pueden activar o desactivar si se pone en true o en false el valor enable de cada base de datos

Ademas, en la parte final del archivo deberá cambiar los valores de storageAccount y de container segun la configuracion que tenga en azure para luego ejecutar el siguiente comando:

```
helm install databases databases
```

- Instalacion de los Jobs de los restores
   
En esta sección es importante que ingrese a la carpeta helm/restores y entre al archivo values.yaml. En este archivo encontrará las configuraciones de los restores de las bases de datos, los cuales se pueden activar o desactivar si se pone en true o en false el valor enable de cada base de datos

Ademas, en la parte final del archivo deberá cambiar los valores de storageAccount y de container segun la configuracion que tenga en azure para luego ejecutar el siguiente comando:

```
helm install restores restores
```

## **Pruebas y sus pasos para reproducirlas**
Para probar las bases de datos se utilizaron archivos .py para poder realizar conecciones a las respectivas bases de datos y probar consultas cobre estas. Es importante tener las librerias de python intaladas para realizar las pruebas respectivas. Los archivos de python están almacenados en la carpeta pruebasBases y están separado en carpetas según la base.
Estás pruebas se realizaron para poder comprar la correcta instalación de las bases de datos, la conexión con las mismas e incluso para revisar si los backups se restauraron de la manera correcta.
- CouchDB
  
  Libreria necesaria: couchdb

  Para esta prueba se debe buscar la contraseña de couch dentro de los secrets de couchdb desde lens
  Ademas se debe ingresar al pod "database-couchdb-0" y buscar la seccion de puertos y presionar en forward luego presionar el link azul que abrirá la pagina en el navegador con el link localhost:puerto debe tomar este puerta ya que será necesario.
  Para realizar las pruebas vasta con modificar el url que está en ambos archivos dentro de la carpeta couchdb 

  ```server = couchdb.Server('url')```
  
  Este url debe tener la forma:

   ```'http://admin:contraseña@localhost:puerto'```
  
  Una vez que haya realizado este cambio podrá ejecutar ambos archivos. El couchDBInsert lo que hace es crear una base de datos (en caso de que no exista) e insertar valores en ella. El archivo couchDBGet lo que hace es obtener los datos almacenados en la base.

- MariaDB
  
  Libreria necesaria: mysql-connector-python

  Para esta prueba se debe buscar la contraseña de mariadb dentro de los secrets de mariadb desde lens
  Ademas se debe ingresar al pod "databases-mariadb-0" y buscar la seccion de puertos y presionar en forward luego presionar el link azul que abrirá la pagina en el navegador con el link localhost:puerto debe tomar este puerta ya que será necesario.
  Para realizar las pruebas vasta con modificar las variables password y port en los archivos. Una vez que haya realizado este cambio podrá ejecutar ambos archivos. El 'mariadb creacion tabla' lo que hace es crear una base de datos (en caso de que no exista) e insertar valores en ella. El archivo 'mariadb get' lo que hace es obtener los datos almacenados en la base.
- MongoDB
  
  Libreria necesaria: pymongo

  Para esta prueba se debe buscar la contraseña de Mongo dentro de los secrets de mongodb desde lens
  Ademas se debe ingresar al pod "databases-mongodb-codigo" y buscar la seccion de puertos y presionar en forward luego presionar el link azul que abrirá la pagina en el navegador con el link localhost:puerto debe tomar este puerta ya que será necesario.
  Para realizar las pruebas vasta con modificar el la variable url para que quede de la siguiente manera 
  
  ```'mongodb://root:password@localhost:port/'```

  Una vez que haya realizado este cambio podrá ejecutar ambos archivos. El 'mongoInsert' lo que hace es crear una coleccion e insertar valores en ella. El archivo 'mongoGet' lo que hace es obtener los datos almacenados en la colección.

- Neo4j
  
   Libreria necesaria: neo4j

   Para esta prueba se debe buscar la contraseña de neo4j dentro de los secrets de my-neo4j-auth desde lens y copiar la contraseña que se cuentra aquí almacenada

   Para realizar las pruebas vasta con modificar el la variable passwors con la de neo4j
   
   Una vez que haya realizado este cambio podrá ejecutar ambos archivos. El 'neo4jInsert' lo que hace es crear nodos y relaciones entre estos. El archivo 'neo4jGet' lo que hace es obtener los nodos y sus relaciones y presentarlas.

- postgresql
  
  Libreria necesaria: psycopg2

  Para esta prueba se debe buscar la contraseña de postgresql dentro de los secrets de postgresql desde lens
  Ademas se debe ingresar al pod "databases-postgresql-0" y buscar la seccion de puertos y presionar en forward luego presionar el link azul que abrirá la pagina en el navegador con el link localhost:puerto debe tomar este puerta ya que será necesario.
  Para realizar las pruebas vasta con modificar las variables password y port en los archivos. Una vez que haya realizado este cambio podrá ejecutar ambos archivos. El 'postgreeInsert' lo que hace es crear una base de datos (en caso de que no exista) e insertar valores en ella. El archivo 'postgreeGet' lo que hace es obtener los datos almacenados en la base.


## **Recomendaciones**

1. Para podes ejecutar los comentario de una manera más comoda usar una consola de Visual Studio Code.
2. Se recomienda tener una guía que recopile cada comando a ser utilizado, para qué funciona y el orden en el que se deben ejecutar.
3. Planificar y organizar el trabajo en equipo de manera efectiva, asignando responsabilidades claras y estableciendo metas y plazos realistas.
4. Se recomienda agregar a los integrantes del equipo al resource group para que estos puedan realizar cambios necesarios en caso de necesitarlos.
5. Investigar y comprender las estrategias de copia de respaldo adecuadas para cada tipo de base de datos y seleccionar las mejores prácticas para implementar.
6. Es recomendable asegurarse de que todos los miembros tienen instalados todos los módulos necesarios para poder probar las conecciones con las bases de datos.
7. Asegurarse de que cada comando del helm pueda ser utilizado con exito y no muestre errores.
8. Implementar la seguridad adecuada para la protección de las copias de seguridad, como el uso de secretos en Kubernetes para el acceso a Azure Cloud.
9. Realizar pruebas exhaustivas para garantizar que los mecanismos de copia de respaldo sean confiables y efectivos.
10. Proporcionar una documentación completa y clara que describa los pasos para ejecutar el proyecto, incluyendo requisitos de instalación y configuración.

## **Conclusiones**

1. El trabajo requirió de la integración de diferentes bases de datos tanto sql como no sql las cuales tienen distintos fines, lo cuál es muy importante para el aprendizaje de los desarrolladores.
2. La implementación de mecanismos de copia de respaldo en bases de datos SQL y NoSQL es fundamental para garantizar la integridad y disponibilidad de los datos en caso de fallas o pérdidas.
3. El uso de herramientas de automatización como Docker, Kubernetes y Helm Charts facilita la implementación y gestión de los mecanismos de copia de respaldo.
4. La división de trabajo es muy importante para poder acabar el trabajo en un tiempo establecido.
5. Los conocimientos adquiridos anteriormente en otras asignaciones han sido de suma importancia para ahorrar tiempo de trabajo y aprendizaje.
6. La habilidad en scripting con Bash Shell es esencial para la automatización de tareas y la integración de los mecanismos de copia de respaldo en flujos de trabajo más amplios.
7. La adhesión a buenas prácticas de programación asegura la legibilidad, mantenibilidad y escalabilidad del código. 
8. La planificación y distribución efectiva de tareas dentro de los grupos de trabajo es crucial para el éxito del proyecto.
9. La documentación completa y clara es esencial para facilitar la comprensión y reproducción del proyecto, así como para cumplir con los requisitos de entrega establecidos.
10. Saber realizar búsquedas de forma correcta es muy importante, no solo para este proyecto, sino para la vida laboral y todo lo relacionado a bases de datos.



## **Referencias bibliograficas** 

- 26.1.&nbsp;SQL dump (2023) PostgreSQL Documentation. Available at: https://www.postgresql.org/docs/current/backup-dump.html#BACKUP-DUMP-ALL (Accessed: 15 June 2023). 
- MySQL 8.0 Reference Manual :: 4.5.4 mysqldump - A database backup program (no date) MySQL. Available at: https://dev.mysql.com/doc/refman/8.0/en/mysqldump.html (Accessed: 15 June 2023). 
- Volume mounts and persistent volumes - operations manual (no date) Neo4j Graph Data Platform. Available at: https://neo4j.com/docs/operations-manual/current/kubernetes/persistent-volumes/ (Accessed: 15 June 2023). 