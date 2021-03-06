-prueba insert
SET serveroutput ON;
DECLARE
P_ID_USUARIO NUMBER;
P_ID_CLIENTE NUMBER; 		   
P_ID_UNIDAD NUMBER; 		   
P_CORREO VARCHAR2(100); 			   
P_USUARIO VARCHAR2(20);
P_CLAVE VARCHAR2(50); 			   
P_ES_REGISTRO CHAR(1);
P_FECHA_CREACION DATE;
P_USUARIO_CREACION VARCHAR2(30);
P_COD_RESPUESTA VARCHAR2(200);
P_MENSAJE VARCHAR2(100);
BEGIN
    P_ID_USUARIO := SQ_USUARIO.nextval;
    P_ID_CLIENTE := null; 		   
    P_ID_UNIDAD := 2; 		   
    P_CORREO := 'jorge.martinez@gmai.com'; 			   
    P_USUARIO := 'JMARTINEZQ';
    P_CLAVE := 'flor'; 			   
    P_ES_REGISTRO := null;
    P_FECHA_CREACION := null;
    P_USUARIO_CREACION := 'ADM';
    P_COD_RESPUESTA := NULL;
    P_MENSAJE       :=NULL;
    
  SIGDOC_USUARIO_tapi.SP_CREATE_USUARIO ( P_ID_USUARIO, P_ID_CLIENTE, P_ID_UNIDAD, P_CORREO, P_USUARIO, P_CLAVE,P_ES_REGISTRO,P_FECHA_CREACION,P_USUARIO_CREACION ,P_COD_RESPUESTA, P_MENSAJE) ;
  dbms_output.put_line(P_COD_RESPUESTA || ', ' || P_MENSAJE);
END;


select * from sigdoc_usuario;

--prueba buscar

DECLARE
  P_USUARIO VARCHAR2(20);
  P_CURSOR SYS_REFCURSOR ;
  P_COD_RESPUESTA NUMBER;
  P_MENSAJE       VARCHAR2(200);
  reg SIGDOC_USUARIO%rowtype;
BEGIN
  P_USUARIO       := 'RRAMIREZQ';
  P_CURSOR        := NULL;
  P_COD_RESPUESTA := NULL;
  P_MENSAJE       :=NULL;
  
  SIGDOC_USUARIO_tapi.SP_LEER_USUARIO ( P_USUARIO, P_CURSOR, P_COD_RESPUESTA, P_MENSAJE);
  LOOP
    IF P_CURSOR%isopen THEN
      FETCH P_CURSOR INTO reg;
      EXIT
    WHEN P_CURSOR%NOTFOUND;
      -- Mostrar fila
      dbms_output.put_line( reg.USUARIO|| ', ' ||reg.CLAVE);
      CLOSE P_CURSOR;
    ELSE
      EXIT;
    END IF;
    -- Leer fila
  END LOOP;
  dbms_output.put_line(P_COD_RESPUESTA || ', ' || P_MENSAJE);
END;
/

select * from sigdoc_usuario;
--prueba editar

DECLARE
    P_ID_USUARIO NUMBER;	   
    P_ID_UNIDAD NUMBER; 		   
    P_CORREO VARCHAR2(100); 			   
    P_USUARIO VARCHAR2(20);
    P_CLAVE VARCHAR2(50); 			   
    P_FECHA_MODIFICACION DATE;
    P_USUARIO_MODIFICACION VARCHAR2(30);
    P_COD_RESPUESTA NUMBER;
    P_MENSAJE VARCHAR2(100);
BEGIN
    P_ID_USUARIO := 54;	   
    P_ID_UNIDAD := 11; 		   
    P_CORREO :='ramirez@gmail.com' ; 			   
    P_USUARIO := 'RAMIREZ';
    P_CLAVE := 'MININOs'; 			   
    P_FECHA_MODIFICACION := NULL;
    P_USUARIO_MODIFICACION := 'RRAMIREZQ';
    P_COD_RESPUESTA := NULL;
    P_MENSAJE       := NULL;
    
  SIGDOC_USUARIO_tapi.SP_UPDATE_USUARIO(P_ID_USUARIO, P_ID_UNIDAD, P_CORREO, P_USUARIO, P_CLAVE, P_FECHA_MODIFICACION, P_USUARIO_MODIFICACION,P_COD_RESPUESTA, P_MENSAJE) ;
  dbms_output.put_line(P_COD_RESPUESTA || ', ' || P_MENSAJE);
END;
/


select us.clave from sigdoc_usuario us
where us.id_usuario = 54;

select sigdoc_usuario_tapi.fn_descencriptar('D17CB003597EB226') from dual;


--prueba eliminar
DECLARE
    P_ID_USUARIO NUMBER;	   
    P_ES_REGISTRO CHAR(1);	   
    P_FECHA_MODIFICACION DATE;
    P_USUARIO_MODIFICACION VARCHAR2(30);
    P_COD_RESPUESTA NUMBER;
    P_MENSAJE VARCHAR2(200);
BEGIN
    P_ID_USUARIO := 100;
    P_ES_REGISTRO := null;			   
    P_FECHA_MODIFICACION := NULL;
    P_USUARIO_MODIFICACION := 'RRAMIREZQ';
    P_COD_RESPUESTA := NULL;
    P_MENSAJE       := NULL;
    
  SIGDOC_USUARIO_tapi.SP_DELETE_USUARIO(P_ID_USUARIO, P_ES_REGISTRO, P_FECHA_MODIFICACION,P_USUARIO_MODIFICACION,P_COD_RESPUESTA, P_MENSAJE) ;
  dbms_output.put_line(P_COD_RESPUESTA || ', ' || P_MENSAJE);
END;
/

