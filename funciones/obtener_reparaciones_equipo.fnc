CREATE OR REPLACE FUNCTION obtener_reparaciones_taller(
    p_fecha DATE,
    p_numero_equipo NUMBER
) RETURN SYS_REFCURSOR IS
    v_cursor SYS_REFCURSOR;
    v_mensaje VARCHAR2(200);
BEGIN
    OPEN v_cursor FOR
        SELECT ta.id AS taller_id, ta.usuario_id, ta.actividad_id, ta.fecha, ta.origen, ta.localidad, 
               ta.proceso, ta.descripcion,
               a.tipo_id, t.tipo AS tipo_actividad, u.nombre AS usuario_nombre, u.apellido AS usuario_apellido
        FROM taller_act ta
        JOIN actividades a ON ta.actividad_id = a.id
        JOIN tipos_act t ON a.tipo_id = t.id
        JOIN usuarios u ON ta.usuario_id = u.id
        WHERE a.equipo_id = p_numero_equipo
          AND TRUNC(ta.fecha) = TRUNC(p_fecha);

    v_mensaje := 'Éxito: Información de reparaciones obtenida correctamente.';
    DBMS_OUTPUT.PUT_LINE(v_mensaje);

    FOR rec IN (SELECT ta.id AS taller_id, ta.usuario_id, ta.actividad_id, ta.fecha, ta.origen, ta.localidad, 
                      ta.proceso, ta.descripcion,
                      a.tipo_id, t.tipo AS tipo_actividad, u.nombre AS usuario_nombre, u.apellido AS usuario_apellido
                FROM taller_act ta
                JOIN actividades a ON ta.actividad_id = a.id
                JOIN tipos_act t ON a.tipo_id = t.id
                JOIN usuarios u ON ta.usuario_id = u.id
                WHERE a.equipo_id = p_numero_equipo
                  AND TRUNC(ta.fecha) = TRUNC(p_fecha)) LOOP
        DBMS_OUTPUT.PUT_LINE('Taller ID: ' || rec.taller_id || ', Usuario: ' || rec.usuario_nombre || ' ' || rec.usuario_apellido ||
                             ', Actividad ID: ' || rec.actividad_id || ', Fecha: ' || rec.fecha ||
                             ', Origen: ' || rec.origen || ', Localidad: ' || rec.localidad ||
                             ', Proceso: ' || rec.proceso || ', Descripción: ' || rec.descripcion ||
                             ', Tipo Actividad: ' || rec.tipo_actividad);
    END LOOP;

    RETURN v_cursor;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        v_mensaje := 'Error: No se encontraron reparaciones para el equipo en la fecha proporcionada.';
        DBMS_OUTPUT.PUT_LINE(v_mensaje);
        RAISE_APPLICATION_ERROR(-20001, v_mensaje);
    WHEN OTHERS THEN
        v_mensaje := 'Error: Ocurrió un problema al obtener las reparaciones.';
        DBMS_OUTPUT.PUT_LINE(v_mensaje);
        RAISE_APPLICATION_ERROR(-20002, v_mensaje);
END;
/