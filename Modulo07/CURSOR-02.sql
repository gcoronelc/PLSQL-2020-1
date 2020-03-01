
-- BUCLE SIMPLE

DECLARE 
  CURSOR C_DEMO IS 
    SELECT * FROM SCOTT.EMP;
  V_REG SCOTT.EMP%ROWTYPE;
BEGIN
  OPEN C_DEMO;
  
  LOOP
    FETCH C_DEMO INTO V_REG;
    EXIT WHEN C_DEMO%NOTFOUND;
    dbms_output.put_line( V_REG.EMPNO || ' - ' || V_REG.ENAME || ' - ' || V_REG.SAL);
  END LOOP;
  
  CLOSE C_DEMO;
END;
/

