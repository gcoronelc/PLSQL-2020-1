

create or replace procedure SCOTT.UpdateSalEmp3 
( Codigo Emp.EmpNo%Type, Salario Emp.Sal%Type ) 
is 
  Cont Number; 
Begin 

  Select Count(*) Into Cont 
  From Emp Where EmpNo = Codigo; 
  
  If (Cont=0) Then 
    Raise_Application_Error( -20000, 'No existe empleado.' ); 
  End If; 
  
  Update Emp 
  Set Sal = Salario 
  Where EmpNo = Codigo; 
  
  Commit; 
  
  DBMS_Output.Put_Line( 'Proceso OK' ); 
  
End;
/


CALL SCOTT.UpdateSalEmp3( 9999, 5000 ); 

select * from scott.emp;

CALL SCOTT.UpdateSalEmp3( 7369, 1300 );


