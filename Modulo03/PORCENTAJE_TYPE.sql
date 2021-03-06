
CREATE OR REPLACE FUNCTION EUREKA.FN_GET_ESTADO
( P_CUENTA EUREKA.cuenta.chr_cuencodigo%TYPE )
RETURN EUREKA.cuenta.vch_cuenestado%TYPE
IS
  V_ESTADO EUREKA.cuenta.vch_cuenestado%TYPE;
BEGIN
  SELECT vch_cuenestado INTO V_ESTADO
  FROM EUREKA.CUENTA 
  WHERE chr_cuencodigo = p_cuenta;
  RETURN v_estado;
EXCEPTION
  WHEN OTHERS THEN
    RETURN 'NONE';
END;
/

SELECT EUREKA.FN_GET_ESTADO('00300002') ESTADO
FROM DUAL;

