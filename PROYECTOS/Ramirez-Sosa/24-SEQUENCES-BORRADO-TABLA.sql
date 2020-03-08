SET SERVEROUTPUT ON;
DECLARE
    v_tabla_nombre VARCHAR2(50) := 'CONTROL_SECUENCIAS';
    v_num_tablas_condi NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('INICIO PROCESO');
    SELECT COUNT(*) INTO v_num_tablas_condi FROM USER_TABLES WHERE TABLE_NAME = v_tabla_nombre;
    
    IF v_num_tablas_condi > 0 THEN
        DBMS_OUTPUT.PUT_LINE('EXISTE TABLA ' || v_tabla_nombre || ', SE ELIMINARA');
        EXECUTE IMMEDIATE 'DROP TABLE ' || v_tabla_nombre || ' PURGE';
        DBMS_OUTPUT.PUT_LINE('SE ELIMINO TABLA ' || v_tabla_nombre);
    ELSE
        DBMS_OUTPUT.PUT_LINE('NO EXISTE LA TABLA ' || v_tabla_nombre);
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('FIN DE PROCESO');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(chr(10) || '********** ERROR AL EJECUTAR EL BLOQUE **********');
        DBMS_OUTPUT.PUT_LINE('CODERROR [' || SQLCODE || ']');
        DBMS_OUTPUT.PUT_LINE('MSGERROR [' || SQLERRM || ']');
        DBMS_OUTPUT.PUT_LINE('LINEA ERROR [' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || ']');
END;
/