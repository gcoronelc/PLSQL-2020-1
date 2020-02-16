
create or replace procedure 
SCOTT.SP_SUMA(
  p_n1 IN number, 
  p_n2 IN number,
  P_suma OUT number
)
is
  v_suma number;
begin
  P_suma := p_n1 + p_n2;
end;
/

VARIABLE suma number
EXECUTE SCOTT.SP_SUMA( 12, 14, :suma );
PRINT suma





