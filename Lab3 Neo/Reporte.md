# Laboratorato NoSQL #3- Neo4j
**Curso**

Base de Datos Avanzadas

**Estudiante**


Juan Valverde Campos - B47200

**Profesor**

David González Pérez

**Material del Laboratorio**

Disponible en [Instrucciones de Laboratorio](LabInstructions.pdf)
# Introducción 

Según la [página oficial de docker](https://docs.docker.com/desktop/), se tiene lo siguiente:

![](./images/1.png)

# Parte 1. Creación y consultas básicas 



## P1. ¿Cuál es la orientación de Neo4j y en qué situaciones del mundo real se emplea?

## P2. ¿Qué resultado se obtiene con el siguiente comando?

    CREATE (n:Persona{nombre: ’Juanito’, edad: 24})

## P3. ¿Qué elementos nuevos se adquirieron con la anterior consulta?

## P4. ¿Qué resultados obtiene si realiza click en Persona?

## P5. ¿Qué sucede si ahora realiza la siguiente consulta y realiza un click en Persona?

    CREATE (n:Persona{nombre: 'Miguel', edad: 26, ocupacion: 'Desarrollador'})


## P6. ¿Es posible obtener este resultado en un motor SQL ?


## P7. ¿Qué resultado se obtiene al realizar la siguiente consulta?
    MATCH (a:Persona), (b:Persona) WHERE a.nombre = 'Juanito' AND b.nombre = 'Miguel'
    CREATE (a)-[r:Conoce_A]->(b)


## P8. ¿Qué resultado se obtiene al realizar la siguiente consulta?

    MATCH (p:Persona)-[:Conoce_A]->() RETURN DISTINCT p

## P9. ¿Por qué se retornan solo dos nodos?

## P10. Modifique la consulta para se retornen todos los nodos Persona que participan en la relación Conoce_A


# Parte 2. Consultas con base de datos Movie

## P1. Enliste los diferentes tipos de nodos y relaciones (por separado) que existen en la bse de datos Movies predeterminada.

## P2. ¿Qué sucede si se hace click en el nodo Person ?

## P3. ¿Qué sucede si se hace click en el nodo ACTED_IN?

## P4. Muestre una relación de algún actor (Keanu Reeves) con la relación ACTED_IN




## P5. ¿Qué resultado se obtiene a partir de la siguiente consulta?

    MATCH (p:Person)-[:ACTED_IN]-()-[:ACTED_IN]-(actor:Person) WHERE p.name = "Natalie Portman" RETURN DISTINCT actor


## P6. Modifique la consulta anterior para que también muestre la película en que estos actores participaron

## P7.Realice una consulta que permita encontrar los directores de películas en que ha participado Keanu Reeves

## P8. Realice una consulta que muestre las películas de otros actores que han trabajado junto con Natalie Portman 

*Nota*: Los actores que se tomen se entendió en el laboratorio que no deben de aparecer, sino sería la misma consulta que la pregunta 5.




## P9. ¿Qué funciones podrían consultas similares a la anterior en actividades de la vida cotidiana?. Al menos dos ejemplos.


# Parte 3. Preguntas de Análisis

## P1. ¿Qué similitudes y diferencias encuentra en  Neo4j y los motores de bases de datos relacionales, distribuidas y llave valor?

# P2. Liste los resultados de al menos dos de cada una y  fundamente sus afirmaciones.
