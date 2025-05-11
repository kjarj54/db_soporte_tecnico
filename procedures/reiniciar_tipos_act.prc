CREATE OR REPLACE PROCEDURE reiniciar_tipos_act (
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
/
