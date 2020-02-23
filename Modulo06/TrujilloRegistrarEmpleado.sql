

CREATE OR REPLACE PROCEDURE SP_EMP_CREATE(
                                            P_CODIGO IN NUMBER,
                                            P_NOMBRE IN VARCHAR2,
                                            P_PUESTO IN VARCHAR2,
                                            P_SALARIO IN NUMBER,
                                            P_DEPARTAMENTO IN NUMBER)
IS
    v_cont NUMBER;
    v_min NUMBER := 0;
    v_max NUMBER := 0;
    Except1 Exception; 
    Except2 Exception; 
BEGIN
    SELECT COUNT(*) INTO v_cont 
    FROM SCOTT.DEPT 
    WHERE DEPTNO = P_DEPARTAMENTO;
    IF (v_cont = 0) THEN
        RAISE Except1;
    END IF;
    
    SELECT MIN(SAL) INTO v_min 
    FROM SCOTT.EMP
    WHERE DEPTNO = P_DEPARTAMENTO
    GROUP BY DEPTNO;
    
    SELECT MAX(SAL) INTO v_max 
    FROM SCOTT.EMP
    WHERE DEPTNO = P_DEPARTAMENTO
    GROUP BY DEPTNO;
    
    IF (P_SALARIO < v_min OR P_SALARIO > v_max) THEN
        RAISE Except2;
    END IF;
    
    INSERT INTO SCOTT.EMP (EMPNO, ENAME, JOB, SAL, DEPTNO) VALUES 
    (P_CODIGO, P_NOMBRE, P_PUESTO, P_SALARIO, P_DEPARTAMENTO);
    
    DBMS_Output.Put_Line( 'Proceso OK' ); 
    
    Exception 
        When Except1 Then 
            DBMS_Output.Put_Line( 'Departamento no existe.' ); 
        When Except2 Then
            DBMS_Output.Put_Line( 'Salario fuera de rango.' ); 

END;
/

call SCOTT.SP_EMP_CREATE (1234, 'Joel', 'Prog', 2000, 20);