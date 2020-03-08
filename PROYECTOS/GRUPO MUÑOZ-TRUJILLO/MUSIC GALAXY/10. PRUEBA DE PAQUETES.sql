SET SERVEROUT ON;
------------- PKG_USUARIO
---- PRC_CONSULTAR_TODO
VAR USUARIOS REFCURSOR;
EXEC MG.PKG_USUARIO.PRC_CONSULTAR_TODO(:USUARIOS);
PRINT USUARIOS;

---- PRC_CONSULTAR_FLAG
VAR USUARIOS REFCURSOR;
EXEC MG.PKG_USUARIO.PRC_CONSULTAR_FLAG(0,:USUARIOS);
PRINT USUARIOS;


---- PRC_INSERTAR
-- ERROR NULOS
VAR RESULTADO VARCHAR2;
EXEC MG.PKG_USUARIO.PRC_INSERTAR(NULL,NULL,'ANA GARCIA',NULL,1,2,:RESULTADO);
PRINT RESULTADO;

-- ERROR ESPACIOS
VAR RESULTADO VARCHAR2;
EXEC MG.PKG_USUARIO.PRC_INSERTAR(' ','      ','ANA GARCIA',NULL,1,2,:RESULTADO);
PRINT RESULTADO;

-- ERROR CARACTER ESPECIAL
VAR RESULTADO VARCHAR2;
EXEC MG.PKG_USUARIO.PRC_INSERTAR('AGARCIA@','123456','ANA GARCIA',NULL,1,2,:RESULTADO);
PRINT RESULTADO;

-- ERROR NUMEROS
VAR RESULTADO VARCHAR2;
EXEC MG.PKG_USUARIO.PRC_INSERTAR('AGARCIA','123456','ANA GARCIA2',NULL,1,2,:RESULTADO);
PRINT RESULTADO;

-- EXISTE USUARIO
VAR RESULTADO VARCHAR2;
EXEC MG.PKG_USUARIO.PRC_INSERTAR('anonimo1','123456','ANONIMO SA',NULL,1,2,:RESULTADO);
PRINT RESULTADO;

-- TEST EXITOSO
VAR RESULTADO VARCHAR2;
EXEC MG.PKG_USUARIO.PRC_INSERTAR('agarcia','123456','ANA GARCIA',NULL,1,2,:RESULTADO);
PRINT RESULTADO;

---- PRC_ACTUALIZAR_CONTRASENIA
-- ERROR NULO
VAR RESULTADO VARCHAR2;
EXEC MG.PKG_USUARIO.PRC_ACTUALIZAR_CONTRASENIA(1,NULL,:RESULTADO);
PRINT RESULTADO;

-- ERROR ESPACIOS
VAR RESULTADO VARCHAR2;
EXEC MG.PKG_USUARIO.PRC_ACTUALIZAR_CONTRASENIA(1,'1234 56',:RESULTADO);
PRINT RESULTADO;

-- TEST EXITOSO
VAR RESULTADO VARCHAR2;
EXEC MG.PKG_USUARIO.PRC_ACTUALIZAR_CONTRASENIA(1,'1234567',:RESULTADO);
PRINT RESULTADO;

---- PRC_ELIMINAR
VAR RESULTADO VARCHAR2;
EXEC MG.PKG_USUARIO.PRC_ELIMINAR(20,20,:RESULTADO);
PRINT RESULTADO;

---- PRC_LOGIN
VAR RESULTADO VARCHAR2;
EXEC MG.PKG_USUARIO.PRC_LOGIN('anonimo1','1234567 ',:RESULTADO);
PRINT RESULTADO;



---------------- PKG_PKG_PREMIUM
VARIABLE V_CUENTA REFCURSOR;
EXEC PKG_PREMIUM.PRC_CREAR_CUENTA(:V_CUENTA);
PRINT V_CUENTA;

EXEC PKG_PREMIUM.PRC_PAGO_SUSCRIPCION(1982, 40320645);


--------------- PKG REPRODUCCION
-- Crear una lista de reproduccion
EXEC MG.PKG_REPRODUCCION.PRC_CREAR_LISTA (2478, 'BALADAS');

-- CAMBIAR NOMBRE A LISTA DE REPRODUCCION
EXEC MG.PKG_REPRODUCCION.PRC_MODIFICAR_LISTA (3, 'URBANAS');

