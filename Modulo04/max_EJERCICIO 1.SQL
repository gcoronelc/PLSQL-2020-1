create or replace 
function SCOTT.MAX5
(n1 NUMBER, n2 NUMBER, n3 NUMBER, n4 NUMBER, n5 NUMBER)
RETURN NUMBER
IS
  m NUMBER;
  maximo NUMBER;
 
BEGIN
IF n1>=n2
 
    THEN
 
        m:=n1;
 
    ELSE
 
        m:=n2;
 
END IF;


 
IF m>=n3
 
    THEN
 
        maximo:=m;
 
    ELSE
        maximo:=n3;
 

END IF;
 
 IF m>=n4
 
    THEN
 
        maximo:=m;
 
    ELSE
        maximo:=n4;
 

END IF;

 IF m>=n5
 
    THEN
 
        maximo:=m;
 
    ELSE
        maximo:=n5;
 

END IF;


RETURN maximo;
 
END;
/

select SCOTT.MAX5(-56,-43,-5,-50,-6) suma from dual;




