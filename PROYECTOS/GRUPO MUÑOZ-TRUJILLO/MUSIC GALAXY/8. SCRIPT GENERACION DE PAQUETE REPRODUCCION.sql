create or replace PACKAGE    MG.PKG_REPRODUCCION AS
        /*
        NOMBRE DEL PROGRAMA : PKG_REPRODUCCION
        OBJETIVO            : GESTIONAR LAS LISTAS DE REPRODUCCION DE LOS USUARIOS
        NOTAS               : 
        AUTOR               : JT
        HISTORIAL           :
        FECHA                 AUTOR            DESCRIPCION
        ======================================================================
        04/03/2020            JT              CREACION DEL PAQUETE
        */

        TYPE CURSOR_TYPE IS REF CURSOR;

        PROCEDURE PRC_CREAR_LISTA (
                P_ID_USUARIO IN T_LISTA_REPROD.ID_USUARIO%TYPE,
                P_LISTA IN T_LISTA_REPROD.LISTA_REPRODUCCION%TYPE
                );
                
         PROCEDURE PRC_MODIFICAR_LISTA (
                P_ID_LISTA_REPROD IN T_LISTA_REPROD.ID_LISTA_REPROD%TYPE,
                P_LISTA IN T_LISTA_REPROD.LISTA_REPRODUCCION%TYPE
                );
        PROCEDURE PRC_AGREGAR_CANCION (
                P_ID_LISTA_REPROD IN T_LISTA_CANCION.ID_LISTA_REPROD%TYPE,
                P_ID_CANCION IN T_LISTA_CANCION.ID_CANCION%TYPE
                );
        PROCEDURE PRC_ELIMINAR_CANCION (
                P_ID_LISTA_CANCION IN T_LISTA_CANCION.ID_LISTA_CANCION%TYPE
                );
        PROCEDURE PRC_LISTA_COLA (
                P_ID_USUARIO IN T_LISTA_REPROD.ID_USUARIO%TYPE,
                P_ID_LISTA_REPROD IN T_LISTA_REPROD.ID_LISTA_REPROD%TYPE
                );
        PROCEDURE PRC_REPRODUCCION_LISTA (
                P_ID_USUARIO IN T_LISTA_REPROD.ID_USUARIO%TYPE,
                P_ID_LISTA_REPROD IN T_LISTA_REPROD.ID_LISTA_REPROD%TYPE
                );

END PKG_REPRODUCCION;
/