-- AGREGAR CANCION A LISTA
-- USUARIO PREMIUM
EXEC MG.PKG_REPRODUCCION.PRC_AGREGAR_CANCION (3, 2);
EXEC MG.PKG_REPRODUCCION.PRC_AGREGAR_CANCION (3, 3);
EXEC MG.PKG_REPRODUCCION.PRC_AGREGAR_CANCION (3, 4);
EXEC MG.PKG_REPRODUCCION.PRC_AGREGAR_CANCION (3, 5);
EXEC MG.PKG_REPRODUCCION.PRC_AGREGAR_CANCION (3, 6);
EXEC MG.PKG_REPRODUCCION.PRC_AGREGAR_CANCION (3, 7);

-- USUARIO NORMAL
EXEC MG.PKG_REPRODUCCION.PRC_AGREGAR_CANCION (1, 2);
EXEC MG.PKG_REPRODUCCION.PRC_AGREGAR_CANCION (1, 3);
EXEC MG.PKG_REPRODUCCION.PRC_AGREGAR_CANCION (1, 4);
EXEC MG.PKG_REPRODUCCION.PRC_AGREGAR_CANCION (1, 5);
EXEC MG.PKG_REPRODUCCION.PRC_AGREGAR_CANCION (1, 6);
EXEC MG.PKG_REPRODUCCION.PRC_AGREGAR_CANCION (1, 7);


-- ELIMINAR CANCION A LISTA
EXEC MG.PKG_REPRODUCCION.PRC_ELIMINAR_CANCION (6);

-- AGREGAR CANCION A COLA DE REPRODUCCION
EXEC MG.PKG_REPRODUCCION.PRC_LISTA_COLA (2478, 3);
EXEC MG.PKG_REPRODUCCION.PRC_LISTA_COLA (1, 1);

-- REPRODUCIR CANCION EN COLA DE REPRODUCCION
EXEC MG.PKG_REPRODUCCION.PRC_REPRODUCCION_LISTA (2478, 3);
EXEC MG.PKG_REPRODUCCION.PRC_REPRODUCCION_LISTA (1, 1);

------------- PKG_REPORTES

---- ANIO, MES, TOP, TIPO REPORTE(1:CANCIONES, 2:ARTISTAS)
-- CANCION
VAR RESULTADO REFCURSOR;
EXEC MG.PKG_REPORTES.PRC_TOP_CAN_ART_ANIO_MES(NULL,NULL,NULL,1,:RESULTADO);
PRINT RESULTADO;

-- ARTISTA
VAR RESULTADO REFCURSOR;
EXEC MG.PKG_REPORTES.PRC_TOP_CAN_ART_ANIO_MES(2019,2,3,2,:RESULTADO);
PRINT RESULTADO;


-- VALIDA TOP CANCION
SELECT  TO_CHAR(FECHA,'YYYY') ANIO,
        TO_CHAR(FECHA,'MM') MES,
        CREPRO.ID_CANCION,
        CAN.CANCION,
        COUNT(ID_CANCION_REPRO) REPRODUCCION
FROM    MG.T_CANCION_REPRO CREPRO
JOIN    MG.T_CANCION CAN ON CAN.ID_CANCION = CREPRO.ID_CANCION
WHERE   TO_CHAR(FECHA,'YYYY') = 2019
AND     TO_CHAR(FECHA,'MM') = 2
GROUP BY TO_CHAR(FECHA,'YYYY'),TO_CHAR(FECHA,'MM'),CREPRO.ID_CANCION,CAN.CANCION
ORDER BY REPRODUCCION DESC;

-- VALIDA TOP ARTISTA
SELECT  TO_CHAR(FECHA,'YYYY') ANIO,
        TO_CHAR(FECHA,'MM') MES,
        ART.ARTISTA,
        COUNT(ID_CANCION_REPRO) REPRODUCCION
FROM    MG.T_CANCION_REPRO CREPRO
JOIN    MG.T_CANCION CAN ON CAN.ID_CANCION = CREPRO.ID_CANCION
JOIN    MG.T_ARTISTA ART ON ART.ID_ARTISTA = CAN.ID_ARTISTA
WHERE   TO_CHAR(FECHA,'YYYY') = 2019
AND     TO_CHAR(FECHA,'MM') = 2
GROUP BY TO_CHAR(FECHA,'YYYY'),TO_CHAR(FECHA,'MM'),ART.ARTISTA
ORDER BY REPRODUCCION DESC;
