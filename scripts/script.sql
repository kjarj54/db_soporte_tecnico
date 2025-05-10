
-- Crear todas las tablas necesarias
CREATE TABLE generos (
    id NUMBER PRIMARY KEY,
    genero VARCHAR2(20)
);

CREATE TABLE roles (
    id NUMBER PRIMARY KEY,
    rol VARCHAR2(50)
);

CREATE TABLE usuarios (
    id NUMBER PRIMARY KEY,
    n_usuario VARCHAR2(50),
    cedula VARCHAR2(20),
    nombre VARCHAR2(50),
    apellido VARCHAR2(50),
    contra VARCHAR2(50),
    genero_id NUMBER,
    rol_id NUMBER,
    correo VARCHAR2(100),
    CONSTRAINT fk_genero FOREIGN KEY (genero_id) REFERENCES generos(id),
    CONSTRAINT fk_rol FOREIGN KEY (rol_id) REFERENCES roles(id)
);

CREATE TABLE estados (
    id NUMBER PRIMARY KEY,
    estado VARCHAR2(30)
);

CREATE TABLE memorias (
    id NUMBER PRIMARY KEY,
    marca VARCHAR2(50),
    capacidad VARCHAR2(20)
);

CREATE TABLE discos (
    id NUMBER PRIMARY KEY,
    disco_duro VARCHAR2(50)
);

CREATE TABLE torres (
    id NUMBER PRIMARY KEY,
    n_bien VARCHAR2(30),
    n_serie VARCHAR2(30),
    marca VARCHAR2(50),
    modelo VARCHAR2(50),
    procesador VARCHAR2(50),
    discoduro_id NUMBER,
    memoria_id NUMBER,
    CONSTRAINT fk_torre_disco FOREIGN KEY (discoduro_id) REFERENCES discos(id),
    CONSTRAINT fk_torre_memoria FOREIGN KEY (memoria_id) REFERENCES memorias(id)
);

CREATE TABLE monitores (
    id NUMBER PRIMARY KEY,
    n_bien VARCHAR2(30),
    n_serie VARCHAR2(30),
    marca VARCHAR2(50),
    modelo VARCHAR2(50)
);

CREATE TABLE teclados (
    id NUMBER PRIMARY KEY,
    n_bien VARCHAR2(30),
    n_serie VARCHAR2(30),
    marca VARCHAR2(50),
    modelo VARCHAR2(50)
);

CREATE TABLE ratones (
    id NUMBER PRIMARY KEY,
    n_bien VARCHAR2(30),
    n_serie VARCHAR2(30),
    marca VARCHAR2(50),
    modelo VARCHAR2(50)
);

CREATE TABLE Otros (
    id NUMBER PRIMARY KEY,
    dispositivo VARCHAR2(50),
    n_bien VARCHAR2(30),
    n_serie VARCHAR2(30),
    marca VARCHAR2(50),
    modelo VARCHAR2(50)
);

CREATE TABLE equipos (
    id NUMBER PRIMARY KEY,
    estado_id NUMBER,
    torre_id NUMBER,
    monitor_id NUMBER,
    teclado_id NUMBER,
    raton_id NUMBER,
    otro_id NUMBER,
    FOREIGN KEY (estado_id) REFERENCES estados(id),
    FOREIGN KEY (torre_id) REFERENCES torres(id),
    FOREIGN KEY (monitor_id) REFERENCES monitores(id),
    FOREIGN KEY (teclado_id) REFERENCES teclados(id),
    FOREIGN KEY (raton_id) REFERENCES ratones(id),
    FOREIGN KEY (otro_id) REFERENCES Otros(id)
);

CREATE TABLE tipos_act (
    id NUMBER PRIMARY KEY,
    tipo VARCHAR2(50)
);

CREATE TABLE actividades (
    id NUMBER PRIMARY KEY,
    usuario_id NUMBER,
    tipo_id NUMBER,
    equipo_id NUMBER,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (tipo_id) REFERENCES tipos_act(id),
    FOREIGN KEY (equipo_id) REFERENCES equipos(id)
);

