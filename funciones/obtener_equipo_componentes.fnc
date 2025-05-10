CREATE OR REPLACE FUNCTION obtener_equipo_y_componentes(
    p_numero_equipo NUMBER
) RETURN SYS_REFCURSOR IS
    v_cursor SYS_REFCURSOR;
BEGIN
    OPEN v_cursor FOR
        SELECT e.id AS equipo_id, e.estado_id, 
               t.n_bien AS torre_bien, t.marca AS torre_marca, t.modelo AS torre_modelo,
               m.n_bien AS monitor_bien, m.marca AS monitor_marca, m.modelo AS monitor_modelo,
               te.n_bien AS teclado_bien, te.marca AS teclado_marca, te.modelo AS teclado_modelo,
               r.n_bien AS raton_bien, r.marca AS raton_marca, r.modelo AS raton_modelo,
               o.dispositivo AS otro_dispositivo, o.n_bien AS otro_bien, o.marca AS otro_marca, o.modelo AS otro_modelo
        FROM equipos e
        LEFT JOIN torres t ON e.torre_id = t.id
        LEFT JOIN monitores m ON e.monitor_id = m.id
        LEFT JOIN teclados te ON e.teclado_id = te.id
        LEFT JOIN ratones r ON e.raton_id = r.id
        LEFT JOIN otros o ON e.otro_id = o.id
        WHERE e.id = p_numero_equipo;

    IF v_cursor%ISOPEN THEN
        RETURN v_cursor;
    ELSE
        RAISE_APPLICATION_ERROR(-20001, 'No se encontr� informaci�n para el equipo proporcionado.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20002, 'Ocurri� un error al obtener la informaci�n del equipo y sus componentes.');
END;
