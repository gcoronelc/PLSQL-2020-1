create or replace procedure SCOTT.GET_EMP( cod emp.empno%type ) 
is 
  type reg is record ( 
    nombre emp.ename%type, 
    salario emp.sal%type 
  ); 
  r reg; 
begin 

  select ename, sal into r 
  from emp where empno = cod; 

  dbms_output.put_line( 'Nombre: ' || r.nombre ); 
  dbms_output.put_line( 'Salario: ' || r.salario ); 

end; 
/


SELECT * FROM SCOTT.EMP;

CALL SCOTT.GET_EMP(7654);