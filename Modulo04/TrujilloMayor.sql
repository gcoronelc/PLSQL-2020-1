CREATE OR REPLACE FUNCTION scott.fn_mayor (
    n1   NUMBER,
    n2   NUMBER,
    n3   NUMBER,
    n4   NUMBER,
    n5   NUMBER
) RETURN NUMBER AS
    v_mayor NUMBER;
BEGIN
    v_mayor := -999999;
    IF ( v_mayor < n1 ) THEN
        v_mayor := n1;
    END IF;
    IF ( v_mayor < n2 ) THEN
        v_mayor := n2;
    END IF;
    IF ( v_mayor < n3 ) THEN
        v_mayor := n3;
    END IF;
    IF ( v_mayor < n4 ) THEN
        v_mayor := n4;
    END IF;
    IF ( v_mayor < n5 ) THEN
        v_mayor := n5;
    END IF;
    RETURN v_mayor;
END;
/
