

create or replace function 
scott.getSalario( Cod Emp.EmpNo%Type ) 
return number
is 
  Salario Emp.Sal%Type; 
Begin 
  Select Sal Into Salario 
  From Emp Where EmpNo = Cod; 
  return Salario;
Exception 
  When No_Data_Found Then 
    return -1; 
End; 
/


select scott.getSalario(1234) SUELDO from dual;

select * from scott.emp;

select scott.getSalario(7369) SUELDO from dual;


