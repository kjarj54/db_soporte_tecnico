CREATE MATERIALIZED VIEW MAT_VISEQUIPXREP
BUILD IMMEDIATE
REFRESH COMPLETE ON DEMAND
AS
SELECT 
    e.id AS equipo_id,
    est.estado AS estado_equipo,
    t.marca AS marca_torre, 
    t.modelo AS modelo_torre,
    t.procesador,
    d.disco_duro,
    m.marca AS marca_memoria, 
    m.capacidad AS capacidad_memoria,
    mon.marca AS marca_monitor, 
    mon.modelo AS modelo_monitor,
    tec.marca AS marca_teclado, 
    tec.modelo AS modelo_teclado,
    r.marca AS marca_raton, 
    r.modelo AS modelo_raton,
    o.dispositivo AS otro_dispositivo,
    o.marca AS marca_otro_dispositivo,
    o.modelo AS modelo_otro_dispositivo,
    ta.fecha AS fecha_reparacion,
    ta.proceso AS proceso_reparacion,
    ta.descripcion,
    u.nombre || ' ' || u.apellido AS tecnico_responsable
FROM 
    EQUIPOS e
    JOIN ESTADOS est ON e.estado_id = est.id
    JOIN TORRES t ON e.torre_id = t.id
    JOIN DISCOS d ON t.discoduro_id = d.id
    JOIN MEMORIAS m ON t.memoria_id = m.id
    JOIN MONITORES mon ON e.monitor_id = mon.id
    JOIN TECLADOS tec ON e.teclado_id = tec.id
    JOIN RATONES r ON e.raton_id = r.id
    JOIN OTROS o ON e.otro_id = o.id
    JOIN HISTORIAL h ON e.id = h.equipo_id
    JOIN ACTIVIDADES a ON h.actividad_id = a.id
    JOIN TALLER_ACT ta ON a.id = ta.actividad_id
    JOIN USUARIOS u ON ta.usuario_id = u.id
WHERE 
    est.estado = 'Reparado'
ORDER BY 
    ta.fecha ASC;
