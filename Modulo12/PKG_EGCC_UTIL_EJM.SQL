
DECLARE
 
	V_DATOS VARCHAR2(1000);
	V_ARREGLO SCOTT.PKG_EGCC_UTIL.T_ARRAY_STRING;
	
BEGIN

	V_DATOS := 'DATO1|DATO2|5678|GUSTAVO';
	V_ARREGLO := SCOTT.PKG_EGCC_UTIL.SPLIT(V_DATOS,'|');
	
	DBMS_OUTPUT.PUT_LINE('COUNT: ' || V_ARREGLO.COUNT);
	FOR I in 1 .. V_ARREGLO.COUNT LOOP 
		dbms_output.put_line(V_ARREGLO(I)); 
	END LOOP;
	
END;
/



DECLARE
 
	V_DATOS VARCHAR2(1000);
	V_ARREGLO SCOTT.PKG_EGCC_UTIL.T_ARRAY_STRING;
	
BEGIN

	V_DATOS := '7777|PEDRO|6789¬7778|JUAN|6578¬7779|MARIA|9999¬7780|KARLA|4587';
	V_ARREGLO := SCOTT.PKG_EGCC_UTIL.SPLIT(V_DATOS,'¬');
	
	DBMS_OUTPUT.PUT_LINE('COUNT: ' || V_ARREGLO.COUNT);
	FOR I in 1 .. V_ARREGLO.COUNT LOOP 
		dbms_output.put_line(V_ARREGLO(I)); 
	END LOOP;
	
END;
/



CREATE OR REPLACE PROCEDURE SCOTT.PR_INSERTA_EMPLEADOS
( P_DATOS IN VARCHAR2, P_ESTADO OUT VARCHAR2 )
AS
  V_REGISTROS SCOTT.PKG_EGCC_UTIL.T_ARRAY_STRING;
  V_CAMPOS    SCOTT.PKG_EGCC_UTIL.T_ARRAY_STRING;
BEGIN
  P_ESTADO := 'OK';
  V_REGISTROS := SCOTT.PKG_EGCC_UTIL.SPLIT(P_DATOS,'¬');
  
  FOR I in 1 .. V_REGISTROS.COUNT LOOP 

    V_CAMPOS := SCOTT.PKG_EGCC_UTIL.SPLIT(V_REGISTROS(I),'|');

    INSERT INTO EMP(EMPNO, ENAME, SAL) 
    VALUES(TO_NUMBER(V_CAMPOS(1)), V_CAMPOS(2), TO_NUMBER(V_CAMPOS(3)) );

	END LOOP;    
  COMMIT;
    
EXCEPTION
    WHEN OTHERS THEN
        P_ESTADO := SQLERRM;
        ROLLBACK;
END;
/


SELECT * FROM SCOTT.EMP;

DECLARE
  V_DATA   VARCHAR2(10000);
  V_ESTADO VARCHAR2(500);
BEGIN
  -- DATA
  V_DATA := '5555|PEDRO|6789¬5556|JUAN|6578¬5557|MARIA|9999¬5558|KARLA|4587';
  -- PROCESO
	SCOTT.PR_INSERTA_EMPLEADOS (V_DATA, V_ESTADO);
  -- REPORTE
  DBMS_OUTPUT.PUT_LINE(V_ESTADO);
END;
/



select regexp_substr('SMITH,ALLEN,WARD,JONES','[^,]+', 1, level) from DUAL
connect by regexp_substr('SMITH,ALLEN,WARD,JONES', '[^,]+', 1, level) is not null;



declare
	V_DATOS varchar2(10000) := '1|2da actualización|2321669|21/08/2013|156-2013-OEFA/DE|372-2013-OEFA/DE-SDCA|F00001|No Aplica|Restos o depósitos de residuos.|||Sin Lote|Loreto|Dátem del Marañón|Morona|Bajo|Medio|Bajo||251587|9564586|18||Región Hidrográfica del Amazonas|Cuenca Morona||||||||||||||||||Medio||||||||~2|2da actualización|2347225|2/12/2013|221-2013-OEFA/DE|498-2013-OEFA/DE-SDCA|F00666|T2378|Pozo mal abandonado|||VII/VI (ex Lote VII)|Piura|Talara|La Brea|Bajo|Bajo|Bajo||477044|9487433|17||Región Hidrografica del Pacífico|Intercuenca 1391||||||||||||||||||Bajo||||||||PA por termino de contrato N° 2863087~3|Posterior - 2019|2982142|1/10/2019|Oficio N° 250-2019|Informe N° 407-2019-OEFA/DEAM-SSIM|F05855|A_897|Suelocontaminado conhidrocarburos enel áreacircundante alpozo A_897 einstalación malabandonadavinculada a dichopozo|APA Tipo 01||X|Piura|Talara|El Alto|Medio|Medio|Medio||479234|9526689|17||Región Hidrografica del Pacífico|Cuenca Pariñas||||||||||||||||||Medio||||||||PA por termino de contrato N° 2930302';
	V_ARREGLO SCOTT.PKG_EGCC_UTIL.T_ARRAY_STRING;
begin
	V_ARREGLO := SCOTT.PKG_EGCC_UTIL.SPLIT(V_DATOS,'~');
	
	DBMS_OUTPUT.PUT_LINE('COUNT: ' || V_ARREGLO.COUNT);
	FOR I in 1 .. V_ARREGLO.COUNT LOOP 
		dbms_output.put_line(V_ARREGLO(I)); 
	END LOOP;
end;
/

