CREATE OR REPLACE PROCEDURE completar_feedback (
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
/
