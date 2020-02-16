
select * from dba_users
where username='HR';

ALTER USER HR
IDENTIFIED BY hr
ACCOUNT UNLOCK;
