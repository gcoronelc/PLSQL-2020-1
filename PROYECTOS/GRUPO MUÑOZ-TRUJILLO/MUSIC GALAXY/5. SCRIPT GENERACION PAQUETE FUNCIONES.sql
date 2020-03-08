CREATE OR REPLACE PACKAGE MG.PKG_FUNCIONES AS
        /*
        NOMBRE DEL PROGRAMA : PKG_FUNCIONES
        OBJETIVO            : AGRUPAR LAS FUNCIONES DE VALIDACIONES
        NOTAS               : 
        AUTOR               : CM
        HISTORIAL           :
        FECHA                 AUTOR            DESCRIPCION
        ======================================================================
        22/02/2020            CM              CREACION DE LA FUNCION
        */
        FUNCTION FN_NULOS (
                P_CADENA VARCHAR2
                ) RETURN NUMBER;

        FUNCTION FN_ESPACIOS (
                P_CADENA VARCHAR2
                ) RETURN NUMBER;
                
        FUNCTION FN_NUMEROS (
                P_CADENA VARCHAR2
                ) RETURN NUMBER; 
                
        FUNCTION FN_CARACTER_ESPECIAL (
                P_CADENA VARCHAR2
                ) RETURN NUMBER;
                
END PKG_FUNCIONES;
/

CREATE OR REPLACE PACKAGE BODY MG.PKG_FUNCIONES AS
        /*
        NOMBRE DEL PROGRAMA   : FN_NULOS
        OBJETIVO              : VALIDAR SI LA CADENA QUE INGRESA ES NULO/VACIO
        PARAMETROS DE ENTRADA :
        PARAMETROS DE SALIDA  :
        NOTAS                 :
        AUTOR                 : CM
        
        HISTORIAL:
        FECHA                 AUTOR            DESCRIPCION
        ======================================================================
        22/02/2020            CM               CREACION DE LA FUNCION
        */        
        FUNCTION FN_NULOS (
                P_CADENA VARCHAR2
                )
        RETURN NUMBER
        IS
            V_RESULT NUMBER;
        BEGIN
            V_RESULT := 0; -- SI NO ES NULO
            
            IF (P_CADENA IS NULL) THEN
                V_RESULT:= 1; -- SI ES NULO
            END IF;
            
            RETURN V_RESULT;
        END FN_NULOS;

        /*
        NOMBRE DEL PROGRAMA   : FN_ESPACIOS
        OBJETIVO              : VALIDAR SI LA CADENA QUE INGRESA CONTIENE ESPACIOS
        PARAMETROS DE ENTRADA :
        PARAMETROS DE SALIDA  :
        NOTAS                 :
        AUTOR                 : CM
        
        HISTORIAL:
        FECHA                 AUTOR            DESCRIPCION
        ======================================================================
        22/02/2020            CM               CREACION DE LA FUNCION
        */    
        FUNCTION FN_ESPACIOS (
                P_CADENA VARCHAR2
                )
        RETURN NUMBER
        IS
                V_RESULT NUMBER;
        BEGIN
                
                V_RESULT := 0; -- SI NO TIENE ESPACIOS
                
                IF (REGEXP_COUNT(P_CADENA, ' ')) > 0 THEN
                    V_RESULT := 1; -- SI TIENE ESPACIOS
                END IF;
                
                RETURN V_RESULT;
        END FN_ESPACIOS;
        
        /*
        NOMBRE DEL PROGRAMA   : FN_NUMEROS
        OBJETIVO              : VALIDAR SI LA CADENA QUE INGRESA CONTIENE NUMEROS
        PARAMETROS DE ENTRADA :
        PARAMETROS DE SALIDA  :
        NOTAS                 :
        AUTOR                 : CM
        
        HISTORIAL:
        FECHA                 AUTOR            DESCRIPCION
        ======================================================================
        22/02/2020            CM               CREACION DE LA FUNCION
        */            
        FUNCTION FN_NUMEROS (
                P_CADENA VARCHAR2
                )
        RETURN NUMBER
        IS
                V_RESULT NUMBER;
        BEGIN
                V_RESULT := 0; -- SI NO TIENE NUMEROS
            
                IF (REGEXP_COUNT(P_CADENA,'[0-9]')) > 0 THEN
                    V_RESULT := 1; -- SI TIENE NUMEROS
                END IF;
                
                RETURN V_RESULT;
        END FN_NUMEROS;        

        /*
        NOMBRE DEL PROGRAMA   : FN_CARACTER_ESPECIAL
        OBJETIVO              : VALIDAR SI LA CADENA QUE INGRESA CONTIENE CARACTERES ESPECIALES
        PARAMETROS DE ENTRADA :
        PARAMETROS DE SALIDA  :
        NOTAS                 :
        AUTOR                 : CM
        
        HISTORIAL:
        FECHA                 AUTOR            DESCRIPCION
        ======================================================================
        22/02/2020            CM               CREACION DE LA FUNCION
        */   
        FUNCTION FN_CARACTER_ESPECIAL (
                P_CADENA VARCHAR2
                )
        RETURN NUMBER
        IS
                V_RESULT NUMBER;
        BEGIN
                V_RESULT := 0; -- SI NO TIENE CARACTER ESPECIAL
            
                IF (REGEXP_COUNT(P_CADENA,'[^A-Za-z0-9ÁÉÍÓÚáéíóú ]')) > 0 THEN
                    V_RESULT := 1; -- SI TIENE CARACTER ESPECIAL
                END IF;
                
                RETURN V_RESULT;        
        END FN_CARACTER_ESPECIAL;

END PKG_FUNCIONES;
/