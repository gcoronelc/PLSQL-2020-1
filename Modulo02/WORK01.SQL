
select * from dba_users
where username='SCOTT';

ALTER USER SCOTT
IDENTIFIED BY tiger
ACCOUNT UNLOCK;
