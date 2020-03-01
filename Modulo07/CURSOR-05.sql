
CREATE OR REPLACE PROCEDURE EUREKA.SP_GET_SALDOS
( P_CURSOR OUT SYS_REFCURSOR )
AS
BEGIN
  open P_CURSOR for
  WITH 
  V1 AS (
    SELECT 
      CHR_SUCUCODIGO SUCUCODIGO,
      SUM(CASE WHEN CHR_MONECODIGO='01' THEN DEC_CUENSALDO ELSE 0 END) SALDO_SOLES,
      SUM(CASE WHEN CHR_MONECODIGO='02' THEN DEC_CUENSALDO ELSE 0 END) SALDO_DOLARES
    FROM EUREKA.CUENTA
    GROUP BY CHR_SUCUCODIGO
  )
  SELECT 
    v1.sucucodigo, S.VCH_SUCUNOMBRE SUCUNOMBRE,
    v1.saldo_soles, v1.saldo_dolares
  FROM EUREKA.SUCURSAL S
  JOIN V1 ON S.CHR_SUCUCODIGO = v1.sucucodigo;
END;
/



-- Prueba utilizando variables enlazadas

VARIABLE V_MOV REFCURSOR
EXEC EUREKA.SP_GET_SALDOS(:V_MOV);
PRINT V_MOV




