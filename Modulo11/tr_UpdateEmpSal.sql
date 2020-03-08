

Create Table SCOTT.Sal_History( 
  EmpNo Number(4) not null, 
  SalOld Number(7,2) null, 
  SalNew Number(7,2) null, 
  StartDate Date not null, 
  SetUser Varchar2(30) not null 
); 


Create or Replace Trigger SCOTT.tr_UpdateEmpSal 
After Insert OR Update ON SCOTT.Emp 
For Each Row 
Begin  
  Insert Into SCOTT.Sal_History(EmpNo, SalOld, SalNew, StartDate, SetUser) 
    Values( :New.EmpNo, :Old.Sal, :New.Sal, sysdate, USER ); 
End tr_UpdateEmpSal;
/


SELECT * FROM SCOTT.Sal_History;


update SCOTT.emp 
set sal = 1200 
where empno = 7369;


update SCOTT.emp 
set sal = SAL * 1.3 
where empno in (7788, 7902); 


INSERT INTO SCOTT.EMP(EMPNO,ENAME,SAL)
VALUES( 9977,'LEONOR',7786);


update SCOTT.emp 
set ENAME = 'SOFIA' 
where empno = 9977; 


alter trigger SCOTT.tr_UpdateEmpSal disable;




