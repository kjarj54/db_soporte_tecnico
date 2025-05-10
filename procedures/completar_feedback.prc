CREATE OR REPLACE PROCEDURE completar_feedback (
  p_mensaje OUT VARCHAR2
) IS
BEGIN
  UPDATE feedback
  SET comentarios = 'Informaci�n almacenada de forma autom�tica'
  WHERE comentarios IS NULL;

  p_mensaje := 'Comentarios completados con �xito';

EXCEPTION
  WHEN OTHERS THEN
    p_mensaje := 'Error al actualizar comentarios: ' || SQLERRM;
END;
/
