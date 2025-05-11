CREATE OR REPLACE FUNCTION obtener_equipo_y_componentes(
    p_numero_equipo NUMBER
) RETURN SYS_REFCURSOR IS
    v_cursor SYS_REFCURSOR;
    v_mensaje VARCHAR2(200);
BEGIN
    OPEN v_cursor FOR
        SELECT e.id AS equipo_id, e.estado_id, 
               t.n_bien AS torre_bien, t.marca AS torre_marca, t.modelo AS torre_modelo, t.procesador AS torre_procesador,
               m.n_bien AS monitor_bien, m.marca AS monitor_marca, m.modelo AS monitor_modelo,
               te.n_bien AS teclado_bien, te.marca AS teclado_marca, te.modelo AS teclado_modelo,
               r.n_bien AS raton_bien, r.marca AS raton_marca, r.modelo AS raton_modelo,
               o.dispositivo AS otro_dispositivo, o.n_bien AS otro_bien, o.marca AS otro_marca, o.modelo AS otro_modelo,
               d.disco_duro AS torre_disco, mem.capacidad AS torre_memoria
        FROM equipos e
        LEFT JOIN torres t ON e.torre_id = t.id
        LEFT JOIN discos d ON t.discoduro_id = d.id
        LEFT JOIN memorias mem ON t.memoria_id = mem.id
        LEFT JOIN monitores m ON e.monitor_id = m.id
        LEFT JOIN teclados te ON e.teclado_id = te.id
        LEFT JOIN ratones r ON e.raton_id = r.id
        LEFT JOIN otros o ON e.otro_id = o.id
        WHERE e.id = p_numero_equipo;

    v_mensaje := 'Éxito: Información del equipo obtenida correctamente.';
    DBMS_OUTPUT.PUT_LINE(v_mensaje);

    FOR rec IN (SELECT e.id AS equipo_id, e.estado_id, 
                       t.n_bien AS torre_bien, t.marca AS torre_marca, t.modelo AS torre_modelo, t.procesador AS torre_procesador,
                       m.n_bien AS monitor_bien, m.marca AS monitor_marca, m.modelo AS monitor_modelo,
                       te.n_bien AS teclado_bien, te.marca AS teclado_marca, te.modelo AS teclado_modelo,
                       r.n_bien AS raton_bien, r.marca AS raton_marca, r.modelo AS raton_modelo,
                       o.dispositivo AS otro_dispositivo, o.n_bien AS otro_bien, o.marca AS otro_marca, o.modelo AS otro_modelo,
                       d.disco_duro AS torre_disco, mem.capacidad AS torre_memoria
                FROM equipos e
                LEFT JOIN torres t ON e.torre_id = t.id
                LEFT JOIN discos d ON t.discoduro_id = d.id
                LEFT JOIN memorias mem ON t.memoria_id = mem.id
                LEFT JOIN monitores m ON e.monitor_id = m.id
                LEFT JOIN teclados te ON e.teclado_id = te.id
                LEFT JOIN ratones r ON e.raton_id = r.id
                LEFT JOIN otros o ON e.otro_id = o.id
                WHERE e.id = p_numero_equipo) LOOP
        DBMS_OUTPUT.PUT_LINE('Equipo ID: ' || rec.equipo_id || ', Estado ID: ' || rec.estado_id ||
                             ', Torre: ' || rec.torre_bien || ' (' || rec.torre_marca || ', ' || rec.torre_modelo || ', ' || rec.torre_procesador || ', Disco: ' || rec.torre_disco || ', Memoria: ' || rec.torre_memoria || ')' ||
                             ', Monitor: ' || rec.monitor_bien || ' (' || rec.monitor_marca || ', ' || rec.monitor_modelo || ')' ||
                             ', Teclado: ' || rec.teclado_bien || ' (' || rec.teclado_marca || ', ' || rec.teclado_modelo || ')' ||
                             ', Ratón: ' || rec.raton_bien || ' (' || rec.raton_marca || ', ' || rec.raton_modelo || ')' ||
                             ', Otro: ' || rec.otro_bien || ' (' || rec.otro_dispositivo || ', ' || rec.otro_marca || ', ' || rec.otro_modelo || ')');
    END LOOP;

    RETURN v_cursor;
EXCEPTION
    WHEN OTHERS THEN
        v_mensaje := 'Error: Ocurrió un problema al obtener la información del equipo y sus componentes.';
        DBMS_OUTPUT.PUT_LINE(v_mensaje);
        RAISE_APPLICATION_ERROR(-20002, v_mensaje);
END;
/