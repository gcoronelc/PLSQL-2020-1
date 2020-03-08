create or replace package PASAJERO_CRUD
is

type PASAJERO_CRUD_rec is record (
APELLIDO  PASAJERO.APELLIDO%type
,EDAD  PASAJERO.EDAD%type
,CORREO  PASAJERO.CORREO%type
,ID_VUELO  PASAJERO.ID_VUELO%type
,TELEFONO  PASAJERO.TELEFONO%type
,DNI  PASAJERO.DNI%type
,NOMBRE  PASAJERO.NOMBRE%type
,SEXO  PASAJERO.SEXO%type
);
type PASAJERO_CRUD_tab is table of PASAJERO_CRUD_rec;

-- insert
procedure PASAJERO_INSERT (
    p_DNI in PASAJERO.DNI%type
    ,p_NOMBRE in PASAJERO.NOMBRE%type default null 
    ,p_APELLIDO in PASAJERO.APELLIDO%type default null 
    ,p_EDAD in PASAJERO.EDAD%type default null 
    ,p_SEXO in PASAJERO.SEXO%type default null
    ,p_TELEFONO in PASAJERO.TELEFONO%type default null 
    ,p_CORREO in PASAJERO.CORREO%type default null 
    ,p_ID_VUELO in PASAJERO.ID_VUELO%type default null 
    ,p_NRO_ASIENTO in TICKET.NRO_ASIENTO%type default null
    ,p_TIPO_DE_PAGO in TICKET.TIPO_DE_PAGO%type default null
    ,p_IMPORTE in TICKET.IMPORTE%type default null
);
-- update
procedure PASAJERO_UPDATE (
p_DNI in PASAJERO.DNI%type 
,p_NOMBRE in PASAJERO.NOMBRE%type default null 
,p_APELLIDO in PASAJERO.APELLIDO%type default null 
,p_EDAD in PASAJERO.EDAD%type default null 
,p_SEXO in PASAJERO.SEXO%type default null 
,p_TELEFONO in PASAJERO.TELEFONO%type default null 
,p_CORREO in PASAJERO.CORREO%type default null 
,p_ID_VUELO in PASAJERO.ID_VUELO%type default null 
,P_ASIENTO in TICKET.NRO_ASIENTO%type
);
-- delete
procedure del (
p_DNI in PASAJERO.DNI%type
);
end PASAJERO_CRUD;

/
create or replace package body PASAJERO_CRUD
is  
-- insert
procedure PASAJERO_INSERT ( 
    p_DNI in PASAJERO.DNI%type
    ,p_NOMBRE in PASAJERO.NOMBRE%type default null 
    ,p_APELLIDO in PASAJERO.APELLIDO%type default null 
    ,p_EDAD in PASAJERO.EDAD%type default null 
    ,p_SEXO in PASAJERO.SEXO%type default null
    ,p_TELEFONO in PASAJERO.TELEFONO%type default null 
    ,p_CORREO in PASAJERO.CORREO%type default null 
    ,p_ID_VUELO in PASAJERO.ID_VUELO%type default null 
    ,p_NRO_ASIENTO in TICKET.NRO_ASIENTO%type default null
    ,p_TIPO_DE_PAGO in TICKET.TIPO_DE_PAGO%type default null
    ,p_IMPORTE in TICKET.IMPORTE%type default null
) is
    cursor c_DNI is select * from PASAJERO where DNI=p_DNI;
    cursor c_VUELO is select * from VUELO where ID_VUELO=p_ID_VUELO;
    cursor c_ASIENTO is select * from TICKET where NRO_ASIENTO=p_NRO_ASIENTO and ID_VUELO=p_ID_VUELO;
    cursor c_TASIENTO is select AVION.TOTAL_ASIENTOS from AVION join VUELO on AVION.ID_AVION=VUELO.ID_AVION where VUELO.ID_VUELO=p_ID_VUELO;
    r_DNI PASAJERO%rowtype;
    r_VUELO VUELO%rowtype;
    r_ASIENTO TICKET%rowtype;
    v_TASIENTO AVION.TOTAL_ASIENTOS%type;
