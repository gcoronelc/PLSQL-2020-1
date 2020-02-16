
CREATE OR REPLACE PROCEDURE SCOTT.SP_TEST_NOCOPY 
( p_raise IN BOOLEAN, p_dato OUT NOCOPY VARCHAR2 ) 
IS 
  excep1 EXCEPTION; 
BEGIN 
  p_dato := 'Alianza Campeon'; 
  IF p_raise = TRUE THEN 
    RAISE excep1; 
  ELSE 
    RETURN; 
  END IF; 
END; 
/


-- Prueba 01
VARIABLE V_dato varchar2(1000)
begin
  :v_dato := 'Sporting Cristal';
  SCOTT.SP_TEST_NOCOPY( false, :v_dato );
end;
/
PRINT v_dato

-- Prueba 02
VARIABLE V_dato varchar2(1000)
begin
  :v_dato := 'Real Madrid';
  SCOTT.SP_TEST_NOCOPY( true, :v_dato );
exception
  when others then
    null;
end;
/
PRINT v_dato


