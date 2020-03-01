
CREATE OR REPLACE PACKAGE scott.pkg_demo as 

  nombre varchar2(100);
 
  function sumar( n1 in number, n2 in number ) 
  return number;
  
  function sumar( a in number, b in number ) 
  return number;

  function sumar( n1 in number, n2 in number, n3 in number ) 
  return number;
 
  function restar( a in number, b in number ) 
  return number;
 
 
END pkg_demo;
/



CREATE OR REPLACE PACKAGE BODY scott.pkg_demo as 
 
  function sumar( n1 in number, n2 in number ) 
  return number 
  as 
    rtn number; 
  begin 
    rtn := n1 + n2; 
    return rtn; 
  end; 
  
  function sumar( a in number, b in number ) 
  return number 
  as 
    rtn number; 
  begin 
    rtn := (a + b) * 2 ; 
    return rtn; 
  end;
  
  function sumar( n1 in number, n2 in number, n3 in number ) 
  return number 
  as 
    rtn number; 
  begin 
    rtn := n1 + n2 + n3; 
    return rtn; 
  end; 
  
  function restar( a in number, b in number ) 
  return number 
  as 
    rtn number; 
  begin 
    rtn := (a - b); 
    return rtn; 
  end;
 
END pkg_demo; 
/



select SCOTT.pkg_demo.sumar(n1 => 6, n2 => 7) from dual;

select SCOTT.pkg_demo.sumar(a => 6, b => 7) from dual;

select SCOTT.pkg_demo.sumar(6,7,8) from dual;

select SCOTT.pkg_demo.restar(8,3) from dual;


begin
  SCOTT.pkg_demo.nombre := 'Gustavo';
  dbms_output.put_line(SCOTT.pkg_demo.nombre);
end;
/


