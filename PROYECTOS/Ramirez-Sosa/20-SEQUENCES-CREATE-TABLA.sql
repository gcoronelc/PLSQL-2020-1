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
    END IF;
    
    EXECUTE IMMEDIATE
    'CREATE TABLE ' || v_tabla_nombre || q'{(
        NOM_SECUENCIA VARCHAR2(50), 
        NOM_TABLA VARCHAR2(50), 
        COL_PK_TABLA VARCHAR2(50),
        EST_ACTUALIZA VARCHAR2(20) DEFAULT 'PENDIENTE',
        FEC_ACTUALIZA TIMESTAMP(6),
        EST_INICIALIZA VARCHAR2(20) DEFAULT 'PENDIENTE',
        FEC_INICIALIZA TIMESTAMP(6)
    )}';
    
    EXECUTE IMMEDIATE 'COMMENT ON TABLE ' || v_tabla_nombre || ' IS ' || q'{'Tabla usada para la actualización de las secuencias'}';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN ' || v_tabla_nombre || '.NOM_SECUENCIA IS ' || q'{'Nombre de la secuencia asociada al id de la tabla'}';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN ' || v_tabla_nombre || '.NOM_TABLA IS ' || q'{'Nombre de la tabla'}';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN ' || v_tabla_nombre || '.COL_PK_TABLA IS ' || q'{'Nombre de la columna que es PK de la tabla'}';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN ' || v_tabla_nombre || '.EST_ACTUALIZA IS ' || q'{'Estado de la actualización de la secuencia'}';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN ' || v_tabla_nombre || '.FEC_ACTUALIZA IS ' || q'{'Fecha de la actualización de la secuencia'}';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN ' || v_tabla_nombre || '.EST_INICIALIZA IS ' || q'{'Estado de la inicialización de la secuencia'}';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN ' || v_tabla_nombre || '.FEC_INICIALIZA IS ' || q'{'Fecha de la inicialización de la secuencia'}';
    
    DBMS_OUTPUT.PUT_LINE('SE CREO TABLA ' || v_tabla_nombre);
    DBMS_OUTPUT.PUT_LINE('FIN DE PROCESO');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(chr(10) || '********** ERROR AL EJECUTAR EL BLOQUE **********');
        DBMS_OUTPUT.PUT_LINE('CODERROR [' || SQLCODE || ']');
        DBMS_OUTPUT.PUT_LINE('MSGERROR [' || SQLERRM || ']');
        DBMS_OUTPUT.PUT_LINE('LINEA ERROR [' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || ']');
END;
/