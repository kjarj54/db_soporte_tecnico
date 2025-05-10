CREATE OR REPLACE FUNCTION obtener_reparaciones_taller(
    p_fecha DATE,
    p_numero_equipo NUMBER
) RETURN SYS_REFCURSOR IS
    v_cursor SYS_REFCURSOR;
BEGIN
    OPEN v_cursor FOR
        SELECT ta.id, ta.usuario_id, ta.actividad_id, ta.fecha, ta.origen, ta.localidad, 
               ta.proceso, ta.descripcion
        FROM taller_act ta
        JOIN actividades a ON ta.actividad_id = a.id
        WHERE a.equipo_id = p_numero_equipo
          AND TRUNC(ta.fecha) = TRUNC(p_fecha);

    RETURN v_cursor;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20001, 'No se encontraron reparaciones para el equipo en la fecha proporcionada.');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20002, 'Ocurri� un error al obtener las reparaciones.');
END;
