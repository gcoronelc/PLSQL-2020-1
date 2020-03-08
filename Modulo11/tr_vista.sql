

Create Or Replace View SCOTT.v_empleados As 
Select e.empno, e.ename, d.deptno, d.dname 
From  SCOTT.emp e Inner Join SCOTT.dept d 
On e.deptno = d.deptno; 




Create Or Replace Trigger SCOTT.tr_vista 
Instead Of Insert Or Delete On SCOTT.v_empleados   
For Each Row 
Declare 
  cuenta Number; 
Begin 
  If Inserting Then 
      Select Count(*) Into cuenta From SCOTT.dept Where deptno = :new.deptno; 
      If cuenta = 0 Then 
         Insert Into SCOTT.dept(deptno,dname) 
         Values(:New.deptno, :New.dname); 
      End If; 
   
      Select Count(*) Into cuenta From SCOTT.emp Where empno = :new.empno; 
      If cuenta = 0 Then 
         Insert Into SCOTT.emp(empno,ename,deptno) 
         Values(:New.empno, :New.ename, :New.deptno); 
      End If; 
  Elsif Deleting Then 
        Delete From SCOTT.emp Where empno = :old.empno; 
  End If; 
End tr_vista; 
/


SELECT * FROM SCOTT.v_empleados;

INSERT INTO SCOTT.v_empleados
VALUES(8989,'MELISA',66,'ALPHA');


SELECT * FROM SCOTT.dept;

SELECT * FROM SCOTT.EMP;


DELETE FROM SCOTT.EMP WHERE EMPNO = 8989;



