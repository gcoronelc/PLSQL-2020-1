CREATE OR REPLACE PACKAGE MG.PKG_USUARIO AS
        /*
        NOMBRE DEL PROGRAMA : PKG_USUARIO
        OBJETIVO            : GESTIONAR LOS USUARIOS (CONSULTAR, INSERTAR, MODIFICAR Y
                              ELIMINAR). 
        NOTAS               : 
        AUTOR               : CM
        HISTORIAL           :
        FECHA                 AUTOR            DESCRIPCION
        ======================================================================
        22/02/2020            CM              CREACION DEL PAQUETE
        */

        TYPE CURSOR_TYPE IS REF CURSOR;
        
        FUNCTION FN_ID_TIPO_USUARIO RETURN INTEGER;
        
        PROCEDURE PRC_CONSULTAR_TODO (
                TRC_USUARIOS OUT CURSOR_TYPE
                );

        PROCEDURE PRC_CONSULTAR_FLAG (
                P_FLAG IN T_USUARIO.FLAG%TYPE,
                TRC_USUARIOS OUT CURSOR_TYPE
                );

        PROCEDURE PRC_INSERTAR (
                P_USUARIO IN T_USUARIO.USUARIO%TYPE,
                P_CONTRASENIA IN T_USUARIO.CONTRASENIA%TYPE,
                P_NOMBRES IN T_PERSONA.NOMBRES%TYPE,
                P_FECHA_NAC IN T_PERSONA.FECHA_NAC%TYPE,
                P_ID_PAIS IN T_PERSONA.ID_PAIS%TYPE,
                P_ID_GENERO IN T_PERSONA.ID_GENERO%TYPE,
                P_MENSAJE OUT VARCHAR2
                );
        
        PROCEDURE PRC_ACTUALIZAR_CONTRASENIA (
                P_ID_USUARIO IN T_USUARIO.ID_USUARIO%TYPE,
                P_CONTRASENIA IN T_USUARIO.CONTRASENIA%TYPE,
                P_MENSAJE OUT VARCHAR2
                );
                
        PROCEDURE PRC_ELIMINAR (
                P_ID_USUARIO IN T_USUARIO.ID_USUARIO%TYPE,
                P_ID_PERSONA IN T_PERSONA.ID_PERSONA%TYPE,
                P_MENSAJE OUT VARCHAR2
                );
                
        PROCEDURE PRC_LOGIN (
                P_USUARIO IN T_USUARIO.USUARIO%TYPE,
                P_CONTRASENIA IN T_USUARIO.CONTRASENIA%TYPE,
                P_MENSAJE OUT VARCHAR2
                );

END PKG_USUARIO;
/



