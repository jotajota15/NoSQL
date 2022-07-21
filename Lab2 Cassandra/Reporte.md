# Laboratorato NoSQL #2- Cassandra
**Curso**

Base de Datos Avanzadas

**Estudiante**


Juan Valverde Campos - B47200

**Profesor**

David González Pérez

**Material del Laboratorio**

Disponible en [tutorial de IBM](https://developer.ibm.com/tutorials/ba-set-up-apache-cassandra-architecture/)

# Introducción 

Este laboratorio consiste en dos segmentos, el primero habla sobre los conocimiento que se obtiene al leer la primera sección teórica del [tutorial de IBM](https://developer.ibm.com/tutorials/ba-set-up-apache-cassandra-architecture/) y la segunda del todo elemento práctico alrededor de dicho tutorial.


# 1. Generalidades de Cassandra 

Como generalidades de Cassandra, se obtiene 3 aspectos generales que van a discutirse en esta sección. Los primeros dos se han visto en el curso, siendo estos el teorema CAP, las bases de datos distribuidas, donde el tercero corresponde a un tema más específico sobre como es la estructura de datos en cassandra y su modelado.

## Aspecto 1 Cassandra en el teorema CAP

Es importante recalcar que Cassandra según el teorema CAP como cualquier otro motor de base de datos distribuido solamente puede elegir entre los conceptos de consistencia, disponibilidad y tolerancia a la partición.

Dado lo anterior, se establece que Cassandra es correcta en aplicar disponibilidad y tolerancia al partición, donde a pesar de lo anterior no se puede argumentar que por lo mismo Cassandra no tiene operaciones atómicas, durables o aisladas, dado que estos conceptos por sí mismos no son de relevancia para dicha base de datos.

## Aspecto 2 Cassandra como base de datos distribuida

Hay que tomar en consideración que Cassandra tiene como naturaleza misma  ser un sistema distribuido. Es decir que dicha base de datos trabaja por sí misma a partir de particiones de datos en distintas máquinas.

La aseveración anterior, es lo que permite que Cassandra sea fácil de escalar y pueda escalar de forma horizontal (poner más nodos en lugar de darle más poder a dichos nodos).

A partir de lo anterior, se crea el concepto del anillo de Cassandra, que básicamente consiste en crear nodos a que por sí mismos responden consultas de los distintos usuarios, pero además de esto son réplicas de otros nodos.

La réplica que sucede en Cassandra permite que no exista realmente un nodo maestro, donde la información de datos es intercambiada entre los nodos a partir del protocolo gossip, que orienta a las conexiones de clientes sobre cual nodo es mejor en escribir o bien en leer en un tiempo dado.


## Aspecto 3 La estructura básica y modelado de datos en Cassandra

Con respecto a como se consturye y se modela los datos en Cassandra es importante recalcar que los datos se organizan en particiones donde cada partición se representa por una llave primaria, es decir que para localizar los datos de una tabla se requiere una llave de estas que permitan conocer la partición que tiene los datos en esta.

Tomando lo anterior, también es importante recalcar que existe otro tipo de llave llamado clustering key, que abarca una mayor complejidad en el sistema distribuido en esta base de datos al crear ahora un cluster para hacer consultas más eficientes.

Por todo lo anterior, el modelado de datos en Cassandra es distinto a los demás a partir del concepto de Query Based Modeling, que busca pensar primero en la query que se van a hacer sobre los datos antes de modelar los mismos, contrario a otras bases de datos.

# 2. Resultados del laboratorio 

A continuación se exponen en modo de resumen a través de imágenes y explicaciones de estas los resultados obtenidos por cada una de las tareas del laboratorio realizado.

## Tarea 1. Creación de nodos 

![](./images/1.png)


En esta tarea se observa como ya se ha podido levantar 3 nodos y conectarlos, no obstante en esta captura en concreto observese como el nodo 3 está caído al estar en DN, esto es para fines ilustrativos de ver como si se pudieron crear y conectar los nodos.

## Tarea 2. Acceso a consultas

![](./images/2.png)


En esta tarea se observa como se accede al nodo 1 y se procede a realizar consultas dentro del mismo a partir del comando cqlsh.

## Tarea 3. Creación de tablas

![](./images/3.png)

En esta tarea se observa como se logra realizar la creación de la tabla paciente.examen, donde el warning que se presenta no resultó en problema alguno al realizar el laboratorio.

## Tarea 4. Inserción y lectura de datos

![](./images/4.png)


En esta tarea se observa como se logra ingresar los datos de algunos pacientes y los exámenes en estos, donde posteriormente se hace una consulta para el paciente con el id con valor 1.

## Tarea 5. Replicación de datos

![](./images/5.png)

En esta tarea se observa como se inserta un nuevo examen de un paciente con un id 9, que no existía anteriormente en el nodo 1. Posteriormente, para ver ese examen se accede al nodo 3 para ver el efecto de replicación donde la información ingresada en el nodo 1, efectivamente se replica en el nodo 3.

## Tarea 6. Replicación de datos con nodos apagados


![](./images/6(issueEnNodo3).png)

En esta tarea se observa como se apagan el nodo 2 y 3, se ingresa un nuevo examen de un paciente con id 10, en el nodo 1. Posteriormente, se trata de ingresar al nodo 3 y observese como el acceso es denegado (Esto es por que docker dura en encender dicho nodo), se intenta ingresar al nodo 2 y con éxito se accede y se realiza la consulta por el paciente con id 10. Los resultados aparecen a pesar de que este nodo estaba apagado cuando se realizó la inserción.

![](./images/6.1(despues).png)

La siguiente captura cubre para efectos de representación, una vista más larga de esta tarea pues ya una vez hecho las consultas en el nodo 2, se dio tiempo para que el nodo 3 se pudiera conectar y se hace la consulta en el mismo con resultados igual de favorables.


## Tarea 7. Quorum y replicación 

![](./images/7.0.png)

En esta tarea se observa como los nodos 1 y 2 son desconectados. Posteriormente al cambiar la consistencia en modo quorum se observa que la consulta que se deseaba no tendrá resultados, debido a que se necesita más de un nodo (que exista quorum) en estos 3 nodos para obtener los resultados.

Para esto se puede o bien cambiar el nivel de consistencia a solo un nodo, o bien encender algún nodo y obtener los resultados que se ven en la siguiente imagen, donde ya ahora si con dos nodos encendidos y en modo quorum los resultados se obtienen, al existir mayoría para obtener resultados.

![](./images/7.1.png)
