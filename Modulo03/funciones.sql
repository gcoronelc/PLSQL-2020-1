-- Funciones
-- Por defecto los paránetros con tipo IN

create or replace 
function SCOTT.FN_SUMA(p_n1 number, p_n2 number)
return number
is
  v_suma number;
begin
  v_suma := p_n1 + p_n2;
  return v_suma;
end;
/

select SCOTT.FN_SUMA(56,43) suma from dual;


set serveroutput on

declare
  v_suma number;
begin
  v_suma := SCOTT.FN_SUMA(56,43);
  dbms_output.put_line('Suma: ' || v_suma);
end;
/