CREATE TABLE historial (
    id NUMBER PRIMARY KEY,
    actividad_id NUMBER,
    equipo_id NUMBER,
    FOREIGN KEY (actividad_id) REFERENCES actividades(id),
    FOREIGN KEY (equipo_id) REFERENCES equipos(id)
);

CREATE TABLE soporte_act (
    id NUMBER PRIMARY KEY,
    usuario_id NUMBER,
    actividad_id NUMBER,
    tipo_id NUMBER,
    fecha DATE,
    origen VARCHAR2(100),
    localidad VARCHAR2(100),
    atencion VARCHAR2(100),
    descripcion VARCHAR2(500),
    tiempo_solucion INTERVAL DAY TO SECOND,
    solucion VARCHAR2(500),
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (actividad_id) REFERENCES actividades(id),
    FOREIGN KEY (tipo_id) REFERENCES tipos_act(id)
);

CREATE TABLE taller_act (
    id NUMBER PRIMARY KEY,
    usuario_id NUMBER,
    actividad_id NUMBER,
    fecha DATE,
    origen VARCHAR2(100),
    localidad VARCHAR2(100),
    proceso VARCHAR2(500),
    descripcion VARCHAR2(500),
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (actividad_id) REFERENCES actividades(id)
);

CREATE TABLE feedback (
    id NUMBER PRIMARY KEY,
    usuario_id NUMBER,
    comentarios VARCHAR2(500),
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

-- Por cada tabla con ID autogenerado
BEGIN
    FOR t IN (
        SELECT table_name FROM user_tables 
        WHERE table_name IN (
            'GENEROS','ROLES','USUARIOS','ESTADOS','MEMORIAS','DISCOS',
            'TORRES','MONITORES','TECLADOS','RATONES','OTROS','EQUIPOS',
            'TIPOS_ACT','ACTIVIDADES','HISTORIAL','SOPORTE_ACT','TALLER_ACT','FEEDBACK'
        )
    ) LOOP
        EXECUTE IMMEDIATE 'CREATE SEQUENCE seq_' || LOWER(t.table_name) || ' START WITH 1 INCREMENT BY 1';
        EXECUTE IMMEDIATE '
            CREATE OR REPLACE TRIGGER trg_' || LOWER(t.table_name) || '_id
            BEFORE INSERT ON ' || t.table_name || '
            FOR EACH ROW
            WHEN (NEW.id IS NULL)
            BEGIN
                SELECT seq_' || LOWER(t.table_name) || '.NEXTVAL INTO :NEW.id FROM dual;
            END;';
    END LOOP;
END;
/

-- generos
INSERT INTO generos (genero) VALUES ('Masculino');
INSERT INTO generos (genero) VALUES ('Femenino');

-- roles
INSERT INTO roles (rol) VALUES ('Admin');
INSERT INTO roles (rol) VALUES ('Tecnico');

-- usuarios
INSERT INTO usuarios (n_usuario, cedula, nombre, apellido, contra, genero_id, rol_id, correo)
VALUES ('jdoe', '1234567890', 'Juan', 'Doe', 'pass123', 1, 1, 'jdoe@email.com');
INSERT INTO usuarios (n_usuario, cedula, nombre, apellido, contra, genero_id, rol_id, correo)
VALUES ('amaria', '0987654321', 'Ana', 'Maria', 'pass456', 2, 2, 'ana@email.com');

-- estados
INSERT INTO estados (estado) VALUES ('Activo');
INSERT INTO estados (estado) VALUES ('En Reparación');

-- memorias
INSERT INTO memorias (marca, capacidad) VALUES ('Kingston', '8GB');
INSERT INTO memorias (marca, capacidad) VALUES ('Corsair', '16GB');

-- discos
INSERT INTO discos (disco_duro) VALUES ('1TB HDD');
INSERT INTO discos (disco_duro) VALUES ('500GB SSD');

-- torres
INSERT INTO torres (n_bien, n_serie, marca, modelo, procesador, discoduro_id, memoria_id)
VALUES ('001-TOR', 'SN1234', 'Dell', 'Optiplex', 'Intel i5', 1, 1);
INSERT INTO torres (n_bien, n_serie, marca, modelo, procesador, discoduro_id, memoria_id)
VALUES ('002-TOR', 'SN5678', 'HP', 'EliteDesk', 'Intel i7', 2, 2);

-- monitores
INSERT INTO monitores (n_bien, n_serie, marca, modelo) VALUES ('001-MON', 'MSN123', 'Samsung', 'S22');
INSERT INTO monitores (n_bien, n_serie, marca, modelo) VALUES ('002-MON', 'MSN456', 'LG', 'UltraFine');

-- teclados
INSERT INTO teclados (n_bien, n_serie, marca, modelo) VALUES ('001-TECL', 'TSN123', 'Logitech', 'K120');
INSERT INTO teclados (n_bien, n_serie, marca, modelo) VALUES ('002-TECL', 'TSN456', 'Microsoft', 'Wired 600');

-- ratones
INSERT INTO ratones (n_bien, n_serie, marca, modelo) VALUES ('001-RAT', 'RSN123', 'Genius', 'DX-110');
INSERT INTO ratones (n_bien, n_serie, marca, modelo) VALUES ('002-RAT', 'RSN456', 'HP', 'X3000');

-- otros
INSERT INTO otros (dispositivo, n_bien, n_serie, marca, modelo) VALUES ('UPS', '001-UPS', 'UPS123', 'APC', 'Back-UPS');
INSERT INTO otros (dispositivo, n_bien, n_serie, marca, modelo) VALUES ('Webcam', '002-CAM', 'CAM123', 'Logitech', 'C920');

-- equipos
INSERT INTO equipos (estado_id, torre_id, monitor_id, teclado_id, raton_id, otro_id)
VALUES (1, 1, 1, 1, 1, 1);
INSERT INTO equipos (estado_id, torre_id, monitor_id, teclado_id, raton_id, otro_id)
VALUES (2, 2, 2, 2, 2, 2);

-- tipos_act
INSERT INTO tipos_act (tipo) VALUES ('Soporte Técnico');
INSERT INTO tipos_act (tipo) VALUES ('Mantenimiento Taller');

-- actividades
INSERT INTO actividades (usuario_id, tipo_id, equipo_id) VALUES (1, 1, 1);
INSERT INTO actividades (usuario_id, tipo_id, equipo_id) VALUES (2, 2, 2);

-- historial
INSERT INTO historial (actividad_id, equipo_id) VALUES (1, 1);
INSERT INTO historial (actividad_id, equipo_id) VALUES (2, 2);

-- soporte_act
INSERT INTO soporte_act (usuario_id, actividad_id, tipo_id, fecha, origen, localidad, atencion, descripcion, tiempo_solucion, solucion)
VALUES (1, 1, 1, SYSDATE, 'Usuario Final', 'Oficina A', 'Soporte presencial', 'Revisar conexión red.', INTERVAL '1' HOUR, 'Cable dañado reemplazado');
INSERT INTO soporte_act (usuario_id, actividad_id, tipo_id, fecha, origen, localidad, atencion, descripcion, tiempo_solucion, solucion)
VALUES (2, 1, 1, SYSDATE, 'Usuario Final', 'Oficina B', 'Remoto', 'Problemas de sonido.', INTERVAL '30' MINUTE, 'Reinstalación de drivers');

-- taller_act
INSERT INTO taller_act (usuario_id, actividad_id, fecha, origen, localidad, proceso, descripcion)
VALUES (1, 2, SYSDATE, 'Taller Central', 'Dep. Mantenimiento', 'Revisión completa', 'Se reemplazó ventilador');
INSERT INTO taller_act (usuario_id, actividad_id, fecha, origen, localidad, proceso, descripcion)
VALUES (2, 2, SYSDATE, 'Taller Secundario', 'Dep. Técnico', 'Limpieza interna', 'Eliminación de polvo');

-- feedback
INSERT INTO feedback (usuario_id, comentarios)
VALUES (1, 'Excelente atención del técnico');
INSERT INTO feedback (usuario_id, comentarios)
VALUES (2, 'Reparación rápida y efectiva');


