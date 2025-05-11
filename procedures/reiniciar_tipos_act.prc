CREATE OR REPLACE PROCEDURE reiniciar_tipos_act (
  p_tipo_id IN NUMBER,
  p_nuevo_tipo IN VARCHAR2,
  p_mensaje OUT VARCHAR2
) IS
  v_nuevo_tipo_id NUMBER;
BEGIN
  -- Validar que se proporcione un nuevo tipo
  IF p_nuevo_tipo IS NULL THEN
    p_mensaje := 'Debe proporcionar un nuevo tipo de actividad.';
    RETURN;
  END IF;

  -- Insertar el nuevo tipo de actividad y obtener su ID
  BEGIN
    INSERT INTO TIPOS_ACT (tipo) VALUES (p_nuevo_tipo) RETURNING id INTO v_nuevo_tipo_id;
  EXCEPTION
    WHEN OTHERS THEN
      p_mensaje := 'Error al insertar el nuevo tipo de actividad: ' || SQLERRM;
      RETURN;
  END;

  -- Actualizar los registros dependientes en ACTIVIDADES
  BEGIN
    UPDATE ACTIVIDADES
    SET tipo_id = v_nuevo_tipo_id
    WHERE tipo_id = p_tipo_id;
  EXCEPTION
    WHEN OTHERS THEN
      p_mensaje := 'Error al actualizar registros dependientes en ACTIVIDADES: ' || SQLERRM;
      RETURN;
  END;

  -- Actualizar los registros dependientes en SOPORTE_ACT
  BEGIN
    UPDATE SOPORTE_ACT
    SET tipo_id = v_nuevo_tipo_id
    WHERE tipo_id = p_tipo_id;
  EXCEPTION
    WHEN OTHERS THEN
      p_mensaje := 'Error al actualizar registros dependientes en SOPORTE_ACT: ' || SQLERRM;
      RETURN;
  END;

  -- Eliminar el tipo de actividad original
  BEGIN
    DELETE FROM TIPOS_ACT WHERE id = p_tipo_id;
  EXCEPTION
    WHEN OTHERS THEN
      p_mensaje := 'Error al eliminar el tipo de actividad original: ' || SQLERRM;
      RETURN;
  END;

  -- Mensaje de éxito
  p_mensaje := 'El tipo de actividad fue reemplazado exitosamente.';

EXCEPTION
  WHEN OTHERS THEN
    p_mensaje := 'Error inesperado: ' || SQLERRM;
END;
/
