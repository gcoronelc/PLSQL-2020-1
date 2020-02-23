

create or replace procedure SCOTT.UpdateSalEmp4 
( Codigo Emp.EmpNo%Type, Salario Emp.Sal%Type ) 
is 
  Cont Number; 
Begin 
  Select Count(*) Into Cont 
    From Emp 
    Where EmpNo = Codigo; 
  If (Cont=0) Then 
    Raise_Application_Error( -20000, 'No existe empleado.' ); 
  End If; 
  Update Emp 
    Set Sal = Salario 
    Where EmpNo = Codigo; 
  Commit; 
  DBMS_Output.Put_Line( 'Proceso OK' ); 
Exception 
  When Others Then 
    dbms_output.put_line ( 'Error Nro. ORA' || to_char(sqlcode) ); 
    dbms_output.put_line ( sqlerrm ); 
End; 
/


CALL SCOTT.UpdateSalEmp4( 9999, 5000 ); 

select * from scott.emp;

CALL SCOTT.UpdateSalEmp4( 7369, 1300 );



