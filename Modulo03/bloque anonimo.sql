-- Trabajar con PL/SQL
/*
  - Bloque anónimo
  - Funciones
  - Procedimientos
  - Paquetes
  - Triggers
*/

-- Activar salidas

set serveroutput on

-- Bloque anónimo

declare
  n1 number;
  n2 number;
  suma number;
begin
  -- Datos
  n1 := 56;
  n2 := 89;
  -- PRoceso
  suma := n1 + n2;
  -- Reporte
  DBMS_OUTPUT.PUT_LINE('N1: ' || n1);
  DBMS_OUTPUT.PUT_LINE('N2: ' || n2);
  DBMS_OUTPUT.PUT_LINE('Suma: ' || suma);
end;
/




