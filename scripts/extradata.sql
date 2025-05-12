-- Primero, asegúrate de que hay un estado para equipos reparados
INSERT INTO ESTADOS (id, estado)
VALUES (3, 'Reparado')
;

-- Agregar más equipos con diferentes componentes
-- Nuevas memorias
INSERT INTO MEMORIAS (id, marca, capacidad)
VALUES (3, 'Crucial', '4GB')
;
INSERT INTO MEMORIAS (id, marca, capacidad)
VALUES (4, 'G.Skill', '32GB')
;

-- Nuevos discos
INSERT INTO DISCOS (id, disco_duro)
VALUES (3, '240GB SSD')
;
INSERT INTO DISCOS (id, disco_duro)
VALUES (4, '2TB HDD')
;

-- Nuevas torres
INSERT INTO TORRES (id, n_bien, n_serie, marca, modelo, procesador, discoduro_id, memoria_id)
VALUES (3, '003-TOR', 'SN9101', 'Lenovo', 'ThinkCentre', 'AMD Ryzen 5', 3, 3)
;
INSERT INTO TORRES (id, n_bien, n_serie, marca, modelo, procesador, discoduro_id, memoria_id)
VALUES (4, '004-TOR', 'SN1122', 'Asus', 'ProDesk', 'Intel i9', 4, 4)
;

-- Nuevos monitores
INSERT INTO MONITORES (id, n_bien, n_serie, marca, modelo)
VALUES (3, '003-MON', 'MSN789', 'Dell', 'P2419H')
;
INSERT INTO MONITORES (id, n_bien, n_serie, marca, modelo)
VALUES (4, '004-MON', 'MSN101', 'ASUS', 'ProArt')
;

-- Nuevos teclados
INSERT INTO TECLADOS (id, n_bien, n_serie, marca, modelo)
VALUES (3, '003-TECL', 'TSN789', 'Dell', 'KB216')
;
INSERT INTO TECLADOS (id, n_bien, n_serie, marca, modelo)
VALUES (4, '004-TECL', 'TSN101', 'Razer', 'BlackWidow')
;

-- Nuevos ratones
INSERT INTO RATONES (id, n_bien, n_serie, marca, modelo)
VALUES (3, '003-RAT', 'RSN789', 'Dell', 'MS116')
;
INSERT INTO RATONES (id, n_bien, n_serie, marca, modelo)
VALUES (4, '004-RAT', 'RSN101', 'Razer', 'DeathAdder')
;

-- Nuevos otros dispositivos
INSERT INTO OTROS (id, dispositivo, n_bien, n_serie, marca, modelo)
VALUES (3, 'Parlantes', '003-PAR', 'PAR123', 'Logitech', 'Z313')
;
INSERT INTO OTROS (id, dispositivo, n_bien, n_serie, marca, modelo)
VALUES (4, 'Impresora', '004-IMP', 'IMP123', 'HP', 'LaserJet Pro')
;

-- Nuevos equipos (en estado reparado)
INSERT INTO EQUIPOS (id, estado_id, torre_id, monitor_id, teclado_id, raton_id, otro_id)
VALUES (3, 3, 3, 3, 3, 3, 3)
;
INSERT INTO EQUIPOS (id, estado_id, torre_id, monitor_id, teclado_id, raton_id, otro_id)
VALUES (4, 3, 4, 4, 4, 4, 4)
;

-- Agregar actividades de reparación para estos equipos
INSERT INTO TIPOS_ACT (id, tipo)
VALUES (3, 'Reparación')
;

-- Actividades de reparación
INSERT INTO ACTIVIDADES (id, usuario_id, tipo_id, equipo_id)
VALUES (3, 1, 3, 3)
;
INSERT INTO ACTIVIDADES (id, usuario_id, tipo_id, equipo_id)
VALUES (4, 2, 3, 4)
;

-- Agregar registros de taller con fechas distintas para ordenar
INSERT INTO TALLER_ACT (id, usuario_id, actividad_id, fecha, origen, localidad, proceso, descripcion)
VALUES (3, 1, 3, TO_DATE('01-05-2025', 'DD-MM-YYYY'), 'Taller Principal', 
'Dep. Reparaciones', 'Reparación de fuente de poder', 'Se sustituyó fuente de poder defectuosa')
;

INSERT INTO TALLER_ACT (id, usuario_id, actividad_id, fecha, origen, localidad, proceso, descripcion)
VALUES (4, 2, 4, TO_DATE('05-05-2025', 'DD-MM-YYYY'), 'Taller Central', 
'Dep. Componentes', 'Sustitución de tarjeta madre', 'Se cambió la tarjeta madre por una nueva')
;

-- Actualizar historial
INSERT INTO HISTORIAL (id, actividad_id, equipo_id)
VALUES (3, 3, 3)
;
INSERT INTO HISTORIAL (id, actividad_id, equipo_id)
VALUES (4, 4, 4)
;

COMMIT;