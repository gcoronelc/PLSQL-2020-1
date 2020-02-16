
/*
PARAMETROS
  P_CUENTA : Cuenta de quien consultar el saldo
  P_SALDO  : Saldo de la cuenta.
*/
CREATE OR REPLACE PROCEDURE 
EUREKA.SP_GET_SALDO(
  P_CUENTA IN VARCHAR2,
  P_SALDO  OUT NUMBER
)
IS
BEGIN
  SELECT dec_cuensaldo INTO p_saldo
  FROM EUREKA.cuenta
  WHERE chr_cuencodigo = P_CUENTA;
EXCEPTION
  WHEN OTHERS THEN
    dbms_output.put_line('No existe la cuenta: ' || p_cuenta);
END;
/

SET SERVEROUTPUT ON

VARIABLE V_SALDO number
EXECUTE EUREKA.SP_GET_SALDO( '00100002', :V_SALDO );
PRINT V_SALDO


