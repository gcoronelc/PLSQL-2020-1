-- BUCLE LOOP


SET SERVEROUTPUT ON

DECLARE
  V_CONT NUMBER := 0;
BEGIN
  LOOP
    V_CONT := V_CONT + 1;
    DBMS_OUTPUT.PUT_LINE(V_CONT || '.- TODOS POR EL PERU.');
    EXIT WHEN (V_CONT = 10);
  END LOOP;
END;
/


create or replace 
function SCOTT.FACTORIAL (n number) 
return number 
is 
  f number := 1; 
  cont number := n; 
begin 
  loop 
    f := f * cont; 
    cont := cont - 1; 
    exit when (cont=0); 
  end loop; 
  return f; 
end;
/

SELECT SCOTT.FACTORIAL(6) FROM DUAL;

-- Tiene probles, por ejemplo el factorial de 0.

SELECT SCOTT.FACTORIAL(0) FROM DUAL;