begin
    open c_DNI;
    fetch c_DNI into r_DNI;
    if (c_DNI%FOUND) then
        Raise_Application_Error (-200002, 'El DNI ya estaba registrado');
    end if;
    close c_DNI;
    open c_VUELO;
    fetch c_VUELO into r_VUELO;
    if(c_VUELO%NOTFOUND) then
        Raise_Application_Error( -20000, 'No existe el vuelo.' );
    end if;
    close c_VUELO;
    open c_ASIENTO;
    fetch c_ASIENTO into r_ASIENTO;
    if(c_ASIENTO%FOUND) then
        Raise_Application_Error( -20001, 'El asiento ya esta ocupado.' );
    end if;
    close c_ASIENTO;
    open c_TASIENTO;
    fetch c_TASIENTO into v_TASIENTO;
    if(p_NRO_ASIENTO<0 or p_NRO_ASIENTO>v_TASIENTO) then
        Raise_Application_Error( -20003, 'El numero de asiento es invalido.' );
    end if;
    insert into PASAJERO(
        APELLIDO
        ,EDAD
        ,CORREO
        ,ID_VUELO
        ,TELEFONO
        ,DNI
        ,NOMBRE
        ,SEXO
    ) values (
        p_APELLIDO
        ,p_EDAD
        ,p_CORREO
        ,p_ID_VUELO
        ,p_TELEFONO
        ,p_DNI
        ,p_NOMBRE
        ,p_SEXO
    );
    insert into ticket (
        NRO_ASIENTO
        ,TIPO_DE_PAGO
        ,IMPORTE
        ,DNI
        ,ID_VUELO
    ) values (
        p_NRO_ASIENTO
        ,p_TIPO_DE_PAGO
        ,p_IMPORTE
        ,p_DNI
        ,p_ID_VUELO
    );
end;
-- update
procedure PASAJERO_UPDATE (
    p_DNI in PASAJERO.DNI%type 
    ,p_NOMBRE in PASAJERO.NOMBRE%type default null 
    ,p_APELLIDO in PASAJERO.APELLIDO%type default null 
    ,p_EDAD in PASAJERO.EDAD%type default null 
    ,p_SEXO in PASAJERO.SEXO%type default null 
    ,p_TELEFONO in PASAJERO.TELEFONO%type default null 
    ,p_CORREO in PASAJERO.CORREO%type default null 
    ,p_ID_VUELO in PASAJERO.ID_VUELO%type default null 
    ,P_ASIENTO in TICKET.NRO_ASIENTO%type
) is
    cursor c_ASIENTO is select NRO_ASIENTO, ID_VUELO from TICKET where NRO_ASIENTO=p_ASIENTO and ID_VUELO=p_ID_VUELO;
    cursor c_VUELO is select AVION.TOTAL_ASIENTOS from AVION join VUELO on AVION.ID_AVION=VUELO.ID_AVION where VUELO.ID_VUELO=p_ID_VUELO;
    v_ASIENTO TICKET%rowtype;
    v_TASIENTOS AVION.TOTAL_ASIENTOS%type;
begin
    update PASAJERO set
    APELLIDO = p_APELLIDO
    ,EDAD = p_EDAD
    ,CORREO = p_CORREO
    ,TELEFONO = p_TELEFONO
    ,NOMBRE = p_NOMBRE
    ,SEXO = p_SEXO
    where DNI = p_DNI;
    open c_ASIENTO;
    open c_VUELO;
    fetch c_ASIENTO into v_ASIENTO.NRO_ASIENTO, v_ASIENTO.ID_VUELO;
    fetch c_VUELO into v_TASIENTOS;
    if (c_ASIENTO%NOTFOUND and p_ASIENTO > 0 and p_ASIENTO < v_TASIENTOS) then
        update TICKET set NRO_ASIENTO = P_ASIENTO where DNI = p_DNI;
    end if;
    close c_ASIENTO;
    close c_VUELO;
end;
-- del
procedure del (
    p_DNI in PASAJERO.DNI%type
) is
begin
    delete from TICKET
    where DNI=p_DNI;
    delete from PASAJERO
    where DNI = p_DNI;
end;
end PASAJERO_CRUD;

/

create or replace trigger tr_PK_TICKET
before insert on TICKET
for each row
begin
    select SQ_TICKET.nextval into :NEW.ID_TICKET from dual;
end;

/

execute PASAJERO_CRUD.PASAJERO_INSERT('21548764','ALEX','JARAMILLO',27,'M', '985468525', 'AJARAMILLO@gmail.com', 100, 14, 'Tarjeta De Credito', 150);

execute PASAJERO_CRUD.PASAJERO_UPDATE('21548764','ALEX','JARAMILLO',27,'M', '985468525', 'AJARAMILLO@gmail.com', 100, 55);

execute PASAJERO_CRUD.del('21548764');