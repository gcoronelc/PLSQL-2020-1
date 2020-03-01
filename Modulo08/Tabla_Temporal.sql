-- Tablas temporales

create global temporary table scott.test ( 
  id number primary key, 
  dato varchar2(30) 
) on commit preserve rows;


insert into scott.test values( 1, 'Gustao' );
insert into scott.test values( 2, 'Gustavo' );
insert into scott.test values( 3, 'Angel' );

select * from scott.test;





