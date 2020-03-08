SET SERVEROUTPUT ON;
DECLARE
    CURSOR cur_secuencias IS 
        SELECT 
            NOM_SECUENCIA, NOM_TABLA, COL_PK_TABLA
        FROM CONTROL_SECUENCIAS;
    v_row_secuencia cur_secuencias%ROWTYPE;
    v_stm_execute VARCHAR(1000);
    v_max_id NUMBER;
    v_cur_val NUMBER;
    v_estado_finalizado CONTROL_SECUENCIAS.EST_ACTUALIZA%TYPE := 'FINALIZADO';
    v_cont_loop NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('INICIO PROCESO');
    
    OPEN cur_secuencias;
    LOOP
        FETCH cur_secuencias INTO v_row_secuencia;
        EXIT WHEN cur_secuencias%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('=======================================================');
        v_cont_loop := v_cont_loop + 1;
        DBMS_OUTPUT.PUT_LINE('INICIO ACTUALIZACION SECUENCIA ::: ' || v_row_secuencia.NOM_SECUENCIA || ' # SECUENCIA ::: ' || v_cont_loop);
        BEGIN
            v_stm_execute := 'SELECT NVL(MAX(' || v_row_secuencia.COL_PK_TABLA || '), 0)FROM ' || v_row_secuencia.NOM_TABLA || ' WHERE ' || v_row_secuencia.COL_PK_TABLA || ' <> 999999 ';
            DBMS_OUTPUT.PUT_LINE(v_stm_execute);
            EXECUTE IMMEDIATE v_stm_execute INTO v_max_id;
            DBMS_OUTPUT.PUT_LINE('ID MAX TABLA ' || v_row_secuencia.NOM_TABLA || ' ::: ' || v_max_id);
            
            IF v_max_id > 0 THEN
                LOOP
                    v_stm_execute := 'SELECT ' || v_row_secuencia.NOM_SECUENCIA || '.NEXTVAL FROM DUAL';
                    EXECUTE IMMEDIATE v_stm_execute INTO v_cur_val;
                    EXIT WHEN v_cur_val >= v_max_id;
                END LOOP;
                
                DBMS_OUTPUT.PUT_LINE('SECUENCIA ' || v_row_secuencia.NOM_SECUENCIA || ' actualizado a ::: ' || v_cur_val);
            END IF;
            
            UPDATE CONTROL_SECUENCIAS
            SET
                EST_ACTUALIZA = v_estado_finalizado,
                FEC_ACTUALIZA = SYSDATE
            WHERE NOM_SECUENCIA = v_row_secuencia.NOM_SECUENCIA;
            COMMIT;
            
            DBMS_OUTPUT.PUT_LINE('FIN ACTUALIZACION SECUENCIA ::: ' || v_row_secuencia.NOM_SECUENCIA);
            DBMS_OUTPUT.PUT_LINE('=======================================================');
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE(chr(10) || '********** ERROR AL EJECUTAR EL BLOQUE **********');
                DBMS_OUTPUT.PUT_LINE('CODERROR [' || SQLCODE || ']');
                DBMS_OUTPUT.PUT_LINE('MSGERROR [' || SQLERRM || ']');
                DBMS_OUTPUT.PUT_LINE('LINEA ERROR [' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || ']');
                DBMS_OUTPUT.PUT_LINE('=======================================================');
        END;
        
    END LOOP;
    
    CLOSE cur_secuencias;
    
    DBMS_OUTPUT.PUT_LINE('FIN DE PROCESO');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(chr(10) || '********** ERROR AL EJECUTAR EL BLOQUE **********');
        DBMS_OUTPUT.PUT_LINE('CODERROR [' || SQLCODE || ']');
        DBMS_OUTPUT.PUT_LINE('MSGERROR [' || SQLERRM || ']');
        DBMS_OUTPUT.PUT_LINE('LINEA ERROR [' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || ']');
END;
/