CREATE OR REPLACE PACKAGE BODY MG.PKG_USUARIO AS
        /*
        NOMBRE DEL PROGRAMA   : FN_ID_TIPO_USUARIO
        OBJETIVO              : CAPTURAR EL ID DEL TIPO DE USUARIO FREE
        PARAMETROS DE ENTRADA :
        PARAMETROS DE SALIDA  :
        NOTAS                 :
        AUTOR                 : CM
        
        HISTORIAL:
        FECHA                 AUTOR            DESCRIPCION
        ======================================================================
        22/02/2020            CM               CREACION DE LA FUNCION
        */
        FUNCTION FN_ID_TIPO_USUARIO
        RETURN INTEGER
        IS
                V_TIPO_USUARIO INTEGER;
        BEGIN
                SELECT  ID_TIPO_USUARIO
                INTO    V_TIPO_USUARIO
                FROM    T_TIPO_USUARIO
                WHERE   TIPO_USUARIO = 'FREE';
                
                RETURN V_TIPO_USUARIO;
        END;        


        /*
        NOMBRE DEL PROGRAMA   : PRC_CONSULTAR_TODO
        OBJETIVO              : CONSULTAR TODOS LOS USUARIOS REGISTRADOS
        PARAMETROS DE ENTRADA :
        PARAMETROS DE SALIDA  :
                TRC_USUARIOS : CURSOR QUE MUESTRA LA INFORMACION DE LOS USUARIOS
        NOTAS                 :
        AUTOR                 : CM
        
        HISTORIAL:
        FECHA                 AUTOR            DESCRIPCION
        ======================================================================
        22/02/2020            CM               CREACION DEL PROCEDIMIENTO
        */
        PROCEDURE PRC_CONSULTAR_TODO (
                TRC_USUARIOS OUT CURSOR_TYPE
                )
        IS
        BEGIN
                OPEN TRC_USUARIOS FOR
                SELECT  USU.ID_USUARIO,
                        USU.USUARIO,
                        USU.CONTRASENIA,
                        USU.FLAG,
                        PERS.NOMBRES,
                        PAI.PAIS,
                        GEN.GENERO,
                        PERS.FECHA_NAC,
                        USU.FECHA_REG
                FROM    T_USUARIO USU
                JOIN    T_PERSONA PERS ON USU.ID_PERSONA = PERS.ID_PERSONA
                JOIN    T_TIPO_USUARIO TUSU ON USU.ID_TIPO_USUARIO = TUSU.ID_TIPO_USUARIO
                JOIN    T_PAIS PAI ON PERS.ID_PAIS = PAI.ID_PAIS
                JOIN    T_GENERO GEN ON PERS.ID_GENERO = GEN.ID_GENERO
                ORDER BY ID_USUARIO;
        END PRC_CONSULTAR_TODO;
        
        /*
        NOMBRE DEL PROGRAMA   : PRC_CONSULTAR_FLAG
        OBJETIVO              : CONSULTAR TODOS LOS USUARIOS REGISTRADOS SEGUN EL FLAG
        PARAMETROS DE ENTRADA :
                P_FLAG        : FLAG (1,0)
        PARAMETROS DE SALIDA  :
                TRC_USUARIOS : CURSOR QUE MUESTRA LA INFORMACION DE LOS USUARIOS
        NOTAS                 :
        AUTOR                 : CM
        
        HISTORIAL:
        FECHA                 AUTOR            DESCRIPCION
        ======================================================================
        22/02/2020            CM               CREACION DEL PROCEDIMIENTO
        */        
        PROCEDURE PRC_CONSULTAR_FLAG (
                P_FLAG IN T_USUARIO.FLAG%TYPE,
                TRC_USUARIOS OUT CURSOR_TYPE
                )
        IS
        BEGIN
                OPEN TRC_USUARIOS FOR
                SELECT  USU.ID_USUARIO,
                        USU.USUARIO,
                        USU.CONTRASENIA,
                        USU.FLAG,
                        PERS.NOMBRES,
                        PAI.PAIS,
                        GEN.GENERO,
                        PERS.FECHA_NAC,
                        USU.FECHA_REG
                FROM    T_USUARIO USU
                JOIN    T_PERSONA PERS ON USU.ID_PERSONA = PERS.ID_PERSONA
                JOIN    T_TIPO_USUARIO TUSU ON USU.ID_TIPO_USUARIO = TUSU.ID_TIPO_USUARIO
                JOIN    T_PAIS PAI ON PERS.ID_PAIS = PAI.ID_PAIS
                JOIN    T_GENERO GEN ON PERS.ID_GENERO = GEN.ID_GENERO
                WHERE   USU.FLAG = P_FLAG
                ORDER BY ID_USUARIO;                
        END PRC_CONSULTAR_FLAG;
        
        /*
        NOMBRE DEL PROGRAMA   : PRC_INSERTAR
        OBJETIVO              : INSERTAR INFORMACION EN LA TABLA USUARIO Y PERSONA
        PARAMETROS DE ENTRADA :
                P_USUARIO        : USUARIO UTILIZADO
                P_CONTRASENIA    : CONTRASEÑA
                P_NOMBRES        : NOMBRES DEL USUARIO
                P_FECHA_NAC      : FECHA DE NACIMIENTO DEL USUARIO
                P_ID_PAIS        : ID DEL PAIS DEL USUARIO
                P_ID_GENERO      : ID DEL GENERO DEL USUARIO
        PARAMETROS DE SALIDA  :
                P_MENSAJE : MENSAJE RESULTADO
        NOTAS                 :
        AUTOR                 : CM
        
        HISTORIAL:
        FECHA                 AUTOR            DESCRIPCION
        ======================================================================
        22/02/2020            CM               CREACION DEL PROCEDIMIENTO
        */                
        PROCEDURE PRC_INSERTAR (
                P_USUARIO IN T_USUARIO.USUARIO%TYPE,
                P_CONTRASENIA IN T_USUARIO.CONTRASENIA%TYPE,
                P_NOMBRES IN T_PERSONA.NOMBRES%TYPE,
                P_FECHA_NAC IN T_PERSONA.FECHA_NAC%TYPE,
                P_ID_PAIS IN T_PERSONA.ID_PAIS%TYPE,
                P_ID_GENERO IN T_PERSONA.ID_GENERO%TYPE,
                P_MENSAJE OUT VARCHAR2
                )
        IS
                V_MENS_ERROR VARCHAR2(2000);
                V_CONT NUMBER;
                V_ID_PERSONA T_PERSONA.ID_PERSONA%TYPE;
                V_ID_TIPO_USUARIO T_USUARIO.ID_TIPO_USUARIO%TYPE;
                EXCP EXCEPTION;
        BEGIN
                -- NULOS
                IF (PKG_FUNCIONES.FN_NULOS(P_USUARIO) = 1 OR PKG_FUNCIONES.FN_NULOS(P_CONTRASENIA) = 1 OR PKG_FUNCIONES.FN_NULOS(P_NOMBRES) = 1 OR PKG_FUNCIONES.FN_NULOS(P_ID_PAIS) = 1 OR PKG_FUNCIONES.FN_NULOS(P_ID_GENERO) = 1) THEN
                    V_MENS_ERROR := 'LOS SIGUIENTES CAMPOS SON OBLIGATORIOS: USUARIO, CONTRASEÑA, NOMBRES, PAIS Y GENERO';
                    RAISE EXCP;
                END IF;                 
                
                -- ESPACIOS
                IF (PKG_FUNCIONES.FN_ESPACIOS(P_USUARIO) = 1 OR PKG_FUNCIONES.FN_ESPACIOS(P_CONTRASENIA) = 1) THEN
                    V_MENS_ERROR := 'EL CAMPO USUARIO Y CONTRASEÑA NO DEBEN CONTENER ESPACIOS';
                    RAISE EXCP;                    
                END IF;
                
                -- CARACTERES ESPECIALES
                IF (PKG_FUNCIONES.FN_CARACTER_ESPECIAL(P_USUARIO) = 1) THEN
                    V_MENS_ERROR := 'EL CAMPO USUARIO NO DEBE CONTENER CARACTERES ESPECIALES';
                    RAISE EXCP;                    
                END IF;                
                
                -- NUMEROS
                IF (PKG_FUNCIONES.FN_NUMEROS(P_NOMBRES) = 1 OR PKG_FUNCIONES.FN_CARACTER_ESPECIAL(P_NOMBRES) = 1) THEN
                    V_MENS_ERROR := 'EL CAMPO NOMBRES NO DEBE CONTENER NUMEROS O CARACTERES ESPECIALES';
                    RAISE EXCP;                    
                END IF;
                
                -- VALIDACION EN CASO EXISTA USUARIO
                SELECT  COUNT(ID_USUARIO)
                INTO    V_CONT
                FROM    T_USUARIO
                WHERE   FLAG = 1
                AND     USUARIO = LOWER(P_USUARIO);
                
                IF (V_CONT > 0) THEN
                    V_MENS_ERROR := 'EL USUARIO ' || P_USUARIO || ' YA EXISTE, INTENTAR CON OTRA OPCION';
                    RAISE EXCP;                        
                END IF;
                
                ------ PROCESO DE INSERCION
                V_ID_PERSONA := SEQ_PERSONA_ID.NEXTVAL; -- CAPTURA EL VALOR DEL ID PERSONA
                V_ID_TIPO_USUARIO := FN_ID_TIPO_USUARIO; -- CAPTURA EL ID DEL TIPO DE USUARIO FREE POR DEFAULT
                
                -- INSERTA LOS DATOS A LA TABLA PERSONA
                INSERT INTO T_PERSONA
                (
                ID_PERSONA,
                ID_PAIS,
                ID_GENERO,
                NOMBRES,
                FECHA_NAC,
                FLAG
                ) 
                VALUES
                (
                V_ID_PERSONA,
                P_ID_PAIS,
                P_ID_GENERO,
                P_NOMBRES,
                P_FECHA_NAC,
                1
                );
                
                -- INSERTA LOS DATOS A LA TABLA USUARIO
                INSERT INTO T_USUARIO
                (
                ID_USUARIO,
                ID_TIPO_USUARIO,
                ID_PERSONA,
                USUARIO,
                CONTRASENIA,
                FLAG
                )
                VALUES
                (
                MG.SEQ_USUARIO_ID.NEXTVAL,
                V_ID_TIPO_USUARIO,
                V_ID_PERSONA,
                LOWER(P_USUARIO),
                P_CONTRASENIA,
                1
                );
                COMMIT;
                
                P_MENSAJE := 'CUENTA CREADA SATISFACTORIAMENTE';
        EXCEPTION
                WHEN EXCP THEN
                    P_MENSAJE := V_MENS_ERROR;     
                    
                WHEN OTHERS THEN  
                    ROLLBACK;                    
        END PRC_INSERTAR;
        
        /*
        NOMBRE DEL PROGRAMA   : PRC_LOGIN
        OBJETIVO              : VALIDAR LA INFORMACION DEL USUARIO QUE DESEA INGRESAR
        PARAMETROS DE ENTRADA :
                P_USUARIO        : USUARIO UTILIZADO
                P_CONTRASENIA    : CONTRASEÑA
        PARAMETROS DE SALIDA  :
                P_MENSAJE : MENSAJE RESULTADO
        NOTAS                 :
        AUTOR                 : CM
        
        HISTORIAL:
        FECHA                 AUTOR            DESCRIPCION
        ======================================================================
        22/02/2020            CM               CREACION DEL PROCEDIMIENTO
        */            
        PROCEDURE PRC_LOGIN (
                P_USUARIO IN T_USUARIO.USUARIO%TYPE,
                P_CONTRASENIA IN T_USUARIO.CONTRASENIA%TYPE,
                P_MENSAJE OUT VARCHAR2        
                )
        IS
                V_MENS_ERROR VARCHAR2(2000);
                V_CONTRASENIA T_USUARIO.CONTRASENIA%TYPE := 'MG#';
                EXCP EXCEPTION;        
        BEGIN
                SELECT  CONTRASENIA
                INTO    V_CONTRASENIA
                FROM    T_USUARIO
                WHERE   FLAG = 1
                AND     USUARIO = LOWER(P_USUARIO);
                
                IF (V_CONTRASENIA <> P_CONTRASENIA OR PKG_FUNCIONES.FN_NULOS(P_CONTRASENIA) = 1) THEN
                    V_MENS_ERROR := 'LA CONTRASENIA ES INCORRECTO';
                    RAISE EXCP;                        
                END IF;
                
                P_MENSAJE := 'LOGIN CORRECTO';
        EXCEPTION
                WHEN EXCP THEN
                    P_MENSAJE := V_MENS_ERROR;    
                WHEN NO_DATA_FOUND THEN
                    P_MENSAJE := 'EL USUARIO NO EXISTE';
        END PRC_LOGIN;
        
        /*
        NOMBRE DEL PROGRAMA   : PRC_ACTUALIZAR_CONTRASENIA
        OBJETIVO              : ACTUALIZAR LA CONTRASENIA DEL USUARIO
        PARAMETROS DE ENTRADA :
                P_USUARIO        : USUARIO UTILIZADO
                P_CONTRASENIA    : CONTRASEÑA
        PARAMETROS DE SALIDA  :
                P_MENSAJE : MENSAJE RESULTADO
        NOTAS                 :
        AUTOR                 : CM
        
        HISTORIAL:
        FECHA                 AUTOR            DESCRIPCION
        ======================================================================
        22/02/2020            CM               CREACION DEL PROCEDIMIENTO
        */             
        PROCEDURE PRC_ACTUALIZAR_CONTRASENIA (
                P_ID_USUARIO IN T_USUARIO.ID_USUARIO%TYPE,
                P_CONTRASENIA IN T_USUARIO.CONTRASENIA%TYPE,
                P_MENSAJE OUT VARCHAR2
                )
        IS
                V_MENS_ERROR VARCHAR2(2000);
                EXCP EXCEPTION;        
        BEGIN
                -- NULO
                IF (PKG_FUNCIONES.FN_NULOS(P_CONTRASENIA) = 1) THEN
                    V_MENS_ERROR := 'LA CONTRASEÑA NO PUEDE ESTAR VACIO';
                    RAISE EXCP;
                END IF;  
                
                -- ESPACIOS
                IF (PKG_FUNCIONES.FN_ESPACIOS(P_CONTRASENIA) = 1) THEN
                    V_MENS_ERROR := 'LA CONTRASEÑA NO DEBE CONTENER ESPACIOS';
                    RAISE EXCP;                    
                END IF;
                
                UPDATE  T_USUARIO
                SET     CONTRASENIA = P_CONTRASENIA
                WHERE   ID_USUARIO = P_ID_USUARIO;
                
                COMMIT;
                
                P_MENSAJE := 'CONTRASEÑA ACTUALIZADA CORRECTAMENTE';
        EXCEPTION
                WHEN EXCP THEN
                    P_MENSAJE := V_MENS_ERROR;         
        END PRC_ACTUALIZAR_CONTRASENIA;
 

        /*
        NOMBRE DEL PROGRAMA   : PRC_ELIMINAR
        OBJETIVO              : ELIMINAR LOGICAMENTE EL USUARIO
        PARAMETROS DE ENTRADA :
                P_ID_USUARIO  : ID USUARIO
                P_ID_PERSONA  : ID PERSONA
        PARAMETROS DE SALIDA  :
                P_MENSAJE : MENSAJE RESULTADO
        NOTAS                 : CAMBIA EL ESTADO 1(ACTIVO) A 0(ELIMINADO)
        AUTOR                 : CM
        
        HISTORIAL:
        FECHA                 AUTOR            DESCRIPCION
        ======================================================================
        22/02/2020            CM               CREACION DEL PROCEDIMIENTO
        */           
        PROCEDURE PRC_ELIMINAR (
                P_ID_USUARIO IN T_USUARIO.ID_USUARIO%TYPE,
                P_ID_PERSONA IN T_PERSONA.ID_PERSONA%TYPE,
                P_MENSAJE OUT VARCHAR2
                )
        IS
        BEGIN
                UPDATE  T_PERSONA
                SET     FLAG = 0
                WHERE   ID_PERSONA = P_ID_PERSONA;
                
                UPDATE  T_USUARIO
                SET     FLAG = 0,
                        FECHA_BAJA = SYSDATE
                WHERE   ID_USUARIO = P_ID_USUARIO;
                
                COMMIT;
                
                P_MENSAJE := 'USUARIO ELIMINADO CORRECTAMENTE';
        END PRC_ELIMINAR;
        
END PKG_USUARIO;
/