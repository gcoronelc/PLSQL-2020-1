-- matrices asociativas

DECLARE 
  TYPE ARRAY_NOTAS IS TABLE OF NUMBER  
  INDEX BY BINARY_INTEGER; 
  NOTAS ARRAY_NOTAS; 
BEGIN 
  -- CARGAR NOTAS 
  NOTAS(1) := 20; 
  NOTAS(2) := 18; 
  NOTAS(3) := 15; 
  NOTAS(4) := 17; 
  NOTAS(20) := 10; 
  -- MOSTRAR NOTAS 
  FOR I IN 1..NOTAS.COUNT LOOP 
    DBMS_OUTPUT.PUT_LINE('NOTA ' || I || ': ' || NOTAS(I)); 
  END LOOP; 
END; 
/


DECLARE 
  TYPE ARRAY_NOTAS IS TABLE OF NUMBER  
  INDEX BY BINARY_INTEGER; 
  NOTAS ARRAY_NOTAS; 
  indice number;
BEGIN 
  -- CARGAR NOTAS 
  NOTAS(1) := 20; 
  NOTAS(30) := 18; 
  NOTAS(8) := 15; 
  NOTAS(2) := 17; 
  NOTAS(20) := 10; 
  -- PROPIEDADES
  dbms_output.put_line('PROPIEDADES');
  dbms_output.put_line('COUNT: ' || NOTAS.COUNT);
  dbms_output.put_line('FIRST: ' || NOTAS.FIRST);
  dbms_output.put_line('LAST: ' || NOTAS.LAST);
  dbms_output.put_line('LIMIT: ' || NOTAS.LIMIT);   
  -- Bucle
  indice := notas.first;
  while( indice <= notas.last ) loop
    DBMS_OUTPUT.PUT_LINE('NOTA ' || indice || ': ' || NOTAS(indice)); 
    indice := notas.next(indice);
  end loop;
END; 
/


