set serveroutput on;

create or replace procedure CAMBIO_DE_VUELO (p_DESTINO in varchar2, p_VUELOI in number)
is
    cursor c_DPARALELOS is select * from VUELO where DESTINO=p_DESTINO and ID_VUELO!=p_VUELOI;
    v_MAXASIENTOS number;
    v_EXISTE number :=p_VUELOI ;
    v_PTOTALES number;
    v_PEXISTENTES number;
begin
    select count(*) into v_PTOTALES from TICKET where ID_VUELO=p_VUELOI;
    for r in c_DPARALELOS loop
        select AVION.TOTAL_ASIENTOS into v_MAXASIENTOS from AVION join VUELO on AVION.ID_AVION=VUELO.ID_AVION where VUELO.ID_VUELO=r.ID_VUELO;
        select count(*) into v_PEXISTENTES from TICKET where ID_VUELO=r.ID_VUELO;
        if ((v_PTOTALES+v_PEXISTENTES)<v_MAXASIENTOS) then
            v_EXISTE:=r.ID_VUELO;
        end if;
    end loop;
    if (v_EXISTE=p_VUELOI) then
        Raise_Application_Error(-20000,'No se encontraron vuelos alternativos');
    end if;
    update TICKET set ID_VUELO=v_EXISTE where ID_VUELO=p_VUELOI;
    update PASAJERO set ID_VUELO=v_EXISTE where ID_VUELO=p_VUELOI;
    commit;
end;
/

execute CAMBIO_DE_VUELO('Santiago de Chile', 107);