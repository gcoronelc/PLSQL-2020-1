create or replace function 
SCOTT.fn106(v_empno emp.empno%type) 
return varchar2 is 
  v_msg varchar2(40); 
  v_sal emp.sal%type; 
begin 
  select sal into v_sal from emp where empno = v_empno; 
  case 
    when (v_sal > 0 and v_sal <= 2500) then 
      v_msg := 'Salario Bajo'; 
    when (v_sal > 2500 and v_sal <= 4000) then 
      v_msg := 'Salario Regular'; 
    when (v_sal > 4000) then 
      v_msg := 'Salario Bueno'; 
    else 
      v_msg := 'Caso Desconocido'; 
  end case; 
  v_msg := to_char(v_sal) || ' - ' || v_msg; 
  return v_msg; 
EXCEPTION
  WHEN OTHERS THEN
    RETURN 'NO EXISTE';
end; 
/


SELECT * FROM SCOTT.EMP;

SELECT SCOTT.fn106(749955) FROM DUAL;

