
create or replace procedure scott.show_dep( cod dept.deptno%type ) 
is 
  r dept%rowtype; 
begin 

  select * into r 
  from dept where deptno = cod; 
  
  dbms_output.put_line('Codigo: ' || r.deptno); 
  dbms_output.put_line('Nombre: ' || r.dname); 
  dbms_output.put_line('Localización: ' || r.loc); 
  
end;
/


execute scott.show_dep(10); 

call scott.show_dep(10); 


