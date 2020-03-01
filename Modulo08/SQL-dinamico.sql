
-- Error

begin
  create table scott.algo( dato varchar2(100) );
end;
/


create or replace procedure scott.sp_execute
( cmd varchar2) 
is 
begin 
  execute immediate cmd; 
end; 
/


call scott.sp_execute('create table scott.algo( dato varchar2(100) )');


SELECT * FROM DBA_ROLE_PRIVS WHERE GRANTEE = 'SCOTT';

SELECT * FROM DBA_TAB_PRIVS WHERE GRANTEE = 'SCOTT';

select * from DBA_sys_privs WHERE GRANTEE = 'SCOTT';


GRANT CREATE TABLE TO SCOTT;




