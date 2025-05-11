create or replace package PACK_REPARACIONES is

  -- Author  : KEVIN
  -- Created : 08/05/2025 09:54:00 p. m.
  -- Purpose : 
  
  -- Declaración de procedimientos
  PROCEDURE insertar_usuario(
    p_n_usuario IN VARCHAR2,
    p_cedula IN VARCHAR2,
    p_nombre IN VARCHAR2,
    p_apellido IN VARCHAR2,
    p_contra IN VARCHAR2,
    p_genero_id IN NUMBER,
    p_rol_id IN NUMBER,
    p_correo IN VARCHAR2,
    p_mensaje OUT VARCHAR2
  );

  PROCEDURE insertar_equipo(
    p_estado_id IN NUMBER,
    p_torre_id IN NUMBER,
    p_monitor_id IN NUMBER,
    p_teclado_id IN NUMBER,
    p_raton_id IN NUMBER,
    p_otro_id IN NUMBER,
    p_mensaje OUT VARCHAR2
  );

  PROCEDURE completar_feedback(
    p_mensaje OUT VARCHAR2
  );

  PROCEDURE reiniciar_tipos_act(
    p_tipo_id IN NUMBER,
    p_nuevo_tipo IN VARCHAR2,
    p_mensaje OUT VARCHAR2
  );

  -- Declaración de funciones
  FUNCTION obtener_equipo_y_componentes(
    p_numero_equipo IN NUMBER
  ) RETURN SYS_REFCURSOR;

  FUNCTION obtener_reparaciones_taller(
    p_fecha IN DATE,
    p_numero_equipo IN NUMBER
  ) RETURN SYS_REFCURSOR;

