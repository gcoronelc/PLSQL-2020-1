/**
 *
 * DBMS           :  ORACLE
 * Esquema        :  CONTROL_INVENTARIOS
 * Descripción    :  Modelo de Base de Datos de control académico sencillo
 * Script         :  Crea el esquema y sus respectivas tablas
 * Creao por      :  Estudiante de Sistemas Diego Cordova
 * Email          :  dcordova8623@gmail.com
 * Fecha          :  07-mar-2020
 * 
**/


-- =============================================
-- CRACIÓN DEL USUARIO
-- =============================================

DECLARE
	N INT;
	COMMAND VARCHAR2(200);
BEGIN
	COMMAND := 'DROP USER INVENTARIO';
	SELECT COUNT(*) INTO N
	FROM DBA_USERS
	WHERE USERNAME = 'INVENTARIO';
	IF ( N = 1 ) THEN
		EXECUTE IMMEDIATE COMMAND;
	END IF;
END;
/


CREATE USER INVENTARIO IDENTIFIED BY admin;

GRANT CONNECT, RESOURCE TO INVENTARIO;

ALTER USER INVENTARIO
QUOTA UNLIMITED ON USERS;

GRANT CREATE VIEW TO INVENTARIO;



-- =============================================
-- CONECTARSE A LA APLICACIÓN
-- =============================================

CONNECT INVENTARIO/admin



-- ======================================================
-- TABLA BOLETA
-- ======================================================

CREATE TABLE INVENTARIO.BOLETA
(
	chr_idboleta         CHAR(5) NOT NULL ,
	vch_nombre           VARCHAR(25) NOT NULL ,
	chr_dni              CHAR(8) NOT NULL ,
	chr_idproducto         CHAR(5) NOT NULL ,
	vch_cliedireccion    VARCHAR(50) NOT NULL ,
    int_cantidad         NUMBER(6,0) NOT NULL ,
    dec_monto            NUMBER(12,2) NOT NULL , 
CONSTRAINT  PK_BOLETA PRIMARY KEY (chr_idboleta)
);

-- ======================================================
-- TABLA SALIDA
-- ======================================================

CREATE TABLE INVENTARIO.SALIDA
( 
	chr_idsalida         CHAR(5) NOT NULL ,
	chr_idboleta         CHAR(5) NOT NULL ,
	dtt_fecha            DATE NOT NULL ,
	vch_producto         VARCHAR(50) NOT NULL ,
	vch_descripcion       VARCHAR(50) NOT NULL ,
	int_cantidad         NUMBER(6,0) NOT NULL ,
   CONSTRAINT  PK_SALIDA PRIMARY KEY (chr_idsalida)
);



-- ======================================================
-- TABLA ENTRADA
-- ======================================================


CREATE TABLE INVENTARIO.ENTRADA
( 
	chr_identrada         CHAR(5) NOT NULL ,
	cur_nrofactura         CHAR(5) NOT NULL ,
	cur_fecha            DATE NOT NULL ,
	vch_producto         VARCHAR(50) NOT NULL ,
	vch_descripcion       VARCHAR(50) NOT NULL ,
	int_cantidad         NUMBER(6,0) NOT NULL ,
   CONSTRAINT  PK_ENTRADA PRIMARY KEY (chr_identrada)
);


-- ======================================================
-- TABLA CONTROL
-- ======================================================

CREATE TABLE INVENTARIO.CONTROL
( 
	chr_idcontrol         CHAR(5) NOT NULL ,
    chr_idproducto         CHAR(5) NOT NULL ,
    vch_descripcion       VARCHAR(50) NOT NULL ,
    int_existini         NUMBER(6,0) NOT NULL ,
    int_salida         NUMBER(6,0) NOT NULL ,
    int_entrada         NUMBER(6,0) NOT NULL ,
    int_stock         NUMBER(6,0) NOT NULL ,
   CONSTRAINT  PK_CONTROL PRIMARY KEY (chr_idcontrol)
);

-- ======================================================
-- TABLA PRODUCTO
-- ======================================================

CREATE TABLE INVENTARIO.PRODUCTO
( 
	chr_idproducto         CHAR(5) NOT NULL ,
     vch_producto       VARCHAR(50) NOT NULL ,
    vch_descripcion       VARCHAR(50) NOT NULL ,
    chr_idcategoria        CHAR(5) NOT NULL ,
    dec_precio            NUMBER(12,2) NOT NULL ,
   CONSTRAINT  PK_PRODUCTO PRIMARY KEY (chr_idproducto)
);

-- ======================================================
-- TABLA CATEGORIA
-- ======================================================

CREATE TABLE INVENTARIO.CATEGORIA
( 
	chr_idcategoria        CHAR(5) NOT NULL ,
    vch_nombre            VARCHAR(50) NOT NULL ,
   CONSTRAINT  PK_CATEGORIA PRIMARY KEY (chr_idcategoria)
);


-- Insertar Datos

SELECT * FROM INVENTARIO.CATEGORIA
-- Tabla: CATEGORIA

INSERT INTO INVENTARIO.CATEGORIA VALUES ( 'C01','AVENTURA');
INSERT INTO INVENTARIO.CATEGORIA VALUES ( 'C02','ACCION');
INSERT INTO INVENTARIO.CATEGORIA VALUES ( 'C03','DEPORTE');
INSERT INTO INVENTARIO.CATEGORIA VALUES ( 'C04','PELEAS');
INSERT INTO INVENTARIO.CATEGORIA VALUES ( 'C05','COMPETENCIA');


-- Tabla: PRODUCTO

INSERT INTO INVENTARIO.PRODUCTO VALUES ( 'P01','GOD OF WAR','COMBATE, AVENTURA Y ACCION','C01',80.00);
INSERT INTO INVENTARIO.PRODUCTO VALUES ( 'P02','PES2020','FUTBOL DE CLUBES Y PAISES','C03',90.00);
INSERT INTO INVENTARIO.PRODUCTO VALUES ( 'P03','GRAN TURISMO','CARRERA DE AUTOS','C05',70.00);
INSERT INTO INVENTARIO.PRODUCTO VALUES ( 'P04','MORTAL KOMBAT','COMBATE SANGRIENTO','C04',80.00);
INSERT INTO INVENTARIO.PRODUCTO VALUES ( 'P05','CALL OF DUTY','JUEGO DE COMBATE Y GUERRA','C02',120.00);

--tabla control
INSERT INTO INVENTARIO.CONTROL VALUES ( 'CT01','P01','COMBATE, AVENTURA Y ACCION',20,10,30,40);
INSERT INTO INVENTARIO.CONTROL VALUES ( 'CT02','P04','COMBATE SANGRIENTO',10,5,30,35);
INSERT INTO INVENTARIO.CONTROL VALUES ( 'CT03','P05','JUEGO DE COMBATE Y GUERRA',30,8,30,52);
INSERT INTO INVENTARIO.CONTROL VALUES ( 'CT04','P03','CARRERA DE AUTOS',15,9,30,36);
INSERT INTO INVENTARIO.CONTROL VALUES ( 'CT05','P02','FUTBOL DE CLUBES Y PAISES',10,3,30,37);

INSERT INTO INVENTARIO.BOLETA VALUES ( 'B01','CARLOS','45124578','P01','JR CALLE 102',3,40);


SELECT * FROM INVENTARIO.BOLETA;
commit;

-- ======================================================
-- FIN
-- ======================================================

