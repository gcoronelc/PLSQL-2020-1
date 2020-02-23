

create or replace procedure SCOTT.UpdateSalEmp5 
( 
  Codigo IN Emp.EmpNo%Type, 
  Salario IN Emp.Sal%Type,
  Estado OUT NOCOPY NUMBER,
  Mensaje OUT NOCOPY VARCHAR2
) 
is 
  Cont Number; 
Begin 
  Select Count(*) Into Cont 
  From Emp Where EmpNo = Codigo; 
  If (Cont=0) Then 
    Raise No_Data_Found; 
  End If; 
  Update Emp 
  Set Sal = Salario 
  Where EmpNo = Codigo; 
  Commit; 
  Estado := 1;
  Mensaje := 'Proceso ok.';
Exception 
  When No_Data_Found Then 
    Estado := -1;
    Mensaje := 'Código no existe.'; 
End; 
/


var estado number
var mensaje varchar2(500)

EXEC SCOTT.UpdateSalEmp5( 9999, 5000, :estado, :mensaje ); 

print estado
print mensaje

select * from scott.emp;

EXECUTE SCOTT.UpdateSalEmp5( 7369, 3000, :estado, :mensaje );

print estado
print mensaje

