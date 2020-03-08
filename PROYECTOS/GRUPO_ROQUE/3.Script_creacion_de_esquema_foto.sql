

-- SET TERMOUT OFF
-- SET ECHO OFF


-- VALIDANDO SI EL ESQUEMA "FOTO" EXISTE

DECLARE
	N INT;
	COMMAND VARCHAR2(200);
BEGIN
	COMMAND := 'DROP USER FOTO CASCADE';
	SELECT COUNT(*) INTO N
	FROM DBA_USERS
	WHERE USERNAME = 'FOTO';
	IF ( N = 1 ) THEN
		EXECUTE IMMEDIATE COMMAND;
	END IF;
END;
/

-- =============================================
-- ASIGNANDO PRIVILEGIOS AL USUARIO "FOTO"
-- =============================================

CREATE USER foto IDENTIFIED BY foto;

GRANT CONNECT, RESOURCE TO foto;

ALTER USER foto
QUOTA UNLIMITED ON USERS;

GRANT CREATE VIEW TO foto;


-- CONECTANDO CON EL USUARIO FOTO

CONNECT foto/foto


-- CREACIÓN DE LOS OBJETOS DE "FOTO" EN LA BD



CREATE TABLE cargo (
    id_cargo  NUMBER(5) NOT NULL,
    nombre    VARCHAR2(30)
);

ALTER TABLE cargo ADD CONSTRAINT cargo_pk PRIMARY KEY ( id_cargo );

CREATE TABLE cliente (
    id_cliente           NUMBER(5) NOT NULL,
    nombres              VARCHAR2(50),
    apellidos            VARCHAR2(50),
    tipo_documento       VARCHAR2(20),
    nro_documento        VARCHAR2(30),
    telefono             VARCHAR2(10),
    celular              VARCHAR2(11),
    direccion            VARCHAR2(100),
    correo               VARCHAR2(100),
    estado               VARCHAR2(10),
    preferencias         CLOB,
    comentarios          CLOB,
    fecha_registro       DATE,
    fecha_actualizacion  DATE,
    id_ubigeo            CHAR(6) NOT NULL
);

ALTER TABLE cliente ADD CONSTRAINT cliente_pk PRIMARY KEY ( id_cliente );

CREATE TABLE empleado (
    id_empleado     NUMBER(5) NOT NULL,
    nombres         VARCHAR2(50),
    apellidos       VARCHAR2(50),
    telefono        VARCHAR2(11),
    direccion       VARCHAR2(50),
    estado          CHAR(1),
    fecha_ingreso   DATE,
    fecha_cese      DATE,
    fecha_registro  DATE,
    id_cargo        NUMBER(5) NOT NULL,
    id_sede         NUMBER(5) NOT NULL,
    id_jefe         NUMBER(5),
    id_ubigeo       CHAR(6) NOT NULL
);

ALTER TABLE empleado ADD CONSTRAINT empleado_pk PRIMARY KEY ( id_empleado );

CREATE TABLE foto (
    id_foto        NUMBER(5) NOT NULL,
    nombre         VARCHAR2(30),
    unidad_medida  CHAR(2),
    alto           NUMBER(6, 2),
    ancho          NUMBER(6, 2)
);

ALTER TABLE foto ADD CONSTRAINT foto_pk PRIMARY KEY ( id_foto );

CREATE TABLE paquete (
    id_paquete   NUMBER(5) NOT NULL,
    nombre       VARCHAR2(50),
    descripcion  CLOB,
    nro_fotos    NUMBER(3),
    precio       NUMBER(5, 2)
);

ALTER TABLE paquete ADD CONSTRAINT paquete_pk PRIMARY KEY ( id_paquete );

CREATE TABLE paquete_foto (
    id_paquete  NUMBER(5) NOT NULL,
    id_foto     NUMBER(5) NOT NULL,
    tipo_foto   VARCHAR2(30),
    cantidad    NUMBER(3)
);

CREATE TABLE sede (
    id_sede    NUMBER(5) NOT NULL,
    nombre     VARCHAR2(50),
    direccion  VARCHAR2(100),
    id_ubigeo  CHAR(6) NOT NULL
);

ALTER TABLE sede ADD CONSTRAINT sede_pk PRIMARY KEY ( id_sede );

