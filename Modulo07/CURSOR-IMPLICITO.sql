-- CURSOR IMPLICITO

create or replace procedure SCOTT.UPDATE_SAL
(cod number, delta number) 
is 
begin 
  update emp 
    set sal = sal + delta 
    where empno = cod; 
  if sql%notfound then 
    dbms_output.put_line('no existe'); 
  else 
    commit; 
    dbms_output.put_line('proceso ok'); 
  end if; 
end;
/

SELECT * FROM SCOTT.EMP;

CALL SCOTT.UPDATE_SAL(7764, 100);


CALL SCOTT.UPDATE_SAL(7369, 100);