end PACK_REPARACIONES;
/
create or replace package body PACK_REPARACIONES is
  PROCEDURE insertar_usuario(
    p_n_usuario IN VARCHAR2,
    p_cedula IN VARCHAR2,
    p_nombre IN VARCHAR2,
    p_apellido IN VARCHAR2,
    p_contra IN VARCHAR2,
    p_genero_id IN NUMBER,
    p_rol_id IN NUMBER,
    p_correo IN VARCHAR2,
    p_mensaje OUT VARCHAR2
  ) IS
    v_count NUMBER;
  BEGIN
    BEGIN
      -- Validar que el género exista
      SELECT COUNT(id) INTO v_count FROM generos WHERE id = p_genero_id;
      IF v_count = 0 THEN
        p_mensaje := 'Error: Género no válido';
        RETURN;
      END IF;

      -- Validar que el rol exista
      SELECT COUNT(id) INTO v_count FROM roles WHERE id = p_rol_id;
      IF v_count = 0 THEN
        p_mensaje := 'Error: Rol no válido';
        RETURN;
      END IF;

      -- Insertar el usuario
      INSERT INTO usuarios (n_usuario, cedula, nombre, apellido, contra, genero_id, rol_id, correo)
      VALUES (p_n_usuario, p_cedula, p_nombre, p_apellido, p_contra, p_genero_id, p_rol_id, p_correo);

      COMMIT;
      p_mensaje := 'Usuario insertado correctamente';
    EXCEPTION
      WHEN OTHERS THEN
        ROLLBACK;
        p_mensaje := 'Error al insertar usuario: ' || SQLERRM;
    END;
  END;

  PROCEDURE insertar_equipo (
    p_estado_id   IN NUMBER,
    p_torre_id    IN NUMBER,
    p_monitor_id  IN NUMBER,
    p_teclado_id  IN NUMBER,
    p_raton_id    IN NUMBER,
    p_otro_id     IN NUMBER,
    p_mensaje     OUT VARCHAR2
  ) IS
    v_count NUMBER;
  BEGIN
    BEGIN
      -- Validar que el estado exista
      SELECT COUNT(id) INTO v_count FROM estados WHERE id = p_estado_id;
      IF v_count = 0 THEN
        p_mensaje := 'Error: El estado especificado no existe.';
        RETURN;
      END IF;

      -- Validar que la torre exista
      SELECT COUNT(id) INTO v_count FROM torres WHERE id = p_torre_id;
      IF v_count = 0 THEN
        p_mensaje := 'Error: La torre especificada no existe.';
        RETURN;
      END IF;

      -- Validar que el monitor exista
      SELECT COUNT(id) INTO v_count FROM monitores WHERE id = p_monitor_id;
      IF v_count = 0 THEN
        p_mensaje := 'Error: El monitor especificado no existe.';
        RETURN;
      END IF;

      -- Validar que el teclado exista
      SELECT COUNT(id) INTO v_count FROM teclados WHERE id = p_teclado_id;
      IF v_count = 0 THEN
        p_mensaje := 'Error: El teclado especificado no existe.';
        RETURN;
      END IF;

      -- Validar que el ratón exista
      SELECT COUNT(id) INTO v_count FROM ratones WHERE id = p_raton_id;
      IF v_count = 0 THEN
        p_mensaje := 'Error: El ratón especificado no existe.';
        RETURN;
      END IF;

      -- Validar que el dispositivo "otro" exista
      SELECT COUNT(id) INTO v_count FROM otros WHERE id = p_otro_id;
      IF v_count = 0 THEN
        p_mensaje := 'Error: El dispositivo especificado en "otro" no existe.';
        RETURN;
      END IF;

      -- Insertar el equipo
      INSERT INTO equipos (estado_id, torre_id, monitor_id, teclado_id, raton_id, otro_id)
      VALUES (p_estado_id, p_torre_id, p_monitor_id, p_teclado_id, p_raton_id, p_otro_id);

      COMMIT;
      p_mensaje := 'Equipo insertado correctamente.';
    EXCEPTION
      WHEN OTHERS THEN
        ROLLBACK;
        p_mensaje := 'Error al insertar el equipo: ' || SQLERRM;
    END;
  END;

  PROCEDURE completar_feedback (
    p_mensaje OUT VARCHAR2
  ) IS
  BEGIN
    BEGIN
      UPDATE feedback
      SET comentarios = 'Información almacenada de forma automática'
      WHERE comentarios IS NULL;

      COMMIT;
      p_mensaje := 'Comentarios completados con éxito';
    EXCEPTION
      WHEN OTHERS THEN
        ROLLBACK;
        p_mensaje := 'Error al actualizar comentarios: ' || SQLERRM;
    END;
  END;

  PROCEDURE reiniciar_tipos_act (
    p_tipo_id IN NUMBER,
    p_nuevo_tipo IN VARCHAR2,
    p_mensaje OUT VARCHAR2
  ) IS
    v_nuevo_tipo_id NUMBER;
  BEGIN
    BEGIN
      -- Validar que se proporcione un nuevo tipo
      IF p_nuevo_tipo IS NULL THEN
        p_mensaje := 'Debe proporcionar un nuevo tipo de actividad.';
        RETURN;
      END IF;

      -- Insertar el nuevo tipo de actividad y obtener su ID
      INSERT INTO TIPOS_ACT (tipo) VALUES (p_nuevo_tipo) RETURNING id INTO v_nuevo_tipo_id;

      -- Actualizar los registros dependientes en ACTIVIDADES
      UPDATE ACTIVIDADES
      SET tipo_id = v_nuevo_tipo_id
      WHERE tipo_id = p_tipo_id;

      -- Actualizar los registros dependientes en SOPORTE_ACT
      UPDATE SOPORTE_ACT
      SET tipo_id = v_nuevo_tipo_id
      WHERE tipo_id = p_tipo_id;

      -- Eliminar el tipo de actividad original
      DELETE FROM TIPOS_ACT WHERE id = p_tipo_id;

      COMMIT;
      p_mensaje := 'El tipo de actividad fue reemplazado exitosamente.';
    EXCEPTION
      WHEN OTHERS THEN
        ROLLBACK;
        p_mensaje := 'Error inesperado: ' || SQLERRM;
    END;
  END;

  FUNCTION obtener_equipo_y_componentes(
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

  FUNCTION obtener_reparaciones_taller(
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
END PACK_REPARACIONES;
/