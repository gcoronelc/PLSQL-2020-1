
-- Enlace de Base de Datos con Cadena de Conexión

create public database link lnkEGCC 
connect to system identified by oracle
using '172.17.3.20:1521/orcl';
 
  
select * from scott.emp@lnkEGCC;

select * from HR.employees@lnkEGCC;



-- Enlace de Base de Datos con TNSNAME


create public database link lnkEGCC2 
connect to system identified by oracle
using 'orcl';

select * from scott.emp@lnkEGCC2;

select * from HR.employees@lnkEGCC2;



-- Enlace de Base de Datos con TNSNAME


create public database link lnkEGCC3 
connect to system identified by oracle
using 'panchito';

select * from scott.emp@lnkEGCC3;

select * from HR.employees@lnkEGCC3;



