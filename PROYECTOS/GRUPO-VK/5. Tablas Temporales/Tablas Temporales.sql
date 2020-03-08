create global temporary table VK.PASATEMP (
  ID_VUELO number(7),
  DNI char(8) primary key,
  NOMBRE varchar2(30) default null,
  APELLIDO varchar2(30) default null,
  EDAD number(3) default null,
  SEXO char (1) default null,
  ID_TICKET number(4),
  NRO_ASIENTO number(3) default null
) on commit preserve rows;

/

create or replace procedure VER_PASAJEROS (
   p_ID_VUELO in VUELO.ID_AVION%type default null
)
is
   cursor c_PASAJEROS is select PASAJERO.ID_VUELO,PASAJERO.DNI,PASAJERO.NOMBRE,PASAJERO.APELLIDO,PASAJERO.EDAD,PASAJERO.SEXO,TICKET.ID_TICKET,TICKET.NRO_ASIENTO from PASAJERO join TICKET on PASAJERO.ID_VUELO=TICKET.ID_VUELO where PASAJERO.ID_VUELO=p_ID_VUELO;
   r VK.PASATEMP%rowtype;
begin
    open c_PASAJEROS;
    fetch c_PASAJEROS into r;
    if (c_PASAJEROS%NOTFOUND) then
        Raise_Application_Error (-20000, 'El vuelo es incorrecto o no tiene pasajeros');
    end if;
    insert into PASATEMP(
    ID_VUELO
    ,DNI
    ,NOMBRE
    ,APELLIDO
    ,EDAD
    ,SEXO
    ,ID_TICKET
    ,NRO_ASIENTO) values (
    p_ID_VUELO
    ,r.DNI
    ,r.NOMBRE
    ,r.APELLIDO
    ,r.EDAD
    ,r.SEXO
    ,r.ID_TICKET
    ,r.NRO_ASIENTO
    );
end;
/

execute VER_PASAJEROS(100);

select * from VK.PASATEMP;