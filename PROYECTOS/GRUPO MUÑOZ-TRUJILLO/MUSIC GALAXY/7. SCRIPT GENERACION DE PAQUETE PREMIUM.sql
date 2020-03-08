create or replace PACKAGE  MG.PKG_PREMIUM AS
        /*
        NOMBRE DEL PROGRAMA : PKG_PREMIUM
        OBJETIVO            : MODIFICAR LAS CUENTAS DE LOS USUARIOS A PREMIUM Y LOS BENEFICIOS QUE CONTRAE 
        NOTAS               : 
        AUTOR               : JT
        HISTORIAL           :
        FECHA                 AUTOR            DESCRIPCION
        ======================================================================
        04/03/2020            JT              CREACION DEL PAQUETE
        */

        TYPE CURSOR_TYPE IS REF CURSOR;

        PROCEDURE PRC_PAGO_SUSCRIPCION (
                P_ID_USUARIO IN T_PREMIUM.ID_USUARIO%TYPE,
                P_N_CUENTA IN T_PREMIUM.N_CUENTA%TYPE
                );
        PROCEDURE PRC_CREAR_CUENTA(TRC_PERSONAS OUT CURSOR_TYPE);

END PKG_PREMIUM;
/


create or replace PACKAGE BODY    MG.PKG_PREMIUM AS
     /*
        NOMBRE DEL PROGRAMA : PKG_PREMIUM
        OBJETIVO            : MODIFICAR LAS CUENTAS DE LOS USUARIOS A PREMIUM Y LOS BENEFICIOS QUE CONTRAE 
        NOTAS               : 
        AUTOR               : JT
        HISTORIAL           :
        FECHA                 AUTOR            DESCRIPCION
        ======================================================================
        04/03/2020            JT              CREACION DEL PAQUETE
        */
        PROCEDURE PRC_PAGO_SUSCRIPCION (
                P_ID_USUARIO IN T_PREMIUM.ID_USUARIO%TYPE,
                P_N_CUENTA IN T_PREMIUM.N_CUENTA%TYPE
                )
        IS
            V_MENSAJE_ERROR VARCHAR2(2000);
            V_CONTADOR NUMBER;
            V_SALDO NUMBER;
            V_CONT NUMBER;
            V_FECHA_FIN VARCHAR2(20);
            V_FLAG NUMBER;
            EXCP EXCEPTION;
        
       BEGIN
            -- VERIFICA SI USUARIO ESTA ACTIVO
            SELECT FLAG INTO V_FLAG
            FROM T_USUARIO
            WHERE ID_USUARIO = P_ID_USUARIO;
            IF V_FLAG != 1 THEN
                V_MENSAJE_ERROR := 'USUARIO NO EXISTENTE';
                RAISE EXCP;    
            END IF;
           
            -- VERIFICA QUE NO HAYA REALIZADO UN PAGO EN EL MES ACTUAL
            SELECT COUNT(*)
            INTO V_CONTADOR
            FROM T_PREMIUM
            WHERE ID_USUARIO = P_ID_USUARIO AND FECHA_PAGO <= SYSDATE AND FECHA_FIN >= SYSDATE;
            
            IF V_CONTADOR > 0 THEN
                V_MENSAJE_ERROR := 'PAGO REALIZADO ESTE MES';
                RAISE EXCP;
            END IF;
            
            -- VERIFICA QUE TENGA SALDO SUFICIENTE EN LA CUENTA
            SELECT CUENTA_SALDO INTO V_SALDO
            FROM T_CUENTA
            WHERE ID_CUENTA = P_N_CUENTA;
            V_SALDO := V_SALDO - 18.9;
            
            IF V_SALDO < 0.0 THEN
                V_MENSAJE_ERROR := 'SALDO INSUFICIENTE PARA REALIZAR LA TRANSACCION';
                RAISE EXCP;
            END IF;
            
            -- ACTUALIZA EL SALDO DE CUENTA
            UPDATE T_CUENTA
                SET CUENTA_SALDO = V_SALDO
                WHERE ID_CUENTA = P_N_CUENTA;
                
            -- INSERTA PAGOS EN LA APLICACION
                INSERT INTO T_PREMIUM (ID_PREMIUM, ID_USUARIO, N_CUENTA)
                VALUES (MG.SEQ_CUENTA_PREMIUM_ID.NEXTVAL, P_ID_USUARIO, P_N_CUENTA);
            
            -- ACTUALIZA TIPO DE USUARIO
            UPDATE T_USUARIO
                SET ID_TIPO_USUARIO = 2
                WHERE ID_USUARIO = P_ID_USUARIO;
            -- CONFIRMAR LA TRANSACCION
            COMMIT;
                DBMS_OUTPUT.PUT_LINE('SUSCRIPCION EXITOSA');
            EXCEPTION
                WHEN EXCP THEN
                    ROLLBACK;
                   DBMS_OUTPUT.PUT_LINE(V_MENSAJE_ERROR);
                WHEN OTHERS THEN
                    -- ROLLBACK;
                    DBMS_OUTPUT.PUT_LINE(sqlerrm);
    END PRC_PAGO_SUSCRIPCION;
    
     /*
        NOMBRE DEL PROGRAMA : PKG_PREMIUM
        OBJETIVO            : INSERTAR REGISTROS DE CUENTAS DE 2000 USUARIOS ALEATORIOS CON MONTOS ALEATORIOS
        NOTAS               : 
        AUTOR               : JT
        HISTORIAL           :
        FECHA                 AUTOR            DESCRIPCION
        ======================================================================
        04/03/2020            JT              CREACION DEL PAQUETE
        */
        PROCEDURE PRC_CREAR_CUENTA(TRC_PERSONAS OUT CURSOR_TYPE)
        IS
            CURSOR V_CURSOR IS SELECT * FROM (
                                            SELECT ID_PERSONA, FLOOR(DBMS_RANDOM.VALUE(1, 1000)) AS SALDO
                                            FROM T_PERSONA
                                            ORDER BY DBMS_RANDOM.VALUE)
                                            WHERE ROWNUM <= 2000;
        BEGIN

            FOR r IN V_CURSOR LOOP
                INSERT INTO T_CUENTA (ID_CUENTA, ID_CLIENTE, CUENTA_SALDO)
                VALUES (CONCAT(TO_CHAR(SYSDATE, 'ddmmyy'), MG.SEQ_CUENTA_USUARIO_ID.NEXTVAL), r.ID_PERSONA, r.SALDO);
            END LOOP;
            
            COMMIT;
            
            OPEN TRC_PERSONAS FOR
                SELECT * FROM T_CUENTA;
        END PRC_CREAR_CUENTA;
END PKG_PREMIUM;


/* VARIABLE V_CUENTA REFCURSOR;
EXEC PKG_PREMIUM.PRC_CREAR_CUENTA(:V_CUENTA);
PRINT V_CUENTA */

-- EXEC PKG_PREMIUM.PRC_PAGO_SUSCRIPCION(1982, 40320645);

