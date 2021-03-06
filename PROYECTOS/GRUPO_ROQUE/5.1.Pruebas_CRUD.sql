 
-- CONECTANDO CON EL USUARIO FOTO

CONNECT foto/foto

SET SERVEROUTPUT ON;

-- Prueba de Create/insercion en tabla 'sesion'

begin
 /*
 P_ID_USUARIO, P_FORMA_PAGO, P_ID_SEDE, 
 P_FECHA_REGISTRO, P_COMENTARIOS, P_ESTADO, 
 P_MONTO_PAGADO, P_ID_SESION, P_ID_CLIENTE, 
 P_ID_TEMATICA, P_ID_PAQUETE, P_FECHA_HORA_SESION, 
 P_MONTO_A_PAGAR, P_ESTADO_PAGO 
 */
 PKG_CRUD_SESION.CREATE_(1,'EFECTIVO',1,
						to_date('05/03/20', 'DD/MM/RR'),'','PENDIENTE',
						10,1,1,
						1,1,to_date('08/03/20', 'DD/MM/RR'),
						25,'PARCIAL'
						);
 /*
Exception
    When others Then
    DBMS_Output.Put_Line( 'ERROR' );
*/
end;
/

  
  
DECLARE
	V_REGISTRO PKG_CRUD_SESION.PKG_CRUD_SESION_REC;
begin
 /* P_ID_SESION */
 V_REGISTRO := PKG_CRUD_SESION.READ_(1);
 DBMS_Output.Put_Line('ESTADO => '||V_REGISTRO.ESTADO );
 DBMS_Output.Put_Line('FORMA PAGO => '||V_REGISTRO.FORMA_PAGO );
 DBMS_Output.Put_Line('MONTO_PAGADO => '||V_REGISTRO.MONTO_PAGADO );
 DBMS_Output.Put_Line('FECHA_SESION => '||V_REGISTRO.FECHA_HORA_SESION );
 DBMS_Output.Put_Line('FECHA_REGISTRO => '||V_REGISTRO.FECHA_REGISTRO );
 -- PRINT V_REGISTRO;
end;
/

SELECT * FROM SESION;

