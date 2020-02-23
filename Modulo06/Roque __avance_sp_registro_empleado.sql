
create or replace procedure RECURSOS.registro_empleado
( 
  P_Codigo IN EMPLEADO.IDEMPLEADO%Type, 
  P_Apellido IN EMPLEADO.APELLIDO%Type,
  P_Nombre IN EMPLEADO.NOMBRE%Type,
  P_Fecingreso IN varchar2, 
  P_Email IN EMPLEADO.EMAIL%Type, 
  P_Telefono IN EMPLEADO.TELEFONO%Type,
  P_Idcargo IN EMPLEADO.IDCARGO%Type,
  P_Iddepartamento IN EMPLEADO.IDDEPARTAMENTO%Type,  
  P_Salario IN EMPLEADO.SUELDO%Type,
  Estado OUT NOCOPY NUMBER,
  Mensaje OUT NOCOPY VARCHAR2
) 
is 
  Cont Number; 
  Exp_null Exception;
  Exp_salario Exception;
  existe number := -1;
  sal_max number(12,2);
  sal_min number(12,2);
Begin 
  Mensaje := '';
  -- valido datos no null
  if P_Codigo is null then 
    Mensaje := Mensaje || 'Ingrese un Codigo. ';
  end if;
  if P_Apellido is null then 
    Mensaje := Mensaje || 'Ingrese un Apellido. '; 
  end if;
  if P_Nombre is null then 
    Mensaje := Mensaje || 'Ingrese un Nombre. '; 
  end if;
  if P_Salario is null then 
    Mensaje := Mensaje || 'Ingrese un Salario. ';
  end if;
  if P_Iddepartamento is null then 
    Mensaje := Mensaje || 'Ingrese un Departamento de Trabajo. ';
  end if;
  if P_Idcargo is null then 
    Mensaje := Mensaje || 'Ingrese un Puesto de Trabajo. ';
  end if;
  if( length(Mensaje) > 0 ) then
    Estado := -1;
    return;
  end if;
  -- valido el salario dentro del rango del departamento 
  select max(sueldo), min(sueldo) into sal_max, sal_min
  from recursos.empleado  where Iddepartamento = P_Iddepartamento;
  -- Agrego empleado
  insert into RECURSOS.EMPLEADO(IDEMPLEADO,APELLIDO,NOMBRE,
  FECINGRESO,EMAIL,TELEFONO,IDCARGO,IDDEPARTAMENTO,SUELDO) 
  values
    (P_Codigo,P_Apellido,P_Nombre,to_date(P_Fecingreso,'DD/MM/YYYY'),
    P_Email,P_Telefono,P_Idcargo,P_Iddepartamento,P_Salario);
  Commit; 
  Estado := 1;
  Mensaje := 'Proceso ok.';
Exception 
  When NO_DATA_FOUND Then 
    rollback;
    Estado := -1;
    Mensaje := 'Departamento no existe';
  When others Then
    Estado := -1;
    Mensaje := 'Se ha producido un error en el proceso. ' || sqlerrm; 
    rollback;
End; 
/


var estado number
var mensaje varchar2(2000)


exec RECURSOS.registro_empleado('66666','TORRES','JUAN','15/01/2019','JTORRES@ALGO.COM',NULL,'C03',103,8000,:estado,:mensaje);
      
print estado
print mensaje


exec RECURSOS.registro_empleado('66666','peralta',null,'15/01/2019','JTORRES@ALGO.COM',NULL,'C03',103,8000,:estado,:mensaje);
      

print estado
print mensaje

select * from recursos.empleado;




