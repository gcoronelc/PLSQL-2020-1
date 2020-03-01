SET SERVEROUTPUT ON

-- DEMO 01

DECLARE 
  CURSOR C_DEMO IS 
    SELECT EMPNO, ENAME FROM SCOTT.EMP;
  V_COD NUMBER;
  V_NAME VARCHAR2(100);
BEGIN
  OPEN C_DEMO;
  
  FETCH C_DEMO INTO V_COD, V_NAME;
  dbms_output.put_line( V_COD || ' - ' || V_NAME );
  
  FETCH C_DEMO INTO V_COD, V_NAME;
  dbms_output.put_line( V_COD || ' - ' || V_NAME );

  CLOSE C_DEMO;
END;
/


-- DEMO 02

DECLARE 
  CURSOR C_DEMO IS 
    SELECT * FROM SCOTT.EMP;
  V_REG SCOTT.EMP%ROWTYPE;
BEGIN
  OPEN C_DEMO;
  
  FETCH C_DEMO INTO V_REG;
  dbms_output.put_line( V_REG.EMPNO || ' - ' || V_REG.ENAME || ' - ' || V_REG.SAL);
  
  FETCH C_DEMO INTO V_REG;
  dbms_output.put_line( V_REG.EMPNO || ' - ' || V_REG.ENAME || ' - ' || V_REG.SAL);

  CLOSE C_DEMO;
END;
/
