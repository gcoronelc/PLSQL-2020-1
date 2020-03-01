-- Secuencias

create SEQUENCE scott.sq_test;


select scott.sq_test.nextval from dual;

insert into scott.emp( empno, ename, sal )
values( scott.sq_test.nextval, 'Gustavo', 9999 );

select * from scott.emp;

commit;



insert into scott.emp( empno, ename, sal )
values( scott.sq_test.nextval, 'Pedro', 7777 );

select * from scott.emp;

rollback;

insert into scott.emp( empno, ename, sal )
values( scott.sq_test.nextval, 'Manuel', 7777 );

select * from scott.emp;

commit;

