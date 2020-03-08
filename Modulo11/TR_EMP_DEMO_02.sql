

CREATE OR REPLACE TRIGGER SCOTT.TR_EMP_DEMO_02 
AFTER INSERT OR DELETE OR UPDATE ON scott.emp 
BEGIN 
  if inserting then 
    dbms_output.put_line( 'nuevo empleado se ha insertado' ); 
  Elsif updating then 
    dbms_output.put_line( 'un empleado se ha modificado' ); 
  Elsif deleting then 
    dbms_output.put_line( 'un empleado se ha eliminado' ); 
  end if; 
END TR_EMP_DEMO_02;
/


insert into scott.emp(empno,ename,sal)
values(8888,'PEPE',6567);

UPDATE SCOTT.EMP 
SET SAL = 7777
WHERE EMPNO = 8888;


DELETE FROM SCOTT.EMP WHERE EMPNO = 8888;


CREATE OR REPLACE TRIGGER SCOTT.TR_EMP_DEMO_02 
AFTER INSERT OR DELETE OR UPDATE ON scott.emp 
BEGIN 
  if inserting then 
    dbms_output.put_line( 'nuevo empleado se ha insertado' ); 
  Elsif updating then 
    dbms_output.put_line( 'un empleado se ha modificado' ); 
  Elsif deleting then 
    dbms_output.put_line( 'un empleado se ha eliminado' ); 
  end if; 
  if updating('SAL') then 
    dbms_output.put_line( 'La columna SAL se ha modificado.' );
  end if;
END TR_EMP_DEMO_02;
/


select * from scott.emp;

UPDATE SCOTT.EMP 
SET JOB = 'MANAGER'
WHERE EMPNO = 5555;

UPDATE SCOTT.EMP 
SET SAL = SAL + 100
WHERE EMPNO = 5555;



alter trigger SCOTT.TR_EMP_DEMO_02 disable;




