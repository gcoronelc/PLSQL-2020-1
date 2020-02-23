

create or replace procedure SCOTT.UpdateSalEmp2 
( Codigo Emp.EmpNo%Type, Salario Emp.Sal%Type ) 
is 
  Cont Number; 
  Excep1 Exception; 
  Excep2 Exception; 
Begin 
  Select Count(*) Into Cont 
    From Emp 
    Where EmpNo = Codigo; 
  If (Cont=0) Then 
    Raise Excep2; 
  End If; 
  Update Emp 
    Set Sal = Salario 
    Where EmpNo = Codigo; 
  Commit; 
  DBMS_Output.Put_Line( 'Proceso OK' ); 
Exception 
  When Excep1 Then 
    DBMS_Output.Put_Line( 'Código no existe.' );
  When Excep2 Then 
    DBMS_Output.Put_Line( 'Este es otro mensaje.' );
End; 
/


CALL SCOTT.UpdateSalEmp2( 9999, 5000 ); 

select * from scott.emp;

CALL SCOTT.UpdateSalEmp( 7369, 1400 ); 


