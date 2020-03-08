CREATE OR REPLACE PROCEDURE MG.SP_ACTUALIZAR_FLAG_TEST (P_RESULTADO OUT NUMBER)
IS
        TYPE T_ARR_REC IS TABLE OF MG.T_USUARIO%ROWTYPE;
        V_LISTA T_ARR_REC;
BEGIN
        SELECT  *
        BULK COLLECT INTO V_LISTA        
        FROM    MG.T_USUARIO
        WHERE   ID_USUARIO > 500
        AND     ID_USUARIO < 700;
        
        FOR I IN V_LISTA.FIRST..V_LISTA.LAST
        LOOP
                UPDATE  MG.T_USUARIO
                SET     FLAG = 0,
                        FECHA_BAJA = SYSDATE
                WHERE   ID_USUARIO = V_LISTA(I).ID_USUARIO;
                
                UPDATE  MG.T_PERSONA
                SET     FLAG = 0
                WHERE   ID_PERSONA = V_LISTA(I).ID_PERSONA;
                COMMIT;
                
        END LOOP;        
        
        P_RESULTADO := 1;
EXCEPTION 
        WHEN OTHERS THEN
            P_RESULTADO := 0;
END;
/

VAR RESULTADO NUMBER;
EXEC MG.SP_ACTUALIZAR_FLAG_TEST(:RESULTADO);
PRINT RESULTADO;
