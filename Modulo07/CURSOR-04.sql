
-- BUCLE FOR


DECLARE 
  CURSOR C_DEMO IS 
    SELECT * FROM SCOTT.EMP;
BEGIN
  
  FOR R IN C_DEMO LOOP
    dbms_output.put_line( R.EMPNO || ' - ' || R.ENAME || ' - ' || R.SAL);
  END LOOP;

END;
/



-- BUCLE IMPLICITO


BEGIN
  
  FOR R IN (SELECT * FROM SCOTT.EMP) LOOP
    dbms_output.put_line( R.EMPNO || ' - ' || R.ENAME || ' - ' || R.SAL);
  END LOOP;

END;
/














