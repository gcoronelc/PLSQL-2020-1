
CREATE OR REPLACE TRIGGER SCOTT.TR_EMP_DEMO_01 
BEFORE UPDATE ON SCOTT.EMP 
BEGIN 
  DBMS_OUTPUT.PUT_LINE('Algo se ha actualizado.');   
END;
/


set serveroutput on

select * from scott.emp;

UPDATE SCOTT.EMP 
SET JOB = 'SALESMAN'
WHERE empno = 5555;

COMMIT;


UPDATE SCOTT.EMP 
SET SAL = SAL * 1.50
WHERE deptno = 30;

ROLLBACK;


CREATE OR REPLACE TRIGGER SCOTT.TR_EMP_DEMO_01 
BEFORE UPDATE ON SCOTT.EMP 
FOR EACH ROW -- Una vez por fila
BEGIN 
  DBMS_OUTPUT.PUT_LINE('Algo se ha actualizado.'); 
  DBMS_OUTPUT.PUT_LINE( :old.empno || ': ' || :old.sal || ' - ' || :new.sal); 
END;
/


UPDATE SCOTT.EMP 
SET SAL = SAL * 1.50
WHERE deptno = 30;

ROLLBACK;

alter trigger SCOTT.TR_EMP_DEMO_01 disable;






