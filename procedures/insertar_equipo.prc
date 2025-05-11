CREATE OR REPLACE PROCEDURE insertar_equipo (
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
  BEGIN
    INSERT INTO equipos (estado_id, torre_id, monitor_id, teclado_id, raton_id, otro_id)
    VALUES (p_estado_id, p_torre_id, p_monitor_id, p_teclado_id, p_raton_id, p_otro_id);

    p_mensaje := 'Equipo insertado correctamente.';
  EXCEPTION
    WHEN OTHERS THEN
      p_mensaje := 'Error al insertar el equipo: ' || SQLERRM;
  END;

END;
/
