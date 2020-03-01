create or replace package EMP_tapi
is

type EMP_tapi_rec is record (
ENAME  EMP.ENAME%type
,COMM  EMP.COMM%type
,HIREDATE  EMP.HIREDATE%type
,EMPNO  EMP.EMPNO%type
,MGR  EMP.MGR%type
,JOB  EMP.JOB%type
,DEPTNO  EMP.DEPTNO%type
,SAL  EMP.SAL%type
);
type EMP_tapi_tab is table of EMP_tapi_rec;

-- insert
procedure ins (
p_ENAME in EMP.ENAME%type default null 
,p_COMM in EMP.COMM%type default null 
,p_HIREDATE in EMP.HIREDATE%type default null 
,p_EMPNO in EMP.EMPNO%type
,p_MGR in EMP.MGR%type default null 
,p_JOB in EMP.JOB%type default null 
,p_DEPTNO in EMP.DEPTNO%type default null 
,p_SAL in EMP.SAL%type default null 
);
-- update
procedure upd (
p_ENAME in EMP.ENAME%type default null 
,p_COMM in EMP.COMM%type default null 
,p_HIREDATE in EMP.HIREDATE%type default null 
,p_EMPNO in EMP.EMPNO%type
,p_MGR in EMP.MGR%type default null 
,p_JOB in EMP.JOB%type default null 
,p_DEPTNO in EMP.DEPTNO%type default null 
,p_SAL in EMP.SAL%type default null 
);
-- delete
procedure del (
p_EMPNO in EMP.EMPNO%type
);
end EMP_tapi;

/


create or replace package body EMP_tapi
is
-- insert
procedure ins (
p_ENAME in EMP.ENAME%type default null 
,p_COMM in EMP.COMM%type default null 
,p_HIREDATE in EMP.HIREDATE%type default null 
,p_EMPNO in EMP.EMPNO%type
,p_MGR in EMP.MGR%type default null 
,p_JOB in EMP.JOB%type default null 
,p_DEPTNO in EMP.DEPTNO%type default null 
,p_SAL in EMP.SAL%type default null 
) is
begin
insert into EMP(
ENAME
,COMM
,HIREDATE
,EMPNO
,MGR
,JOB
,DEPTNO
,SAL
) values (
p_ENAME
,p_COMM
,p_HIREDATE
,p_EMPNO
,p_MGR
,p_JOB
,p_DEPTNO
,p_SAL
);end;
-- update
procedure upd (
p_ENAME in EMP.ENAME%type default null 
,p_COMM in EMP.COMM%type default null 
,p_HIREDATE in EMP.HIREDATE%type default null 
,p_EMPNO in EMP.EMPNO%type
,p_MGR in EMP.MGR%type default null 
,p_JOB in EMP.JOB%type default null 
,p_DEPTNO in EMP.DEPTNO%type default null 
,p_SAL in EMP.SAL%type default null 
) is
begin
update EMP set
ENAME = p_ENAME
,COMM = p_COMM
,HIREDATE = p_HIREDATE
,MGR = p_MGR
,JOB = p_JOB
,DEPTNO = p_DEPTNO
,SAL = p_SAL
where EMPNO = p_EMPNO;
end;
-- del
procedure del (
p_EMPNO in EMP.EMPNO%type
) is
begin
delete from EMP
where EMPNO = p_EMPNO;
end;

end EMP_tapi;
/