CREATE TABLE sesion (
    id_sesion          NUMBER(5) NOT NULL,
    id_cliente         NUMBER(5) NOT NULL,
    id_tematica        NUMBER(5) NOT NULL,
    id_sede            NUMBER(5) NOT NULL,
    id_paquete         NUMBER(5) NOT NULL,
    estado             VARCHAR2(30),
    forma_pago         VARCHAR2(20),
    estado_pago        VARCHAR2(20),
    monto_pagado       NUMBER(5, 2),
    monto_a_pagar      NUMBER(5, 2),
    comentarios        CLOB,
    id_usuario         NUMBER(5) NOT NULL,
    fecha_hora_sesion  DATE,
    fecha_registro     DATE
);

ALTER TABLE sesion ADD CONSTRAINT sesion_pk PRIMARY KEY ( id_sesion );

CREATE TABLE tematica (
    id_tematica       NUMBER(5) NOT NULL,
    nombre            VARCHAR2(30),
    descripcion       CLOB,
    recomendacion     CLOB,
    descuento_porc    NUMBER(5, 2),
    min_personas      NUMBER(2),
    max_personas      NUMBER(2),
    duracion_minutos  NUMBER(3)
);

ALTER TABLE tematica ADD CONSTRAINT tematica_pk PRIMARY KEY ( id_tematica );

CREATE TABLE ubigeo (
    id_ubigeo     CHAR(6) NOT NULL,
    departamento  VARCHAR2(40),
    provincia     VARCHAR2(40),
    distrito      VARCHAR2(40)
);

ALTER TABLE ubigeo ADD CONSTRAINT ubigeo_pk PRIMARY KEY ( id_ubigeo );

CREATE TABLE usuario (
    id_usuario      NUMBER(5) NOT NULL,
    id_empleado     NUMBER(5) NOT NULL,
    usuario         VARCHAR2(30),
    contrasena      VARCHAR2(60),
    estado          CHAR(1),
    fecha_registro  DATE
);

ALTER TABLE usuario ADD CONSTRAINT usuario_pk PRIMARY KEY ( id_usuario );

ALTER TABLE cliente
    ADD CONSTRAINT cliente_ubigeo_fk FOREIGN KEY ( id_ubigeo )
        REFERENCES ubigeo ( id_ubigeo );

ALTER TABLE empleado
    ADD CONSTRAINT empleado_cargo_fk FOREIGN KEY ( id_cargo )
        REFERENCES cargo ( id_cargo );

ALTER TABLE empleado
    ADD CONSTRAINT empleado_empleado_fk FOREIGN KEY ( id_jefe )
        REFERENCES empleado ( id_empleado );

ALTER TABLE empleado
    ADD CONSTRAINT empleado_sede_fk FOREIGN KEY ( id_sede )
        REFERENCES sede ( id_sede );

ALTER TABLE empleado
    ADD CONSTRAINT empleado_ubigeo_fk FOREIGN KEY ( id_ubigeo )
        REFERENCES ubigeo ( id_ubigeo );

ALTER TABLE paquete_foto
    ADD CONSTRAINT paquete_foto_foto_fk FOREIGN KEY ( id_foto )
        REFERENCES foto ( id_foto );

ALTER TABLE paquete_foto
    ADD CONSTRAINT paquete_foto_paquete_fk FOREIGN KEY ( id_paquete )
        REFERENCES paquete ( id_paquete );

ALTER TABLE sede
    ADD CONSTRAINT sede_ubigeo_fk FOREIGN KEY ( id_ubigeo )
        REFERENCES ubigeo ( id_ubigeo );

ALTER TABLE sesion
    ADD CONSTRAINT sesion_cliente_fk FOREIGN KEY ( id_cliente )
        REFERENCES cliente ( id_cliente );

ALTER TABLE sesion
    ADD CONSTRAINT sesion_paquete_fk FOREIGN KEY ( id_paquete )
        REFERENCES paquete ( id_paquete );

ALTER TABLE sesion
    ADD CONSTRAINT sesion_sede_fk FOREIGN KEY ( id_sede )
        REFERENCES sede ( id_sede );

ALTER TABLE sesion
    ADD CONSTRAINT sesion_tematica_fk FOREIGN KEY ( id_tematica )
        REFERENCES tematica ( id_tematica );

ALTER TABLE sesion
    ADD CONSTRAINT sesion_usuario_fk FOREIGN KEY ( id_usuario )
        REFERENCES usuario ( id_usuario );

ALTER TABLE usuario
    ADD CONSTRAINT usuario_empleado_fk FOREIGN KEY ( id_empleado )
        REFERENCES empleado ( id_empleado );
