CREATE OR REPLACE PROCEDURE SCOTT.SP_SUMA_PAR_IMPAR (N NUMBER)
IS
    VAR_SUM_PAR NUMBER := 0;
    VAR_SUM_IMPAR NUMBER := 0;
    CAD_PAR VARCHAR2(100);
    CAD_IMPAR VARCHAR2(100);
BEGIN
    FOR X IN 1 .. N LOOP
        IF ( MOD(X,2) = 0) THEN
            VAR_SUM_PAR := VAR_SUM_PAR + X;
            CAD_PAR := CAD_PAR || ' - ' || X;
        ELSE
            VAR_SUM_IMPAR := VAR_SUM_IMPAR + X;
            CAD_IMPAR := CAD_IMPAR || ' - ' || X;
        END IF;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('SUMAR PAR DE: ' || CAD_PAR || ' = ' || VAR_SUM_PAR);
    DBMS_OUTPUT.PUT_LINE('SUMAR IMPAR DE: ' || CAD_IMPAR || ' = ' || VAR_SUM_IMPAR);
END;
/

EXECUTE SCOTT.SP_SUMA_PAR_IMPAR(6);