create or replace PACKAGE BODY       MG.PKG_REPRODUCCION AS
     /*
        NOMBRE DEL PROGRAMA : PKG_REPRODUCCION
        OBJETIVO            : CREAR LISTAS DE REPRODUCCION
        NOTAS               : 
        AUTOR               : JT
        HISTORIAL           :
        FECHA                 AUTOR            DESCRIPCION
        ======================================================================
        04/03/2020            JT              CREACION DEL PAQUETE
        */
        PROCEDURE PRC_CREAR_LISTA (
                P_ID_USUARIO IN T_LISTA_REPROD.ID_USUARIO%TYPE,
                P_LISTA IN T_LISTA_REPROD.LISTA_REPRODUCCION%TYPE
                )
        IS
            V_MENSAJE_ERROR VARCHAR2(2000);
            V_CONTADOR NUMBER;
            EXCP EXCEPTION;
            V_TIPO NUMBER;
            V_FLAG NUMBER;

       BEGIN

           -- VERIFICA SI USUARIO ESTA ACTIVO
            SELECT FLAG INTO V_FLAG
            FROM T_USUARIO
            WHERE ID_USUARIO = P_ID_USUARIO;
            IF V_FLAG != 1 THEN
                V_MENSAJE_ERROR := 'USUARIO NO EXISTENTE';
                RAISE EXCP;    
            END IF;

            -- VERIFICA SI USUARIO ES PREMIUM
            SELECT ID_TIPO_USUARIO INTO V_TIPO
            FROM T_USUARIO
            WHERE ID_USUARIO = P_ID_USUARIO;

            -- VERIFICA LAS LISTAS DE REPRODUCION
            SELECT COUNT(*)
            INTO V_CONTADOR
            FROM T_LISTA_REPROD
            WHERE ID_USUARIO = P_ID_USUARIO;

            IF V_CONTADOR = 1 AND V_TIPO = 1 THEN
                V_MENSAJE_ERROR := 'PARA TENER MAS LISTAS DE REPRODUCCION OBTEN UNA CUENTA PREMIUM';
                RAISE EXCP;
            END IF;

            -- CREA LA LISTA DE REPRODUCCION
                INSERT INTO T_LISTA_REPROD (ID_LISTA_REPROD, ID_USUARIO, LISTA_REPRODUCCION)
                VALUES (MG.SEQ_LISTA_REPROD_ID.NEXTVAL, P_ID_USUARIO, P_LISTA);

            -- CONFIRMAR LA TRANSACCION
            COMMIT;
                DBMS_OUTPUT.PUT_LINE('LISTA ' || P_LISTA || ' CREADA');

            EXCEPTION
                WHEN EXCP THEN
                    ROLLBACK;
                   DBMS_OUTPUT.PUT_LINE(V_MENSAJE_ERROR);
                WHEN OTHERS THEN
                    ROLLBACK;
                    DBMS_OUTPUT.PUT_LINE(sqlerrm);
    END PRC_CREAR_LISTA;

      /*
        NOMBRE DEL PROGRAMA : PKG_REPRODUCCION
        OBJETIVO            : MODFICAR LISTAS DE REPRODUCCION
        NOTAS               : 
        AUTOR               : JT
        HISTORIAL           :
        FECHA                 AUTOR            DESCRIPCION
        ======================================================================
        04/03/2020            JT              CREACION DEL PAQUETE
        */
    PROCEDURE PRC_MODIFICAR_LISTA (
                P_ID_LISTA_REPROD IN T_LISTA_REPROD.ID_LISTA_REPROD%TYPE,
                P_LISTA IN T_LISTA_REPROD.LISTA_REPRODUCCION%TYPE
                )
    IS
        V_MENSAJE_ERROR VARCHAR2(2000);
        V_CONTADOR NUMBER;
        EXCP EXCEPTION;
    BEGIN
        SELECT COUNT(*) INTO V_CONTADOR
        FROM T_LISTA_REPROD
        WHERE ID_LISTA_REPROD = P_ID_LISTA_REPROD;

        -- VERIFICAR SI LISTA EXISTE
        IF V_CONTADOR = 0 THEN
            V_MENSAJE_ERROR := 'NO EXISTE LISTA DE REPRODUCCION';
            RAISE EXCP;
        END IF;

        -- CAMBIA EL NOMBRE DE LA LISTA
        UPDATE T_LISTA_REPROD
            SET LISTA_REPRODUCCION = P_LISTA
            WHERE ID_LISTA_REPROD = P_ID_LISTA_REPROD;
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('TU LISTA ' || P_LISTA || ' ESTA LISTA');
         EXCEPTION
                WHEN EXCP THEN
                    ROLLBACK;
                   DBMS_OUTPUT.PUT_LINE(V_MENSAJE_ERROR);
                WHEN OTHERS THEN
                    ROLLBACK;
                    DBMS_OUTPUT.PUT_LINE(sqlerrm);
    END PRC_MODIFICAR_LISTA;

      /*
        NOMBRE DEL PROGRAMA : PKG_REPRODUCCION
        OBJETIVO            : AGREGAR CANCION A LAS LISTAS DE REPRODUCCION
        NOTAS               : 
        AUTOR               : JT
        HISTORIAL           :
        FECHA                 AUTOR            DESCRIPCION
        ======================================================================
        04/03/2020            JT              CREACION DEL PAQUETE
        */
    PROCEDURE PRC_AGREGAR_CANCION (
                P_ID_LISTA_REPROD IN T_LISTA_CANCION.ID_LISTA_REPROD%TYPE,
                P_ID_CANCION IN T_LISTA_CANCION.ID_CANCION%TYPE
                )
    IS
        V_MENSAJE_ERROR VARCHAR2(2000);
        V_CONTADOR NUMBER;
        EXCP EXCEPTION;
        V_LISTA VARCHAR2(500);
        V_CANCION VARCHAR2(500);

    BEGIN

        -- VERIFICAR SI LISTA EXISTE
        SELECT COUNT(*) INTO V_CONTADOR
        FROM T_LISTA_REPROD
        WHERE ID_LISTA_REPROD = P_ID_LISTA_REPROD;

        IF V_CONTADOR = 0 THEN
            V_MENSAJE_ERROR := 'NO EXISTE LISTA DE REPRODUCCION';
            RAISE EXCP;
        END IF;

        -- VERIFICAR SI LA CANCION EXISTE
        SELECT COUNT(*) INTO V_CONTADOR
        FROM T_CANCION
        WHERE ID_CANCION = P_ID_CANCION;

        IF V_CONTADOR = 0 THEN
            V_MENSAJE_ERROR := 'NO EXISTE CANCION';
            RAISE EXCP;
        END IF;

        -- VERIFICAR SI LA CANCION EXISTE EN LA LISTA
        SELECT COUNT(*) INTO V_CONTADOR
        FROM T_LISTA_CANCION
        WHERE ID_LISTA_REPROD = P_ID_LISTA_REPROD AND ID_CANCION = P_ID_CANCION;

        IF V_CONTADOR > 0 THEN
             V_MENSAJE_ERROR := 'ESTA CANCION EXISTE EN TU LISTA';
            RAISE EXCP;
        END IF;

        -- CAPTURAR NOMBRES
        SELECT CANCION INTO V_CANCION
        FROM T_CANCION
        WHERE ID_CANCION = P_ID_CANCION;

        SELECT LISTA_REPRODUCCION INTO V_LISTA
        FROM T_LISTA_REPROD
        WHERE ID_LISTA_REPROD = P_ID_LISTA_REPROD;

        -- INSERTA CANCION EN LA LISTA
        INSERT INTO T_LISTA_CANCION (ID_LISTA_CANCION, ID_LISTA_REPROD, ID_CANCION)
            VALUES (MG.SEQ_LISTA_CANCION_ID.NEXTVAL, P_ID_LISTA_REPROD, P_ID_CANCION);
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('CANCION ' || V_CANCION || ' AGREGADA A ' || V_LISTA);

        EXCEPTION
            WHEN EXCP THEN
                ROLLBACK;
                DBMS_OUTPUT.PUT_LINE(V_MENSAJE_ERROR);
            WHEN OTHERS THEN
                ROLLBACK;
                DBMS_OUTPUT.PUT_LINE(sqlerrm);

    END PRC_AGREGAR_CANCION;

    /*
        NOMBRE DEL PROGRAMA : PKG_REPRODUCCION
        OBJETIVO            : ELIMINAR CANCION A LAS LISTAS DE REPRODUCCION
        NOTAS               : 
        AUTOR               : JT
        HISTORIAL           :
        FECHA                 AUTOR            DESCRIPCION
        ======================================================================
        04/03/2020            JT              CREACION DEL PAQUETE
        */
    PROCEDURE PRC_ELIMINAR_CANCION (
                P_ID_LISTA_CANCION IN T_LISTA_CANCION.ID_LISTA_CANCION%TYPE
                )
    IS
        V_MENSAJE_ERROR VARCHAR2(2000);
        V_CONTADOR NUMBER;
        EXCP EXCEPTION;
        V_LISTA VARCHAR2(500);
        V_CANCION VARCHAR2(500);

    BEGIN

        -- VERIFICAR SI LA CANCION EXISTE EN LA LISTA
        SELECT COUNT(*) INTO V_CONTADOR
        FROM T_LISTA_CANCION
        WHERE ID_LISTA_CANCION = P_ID_LISTA_CANCION;

        IF V_CONTADOR = 0 THEN
             V_MENSAJE_ERROR := 'ESTA CANCION NO EXISTE EN TU LISTA';
            RAISE EXCP;
        END IF;

        -- CAPTURAR NOMBRES
        SELECT C.CANCION INTO V_CANCION
        FROM T_LISTA_CANCION L
        LEFT JOIN T_CANCION C ON L.ID_CANCION = C.ID_CANCION
        WHERE ID_LISTA_CANCION = P_ID_LISTA_CANCION;

        SELECT R.LISTA_REPRODUCCION INTO V_LISTA
        FROM T_LISTA_CANCION L
        LEFT JOIN T_LISTA_REPROD R ON L.ID_LISTA_REPROD = R.ID_LISTA_REPROD
        WHERE ID_LISTA_CANCION = P_ID_LISTA_CANCION;

        -- ELIMINAR CANCION EN LA LISTA
        DELETE T_LISTA_CANCION
            WHERE ID_LISTA_CANCION = P_ID_LISTA_CANCION;
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('CANCION ' || V_CANCION || ' ELIMINADA DE ' || V_LISTA);

        EXCEPTION
            WHEN EXCP THEN
                ROLLBACK;
                DBMS_OUTPUT.PUT_LINE(V_MENSAJE_ERROR);
            WHEN OTHERS THEN
                ROLLBACK;
                DBMS_OUTPUT.PUT_LINE(sqlerrm);

    END PRC_ELIMINAR_CANCION;

       /*
        NOMBRE DEL PROGRAMA : PKG_REPRODUCCION
        OBJETIVO            : PONER EN COLA CANCION DE LAS LISTAS DE REPRODUCCION
        NOTAS               : 
        AUTOR               : JT
        HISTORIAL           :
        FECHA                 AUTOR            DESCRIPCION
        ======================================================================
        04/03/2020            JT              CREACION DEL PAQUETE
        */
    PROCEDURE PRC_LISTA_COLA (
                P_ID_USUARIO IN T_LISTA_REPROD.ID_USUARIO%TYPE,
                P_ID_LISTA_REPROD IN T_LISTA_REPROD.ID_LISTA_REPROD%TYPE
                )
    IS
        V_TIPO NUMBER;
        V_TRUNCATE VARCHAR2(4000);
        
    BEGIN
        -- VERIFICAR TIPO DE USUARIO
        SELECT ID_TIPO_USUARIO INTO V_TIPO
        FROM T_USUARIO
        WHERE ID_USUARIO = P_ID_USUARIO;
        
        V_TRUNCATE := 'TRUNCATE TABLE T_TMP_COLA_REPROD';
        
        EXECUTE IMMEDIATE(V_TRUNCATE);

        IF V_TIPO = 1 THEN
            INSERT INTO T_TMP_COLA_REPROD
                SELECT L.ID_CANCION, C.CANCION, A.ARTISTA
                    FROM T_LISTA_CANCION L
                    LEFT JOIN T_CANCION C ON L.ID_CANCION = C.ID_CANCION
                    LEFT JOIN T_ARTISTA A ON C.ID_ARTISTA = A.ID_ARTISTA
                    WHERE L.ID_LISTA_REPROD = P_ID_LISTA_REPROD
                    ORDER BY DBMS_RANDOM.VALUE;
        ELSE
             INSERT INTO T_TMP_COLA_REPROD
                SELECT L.ID_CANCION, C.CANCION, A.ARTISTA
                    FROM T_LISTA_CANCION L
                    LEFT JOIN T_CANCION C ON L.ID_CANCION = C.ID_CANCION
                    LEFT JOIN T_ARTISTA A ON C.ID_ARTISTA = A.ID_ARTISTA
                    WHERE L.ID_LISTA_REPROD = P_ID_LISTA_REPROD;
        END IF;
        COMMIT;
    END PRC_LISTA_COLA;

    /*
        NOMBRE DEL PROGRAMA : PKG_REPRODUCCION
        OBJETIVO            : REPRODUCIR CANCION DE LAS LISTAS DE REPRODUCCION
        NOTAS               : 
        AUTOR               : JT
        HISTORIAL           :
        FECHA                 AUTOR            DESCRIPCION
        ======================================================================
        04/03/2020            JT              CREACION DEL PAQUETE
        */
    PROCEDURE PRC_REPRODUCCION_LISTA (
                P_ID_USUARIO IN T_LISTA_REPROD.ID_USUARIO%TYPE,
                P_ID_LISTA_REPROD IN T_LISTA_REPROD.ID_LISTA_REPROD%TYPE
                )
    IS
        V_LISTA VARCHAR2(100);
        V_MENSAJE VARCHAR2(100);
        V_TIPO NUMBER;
        CURSOR V_REPRODUCCION IS SELECT * FROM MG.T_TMP_COLA_REPROD;
    BEGIN

        -- VERIFICAR TIPO DE USUARIO
            SELECT ID_TIPO_USUARIO INTO V_TIPO
            FROM T_USUARIO
            WHERE ID_USUARIO = P_ID_USUARIO;

        -- NOMBRE DE LA LISTA DE REPRODUCCION
        SELECT LISTA_REPRODUCCION INTO V_LISTA
            FROM T_LISTA_REPROD L
            WHERE ID_LISTA_REPROD = P_ID_LISTA_REPROD;
        DBMS_OUTPUT.PUT_LINE(V_LISTA || ' SE ESTÃ? REPRODUCIENDO');

        -- MENSAJE
        IF V_TIPO = 1 THEN
            V_MENSAJE := 'PUBLICIDAD';
        END IF;
        FOR r in V_REPRODUCCION LOOP
            DBMS_OUTPUT.PUT_LINE(r.ID_LISTA_CANCION || '     |     ' || r.CANCION || '     |     ' || r.ARTISTA);
            DBMS_OUTPUT.PUT_LINE(V_MENSAJE);
        END LOOP;
    END PRC_REPRODUCCION_LISTA;

END PKG_REPRODUCCION;