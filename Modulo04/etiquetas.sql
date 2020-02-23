-- ETIQUETAS

BEGIN
  DBMS_OUTPUT.PUT_LINE('DATO 1');
  GOTO FIN;
  DBMS_OUTPUT.PUT_LINE('DATO 2');
  <<FIN>>
  DBMS_OUTPUT.PUT_LINE('DATO 3');
END;
/


-- Este código da error.
DECLARE
  V_CONT NUMBER;
BEGIN
  DBMS_OUTPUT.PUT_LINE('DATO 1');
  GOTO FIN;
  IF( V_CONT = 10) THEN
    <<FIN>>
    DBMS_OUTPUT.PUT_LINE('DATO 2');
  END IF;
  DBMS_OUTPUT.PUT_LINE('DATO 3');
END;
/




begin
  ----------
  ----------
  <<etiqueta>>
  ----------
  ----------
exception
  when others then
    goto etiqueta;
end;
/




