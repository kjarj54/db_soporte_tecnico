CREATE OR REPLACE PROCEDURE insertar_usuario (
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
/
