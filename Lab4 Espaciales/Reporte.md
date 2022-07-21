# Tarea de Base de Datos Espaciales - Oracle
**Curso**

Base de Datos Avanzadas

**Estudiante**


Juan Valverde Campos - B47200

**Profesor**

David González Pérez

**Material del Laboratorio**

Disponible en [Instrucciones de Laboratorio](Tarea_Espaciales.pdf)

# Introducción 

https://docs.oracle.com/database/121/SPATL/simple-example-inserting-indexing-and-querying-spatial-data.htm#SPATL486

Según la [página oficial de docker](https://docs.docker.com/desktop/), se tiene lo siguiente:

![](./images/1.png)

# Laboratorio Parte 1 - Comprensión de BD espaciales

**Nota:** La realización de este laboratorio y su código relacionado se encuentra en el siguiente [archivo](code.sql)

## P1. Explique qué realiza la siguiente consulta 

    CREATE TABLE Ejemplo_Geometria(
    ID NUMBER PRIMARY KEY,
    Nombre VARCHAR2(32),
    Figura SDO_GEOMETRY);

## P2. Explique qué realiza el siguente código y cuál es su finalidad

   INSERT INTO user_sdo_geom_metadata( TABLE_NAME, COLUMN_NAME, DIMINFO, SRID) VALUES (
    'Ejemplo_Geometria',
    'Figura',
    SDO_DIM_ARRAY( SDO_DIM_ELEMENT('X', 0, 20, 0.005), SDO_DIM_ELEMENT('Y', 0, 20, 0.005) ),
    NULL); 

## P3. Explique la diferencia antes y después de ejecutar la consulta anterior en la tabla MDSYS.SDO_GEOM_METADATA_TABLE


## P4. Explique la diferencia antes y después de ejecutar la consulta  expuesta en la pregunta 2 en la tabla USER_SDO_GEOM_METADATA

## P5. Comente que realiza el siguiente código

  CREATE INDEX Ejemplo_Geometria_idx ON Ejemplo_Geometria (Figura) INDEXTYPE IS MDSYS.SPATIAL_INDEX;  
## P6. Comente que realiza el siguiente código

    INSERT INTO Ejemplo_Geometria VALUES(
    1,
    'cola_a',
    SDO_GEOMETRY(
    2003,
    NULL,
    NULL,
    SDO_ELEM_INFO_ARRAY(1,1003,3),
    SDO_ORDINATE_ARRAY(1,1, 5,7)
    ));

## P7. Cuáles son los parámetros que parecen más importantes en la anterior consulta.

## P8. Explique qué hace y cuál es la finalidad de la siguiente consulta 

    INSERT INTO user_sdo_geom_metadata( TABLE_NAME, COLUMN_NAME, DIMINFO, SRID) VALUES (
    'Ejemplo_Geometria',
    'Figura',
    SDO_DIM_ARRAY( SDO_DIM_ELEMENT('X', 0, 20, 0.005), SDO_DIM_ELEMENT('Y', 0, 20, 0.005) ),
    NULL);

## P9. Ejecute el siguiente código y defina cual es su diferencia con el obtenido en la pregunta 8.

    INSERT INTO Ejemplo_Geometria VALUES(
    10,
    'polygon_with_hole',
    SDO_GEOMETRY(
    2003,
    NULL,
    NULL,
    SDO_ELEM_INFO_ARRAY(1,1003,1, 19,2003,1),
    SDO_ORDINATE_ARRAY(2,4, 4,3, 10,3, 13,5, 13,9, 11,13, 5,13, 2,11, 2,4,
    7,5, 7,10, 10,10, 10,5, 7,5)
    )
    );

# P10. Describa que es SDO_GEOMETRY y cuál es su importancia en el contexto de Oracle.

# Laboratorio Parte 2 - Consultas en BD espaciales

Este segmento del laboratorio trabaja a partir de la creación del siguiente escenario y consultas alrededor del mismo.

PONER IMAGEN 

# P1. Cree las siguientes estructuras y establezcan su función 

    CREATE TYPE A_StateType AS OBJECT(
    name VARCHAR2(25),
    extension mdsys.sdo_geometry
    );


    Create table A_State of A_StateType
    object identifier is system generated;


    Create table A_Park of A_StateType
    object identifier is system generated;

    Create table A_Other of A_StateType
    object identifier is system generated;


    SET SERVEROUTPUT ON

    CREATE OR REPLACE trigger A_ValidateInsertPath
    before insert on A_Other
    For each row begin
    if :new.extension.get_gtype() = 2 then
    dbms_output.put_line('Road inserted’);
    end if;
    end;

## P2. Inserte las figuras presentadas al inicio de esta sección

A continuación ya expuesto como se insertaron las figuras , se presenta los resultados finales.

## P3. Realice las siguientes consultas 

a. Calcule el área total de los estados. (Utilice SDO_GEOM.SDO_AREA)

b. Calcule el área total de los parques.

c. Calcule el área de cada uno de los estados.

d. Verifique si existe alguna relación topológica entre los estados. (Utilice SDO_GEOM.RELATE)

e. Especifique las relaciones topológicas entre los parques y cada uno de los estados.

f. Calcule la longitud de la carretera. (Utilice SDO_GEOM.SDO_LENGTH)

g. Calcule la longitud de la carretera que pasa por cada uno de los parques.

h. Verifique si existe algún parque en la distancia de 2 unidades de la posición “Yo”.
(Utilice SDO_GEOM.SDO_DISTANCE)

i. Encuentre los tres parques más cercanos a la posición “Yo”.

