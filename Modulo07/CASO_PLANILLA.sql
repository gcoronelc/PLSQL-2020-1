

CREATE TABLE SCOTT.PLANILLAMES( 
  ANIO NUMBER(4), 
  MES NUMBER(2), 
  DEPTNO NUMBER(2), 
  EMPS NUMBER(2) NOT NULL, 
  PLANILLA NUMBER(10,2) NOT NULL, 
  CONSTRAINT PK_PLANILLAMES PRIMARY KEY(ANIO,MES, DEPTNO) 
);


create or replace procedure SCOTT.SP_PROC_PLANILLA
(p_anio number, p_mes number) 
is 
  cursor c_dept is select deptno from dept; 
  v_deptno dept.deptno%type; 
  cont number; 
  v_emps number; 
  v_planilla number; 
begin 
  select count(*) into cont 
  from SCOTT.planillames 
  where anio = p_anio and mes = p_mes; 
  if (cont > 0) then 
    dbms_output.put_line('Ya esta procesado'); 
    return; 
  end if; 
  open c_dept; 
  fetch c_dept into v_deptno; 
  while c_dept%found loop 
    select count(*), sum(sal) into v_emps, v_planilla 
    from emp where deptno = v_deptno; 
    insert into SCOTT.planillames 
    values(p_anio, p_mes, v_deptno, v_emps, nvl(v_planilla,0)); 
    fetch c_dept into v_deptno; 
  end loop; 
  close c_dept; 
  commit; 
  dbms_output.put_line('Proceso ok.'); 
end; 
/

CALL SCOTT.SP_PROC_PLANILLA(2020,3);


SELECT * FROM SCOTT.planillames;
