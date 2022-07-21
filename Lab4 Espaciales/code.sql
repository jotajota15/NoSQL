-- Parte 1
CREATE TABLE Ejemplo_Geometria(
ID NUMBER PRIMARY KEY,
Nombre VARCHAR2(32),
Figura SDO_GEOMETRY);


-- Revision de tablas

select * MDSYS.SDO_GEOM_METADATA_TABLE
select * FROM USER_SDO_GEOM_METADATA


-- Parte 2

INSERT INTO user_sdo_geom_metadata( TABLE_NAME, COLUMN_NAME, DIMINFO, SRID) VALUES (
'Ejemplo_Geometria',
'Figura',
SDO_DIM_ARRAY( SDO_DIM_ELEMENT('X', 0, 20, 0.005), SDO_DIM_ELEMENT('Y', 0, 20, 0.005) ),
NULL);

-- Parte 3
CREATE INDEX Ejemplo_Geometria_idx
ON Ejemplo_Geometria (Figura) INDEXTYPE IS MDSYS.SPATIAL_INDEX;
-- Parte 4
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

-- Parte 5

INSERT INTO user_sdo_geom_metadata( TABLE_NAME, COLUMN_NAME, DIMINFO, SRID) VALUES (
'Ejemplo_Geometria',
'Figura',
SDO_DIM_ARRAY( SDO_DIM_ELEMENT('X', 0, 20, 0.005), SDO_DIM_ELEMENT('Y', 0, 20, 0.005) ),
NULL);

-- Parte 6
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

-- Parte 7
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
For each row
begin
if :new.extension.get_gtype() = 2 then
    dbms_output.put_line('Road inserted');
end if;
end;

-- Insercion de Carretera
INSERT INTO A_Other VALUES(
'C1',SDO_GEOMETRY(
2002,
NULL,
NULL,
SDO_ELEM_INFO_ARRAY(1,2,1), -- compound line string
SDO_ORDINATE_ARRAY(1,5.5, 5,8,10,7)
)
)




-- Insercion de Estado 2
INSERT INTO A_State VALUES(
  'St2',
  SDO_GEOMETRY(
    2003,  -- two-dimensional polygon
    NULL,
    NULL,
    SDO_ELEM_INFO_ARRAY(1,1003,3), -- one rectangle (1003 = exterior)
    SDO_ORDINATE_ARRAY(9,4, 13,12) -- only 2 points needed to
          -- define rectangle (lower left and upper right) with
          -- Cartesian-coordinate data
  )
);


-- Insercion de Estado 1
INSERT INTO A_State VALUES(
  'St1',
  sdo_geometry (
  2007,
  null, 
  null, 
  sdo_elem_info_array (1,1003,1, 19,1003,1), 
  sdo_ordinate_array (2,5, 4,5, 6,4, 9,6, 9,9, 8,11, 4,11, 1,9, 2,5, 8,3,10,3,11,2,9,1,8,3)
));

-- Insercion de Parques
INSERT INTO A_Park VALUES(
  'P1',
  sdo_geometry (
  2007,
  null, 
  null, 
  SDO_ELEM_INFO_ARRAY(1,1003,3), -- one rectangle (1003 = exterior)
  SDO_ORDINATE_ARRAY(4,10, 5,11) -- only 2 points needed to
          -- define rectangle (lower left and upper right) with
          -- Cartesian-coordinate data
));

INSERT INTO A_Park VALUES(
  'P2',
  sdo_geometry (
  2007,
  null, 
  null, 
  SDO_ELEM_INFO_ARRAY(1,1003,3), -- one rectangle (1003 = exterior)
  SDO_ORDINATE_ARRAY(4,7, 6,9) -- only 2 points needed to
          -- define rectangle (lower left and upper right) with
          -- Cartesian-coordinate data
));

INSERT INTO A_Park VALUES(
  'P3',
  sdo_geometry (
  2007,
  null, 
  null, 
  SDO_ELEM_INFO_ARRAY(1,1003,3), -- one rectangle (1003 = exterior)
  SDO_ORDINATE_ARRAY(7.5,5,10.5, 8) -- only 2 points needed to
          -- define rectangle (lower left and upper right) with
          -- Cartesian-coordinate data
));

INSERT INTO A_Park VALUES(
  'P4',
  sdo_geometry (
  2007,
  null, 
  null, 
  SDO_ELEM_INFO_ARRAY(1,1003,3), -- one rectangle (1003 = exterior)
  SDO_ORDINATE_ARRAY(10.5,8.5, 13.5,10.5) -- only 2 points needed to
          -- define rectangle (lower left and upper right) with
          -- Cartesian-coordinate data
));
-- Insercion de punto (Yo)
INSERT INTO A_Other VALUES(
   'Yo',
   SDO_GEOMETRY(
      2001,
      NULL,
      SDO_POINT_TYPE(8, 9, NULL),
      NULL,
      NULL));

-- Parte 8 Consultas 

--Consulta a

SELECT sum( SDO_GEOM.SDO_AREA(extension, 0.005)) AS "Área Total Estados"
FROM A_State;

--Consulta b

SELECT sum( SDO_GEOM.SDO_AREA(extension, 0.005)) AS "Área Total Parques"
FROM A_Park;

--Consulta c
SELECT name AS "Nombre", SDO_GEOM.SDO_AREA(extension, 0.005) AS "Área" FROM A_Park
ORDER BY name;

--Consulta d
SELECT  *
FROM A_Park c_b, A_Park c_d
where   SDO_GEOM.RELATE(c_b.extension, 'anyinteract', c_d.extension, 0.005) = 'TRUE'
AND c_b.name != c_d.name


--Consulta e
SELECT  c_b.name, c_d.name
FROM A_Park c_b, A_State c_d
where   SDO_GEOM.RELATE(c_b.extension, 'anyinteract', c_d.extension, 0.005) = 'TRUE'
order by c_d.name, c_b.name;
--Consulta f
select SDO_GEOM.SDO_LENGTH(A_Other.extension) from A_Other
where A_Other.name = 'C1'
--Consulta g FALTA
--https://docs.oracle.com/database/121/SPATL/querying-spatial-data.htm#SPATL593
select SDO_GEOM.SDO_LENGTH(a.extension, p.extension) from A_Other a, A_park p 
where a.name = 'C1' and SDO_GEOM.RELATE(a.extension, 'anyinteract', p.extension, 0.005) = 'TRUE'

--Consulta h
SELECT p.name
  FROM A_Other A, A_Park p
  WHERE  A.name = 'Yo' and SDO_WITHIN_DISTANCE( A.extension, p.extension, 'distance=2') = 'TRUE';

--Consulta i

CREATE INDEX A_Park_Index
ON A_Park(extension) INDEXTYPE IS MDSYS.SPATIAL_INDEX;


-- problema con indice
SELECT p.name
  FROM  A_Park p, A_Other A
  WHERE  A.name = 'Yo' and SDO_NN(A.extension, p.extension, 'sdo_num_res=2') = 'TRUE';
