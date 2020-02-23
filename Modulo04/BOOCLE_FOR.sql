-- BUCLE WHILE


SET SERVEROUTPUT ON

DECLARE
  X NUMBER := 1000;
BEGIN
  DBMS_OUTPUT.PUT_LINE('X = ' || X);
  FOR X IN 1 .. 10 LOOP
    DBMS_OUTPUT.PUT_LINE(X || '.- PL/SQL ME DERA MAS PLATA.');
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('X = ' || X);
END;
/


create or replace function scott.factorial ( n number ) return number 
is 
  f number := 1; 
begin 
  if( n < 0 ) then
    return 0;
  end if;
  for k in 1 .. n loop 
    f := f * k; 
  end loop; 
  return f; 
end; 
/


select scott.factorial(-3) from dual;



create or replace procedure scott.sp_tabla_multiplicar ( n number ) 
is 
  cad varchar2(30); 
begin 
  for k in reverse 1 .. 12 loop 
    cad := n || ' x ' || k || ' = ' || (n*k); 
    dbms_output.put_line( cad ); 
  end loop; 
end; 
/

call scott.sp_tabla_multiplicar ( 6 );




