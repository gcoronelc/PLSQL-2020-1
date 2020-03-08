
-- SINONIMOS
/*

create [or replace] [public] synonym [esquema.] sinonimo 
    for [esquema.] objeto [@dblink] 
    

*/

create or replace public synonym EGCC_UTIL 
for SCOTT.PKG_EGCC_UTIL;


variable estado number;
exec :estado := EGCC_UTIL.IS_DATE('123456');
print estado


variable estado number;
exec :estado := EGCC_UTIL.IS_DATE('12/12/2020');
print estado




