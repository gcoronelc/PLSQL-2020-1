CREATE OR REPLACE PACKAGE inventario.producto_crud IS PROCEDURE p_agregar(id_prod producto.chr_idproducto%TYPE,   nom_prod producto.vch_producto%TYPE,   descrip_prod producto.vch_descripcion%TYPE,   idcat_prod producto.chr_idcategoria%TYPE,   prec_prod producto.dec_precio%TYPE);

  PROCEDURE p_eliminar(id_prod producto.chr_idproducto%TYPE);

  PROCEDURE p_modificar(nom_prod producto.vch_producto%TYPE,   descrip_prod producto.vch_descripcion%TYPE,   idcat_prod producto.chr_idcategoria%TYPE,   prec_prod producto.dec_precio%TYPE,   id_prod producto.chr_idproducto%TYPE);

  PROCEDURE p_consulta(nom_prod producto.vch_producto%TYPE);
END;
/

 --cuerpo del package
CREATE OR REPLACE PACKAGE BODY inventario.producto_crud IS 
--agregar
  PROCEDURE p_agregar(id_prod producto.chr_idproducto%TYPE,   nom_prod producto.vch_producto%TYPE,   
  descrip_prod producto.vch_descripcion%TYPE,   idcat_prod producto.chr_idcategoria%TYPE,   
  prec_prod producto.dec_precio%TYPE) IS
  BEGIN
    INSERT
    INTO producto
    VALUES(id_prod,   nom_prod,   descrip_prod,   idcat_prod,   prec_prod);
    DBMS_OUTPUT.PUT_LINE('Se agrego producto');
  END p_agregar;

  --eliminar
  PROCEDURE p_eliminar(id_prod producto.chr_idproducto%TYPE) IS
  BEGIN
    DELETE FROM producto
    WHERE chr_idproducto = id_prod;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Se elimino producto');
  EXCEPTION
  WHEN others THEN
    ROLLBACK;
    DBMS_OUTPUT.PUT_LINE('Se cancelo la eliminacion del ID:' || id_prod);
  END p_eliminar;

  --actualizar
  PROCEDURE p_modificar(nom_prod producto.vch_producto%TYPE,   descrip_prod producto.vch_descripcion%TYPE,   idcat_prod producto.chr_idcategoria%TYPE,   prec_prod producto.dec_precio%TYPE,   id_prod producto.chr_idproducto%TYPE) IS
  BEGIN

    UPDATE producto
    SET vch_producto = nom_prod,
      vch_descripcion = descrip_prod,
      chr_idcategoria = idcat_prod,
      dec_precio = prec_prod
    WHERE chr_idproducto = id_prod;
    DBMS_OUTPUT.PUT_LINE('Se actualizo producto');

  EXCEPTION
  WHEN others THEN
    ROLLBACK;
    DBMS_OUTPUT.PUT_LINE('No se actualizo');
  END p_modificar;

  --consulta
  PROCEDURE p_consulta(nom_prod producto.vch_producto%TYPE) IS
  id_prod producto.chr_idproducto%TYPE;
  descrip_prod producto.vch_descripcion%TYPE;
  prec_prod producto.dec_precio%TYPE;
  BEGIN
    SELECT chr_idproducto,
      vch_descripcion,
      dec_precio
    INTO id_prod,
      descrip_prod,
      prec_prod
    FROM producto
    WHERE vch_producto = nom_prod;
    DBMS_OUTPUT.PUT_LINE('Id producto: ' || id_prod);
    DBMS_OUTPUT.PUT_LINE('Descripcion: ' || descrip_prod);
    DBMS_OUTPUT.PUT_LINE('precio: ' || prec_prod);
    EXCEPTION
  WHEN others THEN
    DBMS_OUTPUT.PUT_LINE('No se encontro producto');
  END p_consulta;
END;
/

set serveroutput on

SELECT * FROM INVENTARIO.PRODUCTO ORDER BY CHR_IDPRODUCTO;

--AGREGAR
begin
inventario.producto_crud.p_agregar('P06','SUPER MARIO BROS','JUEGO DE AVENTURA','C01',60);
end;

--ACTUALIZAR
begin
inventario.producto_crud.p_modificar('SUPER MARIO BROS','JUEGO DE AVENTURA','C01',50,'P06');
end;

--ELIMINAR
begin
inventario.producto_crud.p_eliminar('P06');
end;

--CONSULTA
begin
inventario.producto_crud.p_consulta('SUPER MARIO BROS');
end;





