--transaccion donde actualiza el stock
CREATE OR REPLACE TRIGGER inventario.actualizar_stock AFTER INSERT ON inventario.boleta FOR EACH ROW
DECLARE

BEGIN

  UPDATE inventario.control
  SET int_salida = int_salida -1,
    int_stock =(int_existini + int_entrada) -int_salida
  WHERE chr_idproducto = inventario.boleta.chr_idproducto;

END;

