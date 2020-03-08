CREATE OR REPLACE PACKAGE MG.PKG_REPORTES AS
        /*
        NOMBRE DEL PROGRAMA : PKG_REPORTES
        OBJETIVO            : GESTIONAR LOS REPORTES 
        NOTAS               : 
        AUTOR               : CM
        HISTORIAL           :
        FECHA                 AUTOR            DESCRIPCION
        ======================================================================
        22/02/2020            CM              CREACION DEL PAQUETE
        */
        TYPE CURSOR_TYPE IS REF CURSOR;
        
        PROCEDURE PRC_TOP_CAN_ART_ANIO_MES (
                P_ANIO IN NUMBER,
                P_MES IN NUMBER,
                P_TOP IN NUMBER,
                P_REPORTE IN NUMBER,
                TRC_REPORTE OUT CURSOR_TYPE
                );
                
END PKG_REPORTES;
/

CREATE OR REPLACE PACKAGE BODY MG.PKG_REPORTES AS
        /*
        NOMBRE DEL PROGRAMA   : PRC_TOP_CAN_ART_ANIO_MES
        OBJETIVO              : MONSTRAR REPORTE POR ANIO Y MES SEGUN EL REPORTE ELEGIDO
        PARAMETROS DE ENTRADA :
                P_ANIO        : PARAMETRO ANIO
                P_MES         : PARAMETRO MES
                P_TOP         : PARAMETRO TOP
                P_REPORTE     : PARAMETRO REPORTE
        PARAMETROS DE SALIDA  :
                TRC_REPORTE   : CURSOR QUE MUESTRA EL REPORTE POR ANIO Y MES SEGUN EL TIPO DE REPORTE ELEGIDO
        NOTAS                 : LOS TIPOS DE REPORTES MANEJADOS SON PARA TOP CANCION (1) Y TOP ARTISTA (2)
                                EN CASO EL ANIO SEA NULO O VACIO SE TOMARA POR DEFECTO EN CUENTA EL ANIO ACTUAL.
                                EN CASO EL MES SEA NULO O VACIO, SE CONSIDERARA TODO LOS MESES DEL ANIO ELEGIDO.
                                EN CASO EL TOP SEA NULO O VACIO O MENOR O IGUAL A CERO, SE CONSIDERARA EL TOP 2.
                                EN CASO EL REPORTE ELEGIDO (1,2) ES DIFERENTE SE TOMARA EN CUENTA EL REPORTE 1.
        AUTOR                 : CM
        
        HISTORIAL:
        FECHA                 AUTOR            DESCRIPCION
        ======================================================================
        22/02/2020            CM               CREACION DEL PROCEDIMIENTO
        */  
        PROCEDURE PRC_TOP_CAN_ART_ANIO_MES (
                P_ANIO IN NUMBER,
                P_MES IN NUMBER,
                P_TOP IN  NUMBER,
                P_REPORTE IN NUMBER,
                TRC_REPORTE OUT CURSOR_TYPE
                )
        IS
                V_COMMAND_IN VARCHAR2(4000); -- VARIABLE DEL COMANDO INICIAL PARA OBTENER FECHA MINIMA Y MAXIMA
                V_COMMAND_FIN VARCHAR2(4000); -- VARIABLE DEL COMANDO FINAL, CONCATENA EL COMANDO INICIAL Y EL WHERE
                V_COMMAND_RANK VARCHAR2(4000); -- VARIABLE DEL COMANDO RANKING DONDE SE INSERTA DATOS A LA SEGUNDA TABLA TEMPORAL
                V_COMMAND_RANK_2 VARCHAR2(4000); -- VARIABLE DEL COMANDO RANKING DONDE SE OBTIENE LA TABLA PRIMERA TABLA TEMPORAL
                V_COMMAND_CUR VARCHAR2(4000); -- VARIABLE DEL COMANDO CURSOR FINAL
                V_COMMAND_CUR_WHERE VARCHAR2(4000); -- VARIABLE DEL COMANDO CURSOR DONDE ESTA EL WHERE
                V_COLUMN VARCHAR2(1000); -- VARIABLE DEL NOMBRE DE COLUMNA A UTILIZAR SEGUN EL FLAG REPORTE(TOP CANCIONES O TOP ARTISTAS)
                V_FECHA_MIN DATE; -- VARIABLE DE LA FECHA MINIMA
                V_FECHA_MAX DATE; -- VARIABLE DE LA FECHA MAXIMA
                V_ANIO NUMBER; -- VARIABLE DEL ANIO
                V_MES NUMBER; -- VARIABLE DEL MES
                V_TOP NUMBER; -- VARIABLE DEL TOP 
                V_REPORTE NUMBER; -- VARIABLE DEL REPORTE
                EXCP EXCEPTION; -- VARIABLE EXCEPCION
        BEGIN
                V_COMMAND_IN := 'SELECT MIN(FECHA), MAX(FECHA) FROM MG.T_CALENDARIO WHERE '; -- CONSULTA INICIAL
                V_ANIO := P_ANIO;
                V_MES := P_MES;
                V_TOP := P_TOP;
                V_REPORTE := P_REPORTE;
                
                -- NULO Y ESPACIO P_ANIO
                IF (PKG_FUNCIONES.FN_NULOS(P_ANIO) = 1 OR PKG_FUNCIONES.FN_ESPACIOS(P_ANIO) = 1) THEN
                    V_ANIO := TO_CHAR(SYSDATE,'YYYY');
                END IF;                 
                
                -- NULO Y ESPACIO P_MES
                IF (PKG_FUNCIONES.FN_NULOS(P_MES) = 1 OR PKG_FUNCIONES.FN_ESPACIOS(P_MES) = 1) THEN
                    V_MES := 12; -- SE DA EL VALOR MAXIMO DEL MES DENTRO DE UN AÑO
                END IF;      
                
                -- NULO Y ESPACIO P_TOP
                IF (PKG_FUNCIONES.FN_NULOS(P_TOP) = 1 OR PKG_FUNCIONES.FN_ESPACIOS(P_TOP) = 1 OR P_TOP <= 0) THEN
                    V_TOP := 2;
                END IF;    
                
                -- NULO Y ESPACIO P_REPORTE
                IF (PKG_FUNCIONES.FN_NULOS(P_REPORTE) = 1 OR PKG_FUNCIONES.FN_ESPACIOS(P_REPORTE) = 1 OR P_REPORTE < 0 OR P_REPORTE > 2) THEN
                    V_REPORTE := 1;
                END IF;                    
                
                V_COMMAND_FIN := V_COMMAND_IN || 'ANIO = :VALOR_ANIO AND (MES BETWEEN 1 AND :VALOR_MES)';  -- SE AGREGA EL FILTRO ANIO Y TODOS LOS MESES
                
                -- EN CASO EL PARAMETRO MES SEA DIFERENTE A CERO
                IF (P_MES > 0 AND P_MES <= 12) THEN
                    V_COMMAND_FIN := V_COMMAND_IN || 'ANIO = :VALOR_ANIO AND MES = :VALOR_MES';  -- SE AGREGA EL FILTRO ANIO Y EL MES ELEGIDO  
                END IF;
                
                -- SE OBTIENE LA FECHA MINIMA Y FECHA MAXIMA SEGUN EL ANIO Y MES
                EXECUTE IMMEDIATE (V_COMMAND_FIN) -- EJECUTA LA CONSULTA DINAMICA
                INTO V_FECHA_MIN, V_FECHA_MAX -- GUARDA LOS VALORES DE LA CONSULTA DINAMICA EN LAS VARIABLES DECLARADAS
                USING V_ANIO, V_MES; -- UTILIZA LAS VARIABLES DECLARADAS COMO FILTRO PARA LA CONSULTA DINAMICA
                
                -- TRUNCATE DE LOS REGISTROS DE LA TABLA TEMPORAL (SESION ACTIVA)
                EXECUTE IMMEDIATE ('TRUNCATE TABLE T_TMP_CANCION_REPRO');
                EXECUTE IMMEDIATE ('TRUNCATE TABLE T_TMP_CAN_ART_REPRO_RANK');
                
                -- SE ALOJA DATOS EN LA TABLA TEMPORAL
                INSERT INTO T_TMP_CANCION_REPRO
                SELECT  ID_CANCION_REPRO,
                        ID_CANCION,
                        TO_CHAR(FECHA,'YYYY'),
                        TO_CHAR(FECHA,'MM')
                FROM    T_CANCION_REPRO
                WHERE   FECHA BETWEEN V_FECHA_MIN AND V_FECHA_MAX;
                
                -------- INICIO DE PROCESO DE CONSULTAS DINAMICAS
                V_COLUMN := 'ID_CANCION';  
                V_COMMAND_RANK_2 := 'FROM T_TMP_CANCION_REPRO GROUP BY ANIO,MES,ID_CANCION';
                V_COMMAND_CUR := 'SELECT  C_RANK.ANIO,
                                            C_RANK.MES,
                                            CAN.CANCION,
                                            ART.ARTISTA,
                                            C_RANK.REPRODUCCIONES,
                                            C_RANK.RANKING
                                    FROM    T_TMP_CAN_ART_REPRO_RANK C_RANK
                                    JOIN    T_CANCION CAN ON C_RANK.ID_CAN_ART = CAN.ID_CANCION 
                                    JOIN    T_ARTISTA ART ON CAN.ID_ARTISTA = ART.ID_ARTISTA ';
                
                V_COMMAND_CUR_WHERE := 'WHERE C_RANK.RANKING <= ' || V_TOP || 'ORDER BY C_RANK.ANIO ASC, C_RANK.MES ASC, C_RANK.RANKING';
                
                IF (P_REPORTE = 2) THEN
                    V_COLUMN := 'ID_ARTISTA';
                    V_COMMAND_RANK_2 := 'FROM (SELECT TMP.*, CAN.ID_ARTISTA FROM T_TMP_CANCION_REPRO TMP JOIN T_CANCION CAN ON CAN.ID_CANCION = TMP.ID_CANCION) A GROUP BY ANIO,MES,ID_ARTISTA';
                    V_COMMAND_CUR := 'SELECT  C_RANK.ANIO,
                                                C_RANK.MES,
                                                ART.ARTISTA,
                                                C_RANK.REPRODUCCIONES,
                                                C_RANK.RANKING
                                        FROM    T_TMP_CAN_ART_REPRO_RANK C_RANK 
                                        JOIN    T_ARTISTA ART ON C_RANK.ID_CAN_ART = ART.ID_ARTISTA ';               
                END IF;
                
                V_COMMAND_RANK := 'INSERT INTO T_TMP_CAN_ART_REPRO_RANK
                                    SELECT  ANIO,
                                            MES,'
                                            || V_COLUMN ||',
                                            COUNT(ID_CANCION_REPRO),
                                            DENSE_RANK() OVER(PARTITION BY ANIO,MES ORDER BY COUNT(ID_CANCION_REPRO) DESC) '
                                    || 
                                    V_COMMAND_RANK_2;   
                                    
                EXECUTE IMMEDIATE (V_COMMAND_RANK);
                
                V_COMMAND_CUR := V_COMMAND_CUR || V_COMMAND_CUR_WHERE;
                
                OPEN TRC_REPORTE FOR V_COMMAND_CUR; -- CURSOR QUE EJECUTA CONSULTA DINAMICA SIN NECESIDAD DE USAR EXECUTE IMMEDIATE
                
        END PRC_TOP_CAN_ART_ANIO_MES;

END PKG_REPORTES;
/