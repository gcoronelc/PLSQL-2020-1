
--consulta stock
CREATE OR REPLACE
FUNCTION INVENTARIO.Obtener_stock(id_prod char) 
 RETURN NUMBER 
 IS
   stock NUMBER;
 BEGIN
        SELECT INT_STOCK INTO stock
        FROM CONTROL
        WHERE CHR_IDPRODUCTO = id_prod;
        return (stock);
 END;
/
 
set serveroutput on

--consulta stock
DECLARE
  stock NUMBER;
BEGIN
	stock := INVENTARIO.Obtener_stock('P01');
        DBMS_OUTPUT.PUT_LINE('Stock: '|| stock);

END;  
/