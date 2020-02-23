
create or replace PACKAGE PKG_DEMO AS 

  type reg is record ( 
    nombre emp.ename%type, 
    salario emp.sal%type 
  );

END PKG_DEMO;
/


create or replace procedure SCOTT.GET_EMP2( cod emp.empno%type ) 
is 
  r pkg_demo.reg; 
begin 

  select ename, sal into r 
  from emp where empno = cod; 

  dbms_output.put_line( 'Nombre: ' || r.nombre ); 
  dbms_output.put_line( 'Salario: ' || r.salario ); 

end; 
/


create or replace procedure SCOTT.GET_EMP2
( cod emp.empno%type, rpta out pkg_demo.reg ) 
is 

begin 

  select ename, sal into rpta 
  from emp where empno = cod; 

end; 
/



set serveroutput on

declare 
  r pkg_demo.reg;
begin
  SCOTT.GET_EMP2(7654, r);
  dbms_output.put_line( 'Nombre: ' || r.nombre ); 
  dbms_output.put_line( 'Salario: ' || r.salario ); 
end;
/


create or replace function SCOTT.fn_GET_EMP2
( cod emp.empno%type )
return pkg_demo.reg 
is 
  rpta pkg_demo.reg;
begin 

  select ename, sal into rpta 
  from emp where empno = cod; 
  return rpta;
  
end; 
/


declare 
  r pkg_demo.reg;
begin
  r := SCOTT.fn_GET_EMP2(7654);
  dbms_output.put_line( 'Nombre: ' || r.nombre ); 
  dbms_output.put_line( 'Salario: ' || r.salario ); 
end;
/


select SCOTT.fn_GET_EMP2(7654) from dual;


