

create or replace procedure SCOTT.UpdateSalEmp 
( Codigo Emp.EmpNo%Type, Salario Emp.Sal%Type ) 
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
  DBMS_Output.Put_Line( 'Proceso OK' ); 
Exception 
  When No_Data_Found Then 
    DBMS_Output.Put_Line( 'Código no existe.' ); 
End; 
/

CALL SCOTT.UpdateSalEmp( 9999, 5000 ); 

select * from scott.emp;

CALL SCOTT.UpdateSalEmp( 7369, 1300 ); 


