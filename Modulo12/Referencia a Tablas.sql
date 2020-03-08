-- REFERENCIAS A TABLAS
/*

    [ <esquema>. ]<nombre del tabla>[@<enlace de base de datos>]

*/


  SELECT * FROM scott.emp;
  
  SELECT * FROM scott.emp@lnkEGCC; 



-- Referencia a paquetes o SP
/*

  [ <esquema>. ]<nombre del paquete o SP>

*/


variable estado number;
exec :estado := SCOTT.PKG_EGCC_UTIL.IS_DATE('123456');
print estado


variable estado number;
exec :estado := SCOTT.PKG_EGCC_UTIL.IS_DATE('12/12/2020');
print estado



