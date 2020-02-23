-- varray

DECLARE 
  -- Definimos los tipos de datos 
  TYPE AlumnosArray IS VARRAY(15) OF VARCHAR2(100); 
  TYPE NotasArray IS VARRAY(15) OF NUMBER(4); 
  -- Definiendo las variables 
  alumnos AlumnosArray; 
  notas   NotasArray; 
BEGIN 
  -- Creando los arreglos 
  alumnos := AlumnosArray('Gustavo','Lucero','Ricardo','Andrea','Laura'); 
  notas := NotasArray(20,18,16,10,15); 
  -- Propiedades
  dbms_output.put_line('PROPIEDADES');
  dbms_output.put_line('COUNT: ' || alumnos.COUNT);
  dbms_output.put_line('FIRST: ' || alumnos.FIRST);
  dbms_output.put_line('LAST: ' || alumnos.LAST);
  dbms_output.put_line('LIMIT: ' || alumnos.LIMIT);
  -- Agregar un nuevo elemento
  alumnos.extend;
  alumnos(alumnos.last) := 'Karla';
  notas.extend;
  notas(notas.last) := 18;
  -- Propiedades
  dbms_output.put_line('PROPIEDADES');
  dbms_output.put_line('COUNT: ' || alumnos.COUNT);
  dbms_output.put_line('FIRST: ' || alumnos.FIRST);
  dbms_output.put_line('LAST: ' || alumnos.LAST);
  dbms_output.put_line('LIMIT: ' || alumnos.LIMIT);
  -- Mostrando los arreglos 
  FOR i IN 1 .. alumnos.count LOOP 
    dbms_output.PUT_LINE( alumnos(i) || ' - ' || notas(i) ); 
  END LOOP; 
END;
/



DECLARE 
  -- Definimos los tipos de datos 
  TYPE VARRAY_EMPLEADOS IS VARRAY(5000) OF HR.EMPLOYEES%ROWTYPE; 
  -- Definiendo las variables 
  V_EMPLEADOS VARRAY_EMPLEADOS; 
  V_CONT NUMBER(8); 
BEGIN 
  V_EMPLEADOS := VARRAY_EMPLEADOS(); 
  DBMS_OUTPUT.PUT_LINE('TAMAÑO INICIAL: ' || V_EMPLEADOS.COUNT); 
  FOR REC IN (SELECT * FROM HR.EMPLOYEES) LOOP 
    V_EMPLEADOS.EXTEND; 
    V_CONT := V_EMPLEADOS.COUNT; 
    V_EMPLEADOS(V_CONT) := REC; 
  END LOOP; 
  DBMS_OUTPUT.PUT_LINE('TAMAÑO FINAL: ' || V_EMPLEADOS.COUNT); 
  FOR I IN V_EMPLEADOS.FIRST..V_EMPLEADOS.LAST LOOP 
    DBMS_OUTPUT.PUT_LINE( I || '.- ' || V_EMPLEADOS(I).FIRST_NAME); 
  END LOOP; 
END;
/


