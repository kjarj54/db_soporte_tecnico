prompt PL/SQL Developer Export Tables for user KARAUZ@192.168.0.22:1521/XEPDB1
prompt Created by kevin on domingo, 11 de mayo de 2025
set feedback off
set define off

prompt Dropping ESTADOS...
drop table ESTADOS cascade constraints;
prompt Dropping MONITORES...
drop table MONITORES cascade constraints;
prompt Dropping OTROS...
drop table OTROS cascade constraints;
prompt Dropping RATONES...
drop table RATONES cascade constraints;
prompt Dropping TECLADOS...
drop table TECLADOS cascade constraints;
prompt Dropping DISCOS...
drop table DISCOS cascade constraints;
prompt Dropping MEMORIAS...
drop table MEMORIAS cascade constraints;
prompt Dropping TORRES...
drop table TORRES cascade constraints;
prompt Dropping EQUIPOS...
drop table EQUIPOS cascade constraints;
prompt Dropping TIPOS_ACT...
drop table TIPOS_ACT cascade constraints;
prompt Dropping GENEROS...
drop table GENEROS cascade constraints;
prompt Dropping ROLES...
drop table ROLES cascade constraints;
prompt Dropping USUARIOS...
drop table USUARIOS cascade constraints;
prompt Dropping ACTIVIDADES...
drop table ACTIVIDADES cascade constraints;
prompt Dropping FEEDBACK...
drop table FEEDBACK cascade constraints;
prompt Dropping HISTORIAL...
drop table HISTORIAL cascade constraints;
prompt Dropping SOPORTE_ACT...
drop table SOPORTE_ACT cascade constraints;
prompt Dropping TALLER_ACT...
drop table TALLER_ACT cascade constraints;
prompt Creating ESTADOS...
create table ESTADOS
(
  id     NUMBER not null,
  estado VARCHAR2(30)
)
tablespace UNA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ESTADOS
  add primary key (ID)
  using index 
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating MONITORES...
create table MONITORES
(
  id      NUMBER not null,
  n_bien  VARCHAR2(30),
  n_serie VARCHAR2(30),
  marca   VARCHAR2(50),
  modelo  VARCHAR2(50)
)
tablespace UNA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table MONITORES
  add primary key (ID)
  using index 
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating OTROS...
create table OTROS
(
  id          NUMBER not null,
  dispositivo VARCHAR2(50),
  n_bien      VARCHAR2(30),
  n_serie     VARCHAR2(30),
  marca       VARCHAR2(50),
  modelo      VARCHAR2(50)
)
tablespace UNA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table OTROS
  add primary key (ID)
  using index 
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating RATONES...
create table RATONES
(
  id      NUMBER not null,
  n_bien  VARCHAR2(30),
  n_serie VARCHAR2(30),
  marca   VARCHAR2(50),
  modelo  VARCHAR2(50)
)
tablespace UNA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table RATONES
  add primary key (ID)
  using index 
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating TECLADOS...
create table TECLADOS
(
  id      NUMBER not null,
  n_bien  VARCHAR2(30),
  n_serie VARCHAR2(30),
  marca   VARCHAR2(50),
  modelo  VARCHAR2(50)
)
tablespace UNA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table TECLADOS
  add primary key (ID)
  using index 
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating DISCOS...
create table DISCOS
(
  id         NUMBER not null,
  disco_duro VARCHAR2(50)
)
tablespace UNA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DISCOS
  add primary key (ID)
  using index 
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating MEMORIAS...
create table MEMORIAS
(
  id        NUMBER not null,
  marca     VARCHAR2(50),
  capacidad VARCHAR2(20)
)
tablespace UNA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table MEMORIAS
  add primary key (ID)
  using index 
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating TORRES...
create table TORRES
(
  id           NUMBER not null,
  n_bien       VARCHAR2(30),
  n_serie      VARCHAR2(30),
  marca        VARCHAR2(50),
  modelo       VARCHAR2(50),
  procesador   VARCHAR2(50),
  discoduro_id NUMBER,
  memoria_id   NUMBER
)
tablespace UNA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table TORRES
  add primary key (ID)
  using index 
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table TORRES
  add constraint FK_TORRE_DISCO foreign key (DISCODURO_ID)
  references DISCOS (ID);
alter table TORRES
  add constraint FK_TORRE_MEMORIA foreign key (MEMORIA_ID)
  references MEMORIAS (ID);

prompt Creating EQUIPOS...
create table EQUIPOS
(
  id         NUMBER not null,
  estado_id  NUMBER,
  torre_id   NUMBER,
  monitor_id NUMBER,
  teclado_id NUMBER,
  raton_id   NUMBER,
  otro_id    NUMBER
)
tablespace UNA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EQUIPOS
  add primary key (ID)
  using index 
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EQUIPOS
  add foreign key (ESTADO_ID)
  references ESTADOS (ID);
alter table EQUIPOS
  add foreign key (TORRE_ID)
  references TORRES (ID);
alter table EQUIPOS
  add foreign key (MONITOR_ID)
  references MONITORES (ID);
alter table EQUIPOS
  add foreign key (TECLADO_ID)
  references TECLADOS (ID);
alter table EQUIPOS
  add foreign key (RATON_ID)
  references RATONES (ID);
alter table EQUIPOS
  add foreign key (OTRO_ID)
  references OTROS (ID);

prompt Creating TIPOS_ACT...
create table TIPOS_ACT
(
  id   NUMBER not null,
  tipo VARCHAR2(50)
)
tablespace UNA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table TIPOS_ACT
  add primary key (ID)
  using index 
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating GENEROS...
create table GENEROS
(
  id     NUMBER not null,
  genero VARCHAR2(20)
)
tablespace UNA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table GENEROS
  add primary key (ID)
  using index 
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating ROLES...
create table ROLES
(
  id  NUMBER not null,
  rol VARCHAR2(50)
)
tablespace UNA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ROLES
  add primary key (ID)
  using index 
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating USUARIOS...
create table USUARIOS
(
  id        NUMBER not null,
  n_usuario VARCHAR2(50),
  cedula    VARCHAR2(20),
  nombre    VARCHAR2(50),
  apellido  VARCHAR2(50),
  contra    VARCHAR2(50),
  genero_id NUMBER,
  rol_id    NUMBER,
  correo    VARCHAR2(100)
)
tablespace UNA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table USUARIOS
  add primary key (ID)
  using index 
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table USUARIOS
  add constraint FK_GENERO foreign key (GENERO_ID)
  references GENEROS (ID);
alter table USUARIOS
  add constraint FK_ROL foreign key (ROL_ID)
  references ROLES (ID);

prompt Creating ACTIVIDADES...
create table ACTIVIDADES
(
  id         NUMBER not null,
  usuario_id NUMBER,
  tipo_id    NUMBER,
  equipo_id  NUMBER
)
tablespace UNA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ACTIVIDADES
  add primary key (ID)
  using index 
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ACTIVIDADES
  add foreign key (USUARIO_ID)
  references USUARIOS (ID);
alter table ACTIVIDADES
  add foreign key (TIPO_ID)
  references TIPOS_ACT (ID);
alter table ACTIVIDADES
  add foreign key (EQUIPO_ID)
  references EQUIPOS (ID);

prompt Creating FEEDBACK...
create table FEEDBACK
(
  id          NUMBER not null,
  usuario_id  NUMBER,
  comentarios VARCHAR2(500)
)
tablespace UNA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table FEEDBACK
  add primary key (ID)
  using index 
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table FEEDBACK
  add foreign key (USUARIO_ID)
  references USUARIOS (ID);

prompt Creating HISTORIAL...
create table HISTORIAL
(
  id           NUMBER not null,
  actividad_id NUMBER,
  equipo_id    NUMBER
)
tablespace UNA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table HISTORIAL
  add primary key (ID)
  using index 
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table HISTORIAL
  add foreign key (ACTIVIDAD_ID)
  references ACTIVIDADES (ID);
alter table HISTORIAL
  add foreign key (EQUIPO_ID)
  references EQUIPOS (ID);

prompt Creating SOPORTE_ACT...
create table SOPORTE_ACT
(
  id              NUMBER not null,
  usuario_id      NUMBER,
  actividad_id    NUMBER,
  tipo_id         NUMBER,
  fecha           DATE,
  origen          VARCHAR2(100),
  localidad       VARCHAR2(100),
  atencion        VARCHAR2(100),
  descripcion     VARCHAR2(500),
  tiempo_solucion INTERVAL DAY(2) TO SECOND(6),
  solucion        VARCHAR2(500)
)
tablespace UNA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SOPORTE_ACT
  add primary key (ID)
  using index 
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SOPORTE_ACT
  add foreign key (USUARIO_ID)
  references USUARIOS (ID);
alter table SOPORTE_ACT
  add foreign key (ACTIVIDAD_ID)
  references ACTIVIDADES (ID);
alter table SOPORTE_ACT
  add foreign key (TIPO_ID)
  references TIPOS_ACT (ID);

prompt Creating TALLER_ACT...
create table TALLER_ACT
(
  id           NUMBER not null,
  usuario_id   NUMBER,
  actividad_id NUMBER,
  fecha        DATE,
  origen       VARCHAR2(100),
  localidad    VARCHAR2(100),
  proceso      VARCHAR2(500),
  descripcion  VARCHAR2(500)
)
tablespace UNA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table TALLER_ACT
  add primary key (ID)
  using index 
  tablespace UNA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table TALLER_ACT
  add foreign key (USUARIO_ID)
  references USUARIOS (ID);
alter table TALLER_ACT
  add foreign key (ACTIVIDAD_ID)
  references ACTIVIDADES (ID);

prompt Loading ESTADOS...
insert into ESTADOS (id, estado)
values (1, 'Activo');
insert into ESTADOS (id, estado)
values (2, 'En Reparaci�n');
insert into ESTADOS (id, estado)
values (3, 'Reparado');
commit;
prompt 3 records loaded
prompt Loading MONITORES...
insert into MONITORES (id, n_bien, n_serie, marca, modelo)
values (1, '001-MON', 'MSN123', 'Samsung', 'S22');
insert into MONITORES (id, n_bien, n_serie, marca, modelo)
values (2, '002-MON', 'MSN456', 'LG', 'UltraFine');
insert into MONITORES (id, n_bien, n_serie, marca, modelo)
values (3, '003-MON', 'MSN789', 'Dell', 'P2419H');
insert into MONITORES (id, n_bien, n_serie, marca, modelo)
values (4, '004-MON', 'MSN101', 'ASUS', 'ProArt');
commit;
prompt 4 records loaded
prompt Loading OTROS...
insert into OTROS (id, dispositivo, n_bien, n_serie, marca, modelo)
values (1, 'UPS', '001-UPS', 'UPS123', 'APC', 'Back-UPS');
insert into OTROS (id, dispositivo, n_bien, n_serie, marca, modelo)
values (2, 'Webcam', '002-CAM', 'CAM123', 'Logitech', 'C920');
insert into OTROS (id, dispositivo, n_bien, n_serie, marca, modelo)
values (3, 'Parlantes', '003-PAR', 'PAR123', 'Logitech', 'Z313');
insert into OTROS (id, dispositivo, n_bien, n_serie, marca, modelo)
values (4, 'Impresora', '004-IMP', 'IMP123', 'HP', 'LaserJet Pro');
commit;
prompt 4 records loaded
prompt Loading RATONES...
insert into RATONES (id, n_bien, n_serie, marca, modelo)
values (1, '001-RAT', 'RSN123', 'Genius', 'DX-110');
insert into RATONES (id, n_bien, n_serie, marca, modelo)
values (2, '002-RAT', 'RSN456', 'HP', 'X3000');
insert into RATONES (id, n_bien, n_serie, marca, modelo)
values (3, '003-RAT', 'RSN789', 'Dell', 'MS116');
insert into RATONES (id, n_bien, n_serie, marca, modelo)
values (4, '004-RAT', 'RSN101', 'Razer', 'DeathAdder');
commit;
prompt 4 records loaded
prompt Loading TECLADOS...
insert into TECLADOS (id, n_bien, n_serie, marca, modelo)
values (1, '001-TECL', 'TSN123', 'Logitech', 'K120');
insert into TECLADOS (id, n_bien, n_serie, marca, modelo)
values (2, '002-TECL', 'TSN456', 'Microsoft', 'Wired 600');
insert into TECLADOS (id, n_bien, n_serie, marca, modelo)
values (3, '003-TECL', 'TSN789', 'Dell', 'KB216');
insert into TECLADOS (id, n_bien, n_serie, marca, modelo)
values (4, '004-TECL', 'TSN101', 'Razer', 'BlackWidow');
commit;
prompt 4 records loaded
prompt Loading DISCOS...
insert into DISCOS (id, disco_duro)
values (1, '1TB HDD');
insert into DISCOS (id, disco_duro)
values (2, '500GB SSD');
insert into DISCOS (id, disco_duro)
values (3, '240GB SSD');
insert into DISCOS (id, disco_duro)
values (4, '2TB HDD');
commit;
prompt 4 records loaded
prompt Loading MEMORIAS...
insert into MEMORIAS (id, marca, capacidad)
values (1, 'Kingston', '8GB');
insert into MEMORIAS (id, marca, capacidad)
values (2, 'Corsair', '16GB');
insert into MEMORIAS (id, marca, capacidad)
values (3, 'Crucial', '4GB');
insert into MEMORIAS (id, marca, capacidad)
values (4, 'G.Skill', '32GB');
commit;
prompt 4 records loaded
prompt Loading TORRES...
insert into TORRES (id, n_bien, n_serie, marca, modelo, procesador, discoduro_id, memoria_id)
values (1, '001-TOR', 'SN1234', 'Dell', 'Optiplex', 'Intel i5', 1, 1);
insert into TORRES (id, n_bien, n_serie, marca, modelo, procesador, discoduro_id, memoria_id)
values (2, '002-TOR', 'SN5678', 'HP', 'EliteDesk', 'Intel i7', 2, 2);
insert into TORRES (id, n_bien, n_serie, marca, modelo, procesador, discoduro_id, memoria_id)
values (3, '003-TOR', 'SN9101', 'Lenovo', 'ThinkCentre', 'AMD Ryzen 5', 3, 3);
insert into TORRES (id, n_bien, n_serie, marca, modelo, procesador, discoduro_id, memoria_id)
values (4, '004-TOR', 'SN1122', 'Asus', 'ProDesk', 'Intel i9', 4, 4);
commit;
prompt 4 records loaded
prompt Loading EQUIPOS...
insert into EQUIPOS (id, estado_id, torre_id, monitor_id, teclado_id, raton_id, otro_id)
values (1, 1, 1, 1, 1, 1, 1);
insert into EQUIPOS (id, estado_id, torre_id, monitor_id, teclado_id, raton_id, otro_id)
values (2, 2, 2, 2, 2, 2, 2);
insert into EQUIPOS (id, estado_id, torre_id, monitor_id, teclado_id, raton_id, otro_id)
values (3, 3, 3, 3, 3, 3, 3);
insert into EQUIPOS (id, estado_id, torre_id, monitor_id, teclado_id, raton_id, otro_id)
values (4, 3, 4, 4, 4, 4, 4);
commit;
prompt 4 records loaded
prompt Loading TIPOS_ACT...
insert into TIPOS_ACT (id, tipo)
values (1, 'Soporte T�cnico');
insert into TIPOS_ACT (id, tipo)
values (2, 'Mantenimiento Taller');
insert into TIPOS_ACT (id, tipo)
values (3, 'Reparaci�n');
commit;
prompt 3 records loaded
prompt Loading GENEROS...
insert into GENEROS (id, genero)
values (1, 'Masculino');
insert into GENEROS (id, genero)
values (2, 'Femenino');
commit;
prompt 2 records loaded
prompt Loading ROLES...
insert into ROLES (id, rol)
values (1, 'Admin');
insert into ROLES (id, rol)
values (2, 'Tecnico');
commit;
prompt 2 records loaded
prompt Loading USUARIOS...
insert into USUARIOS (id, n_usuario, cedula, nombre, apellido, contra, genero_id, rol_id, correo)
values (1, 'jdoe', '1234567890', 'Juan', 'Doe', 'pass123', 1, 1, 'jdoe@email.com');
insert into USUARIOS (id, n_usuario, cedula, nombre, apellido, contra, genero_id, rol_id, correo)
values (2, 'amaria', '0987654321', 'Ana', 'Maria', 'pass456', 2, 2, 'ana@email.com');
commit;
prompt 2 records loaded
prompt Loading ACTIVIDADES...
insert into ACTIVIDADES (id, usuario_id, tipo_id, equipo_id)
values (1, 1, 1, 1);
insert into ACTIVIDADES (id, usuario_id, tipo_id, equipo_id)
values (2, 2, 2, 2);
insert into ACTIVIDADES (id, usuario_id, tipo_id, equipo_id)
values (3, 1, 3, 3);
insert into ACTIVIDADES (id, usuario_id, tipo_id, equipo_id)
values (4, 2, 3, 4);
commit;
prompt 4 records loaded
prompt Loading FEEDBACK...
insert into FEEDBACK (id, usuario_id, comentarios)
values (1, 1, 'Excelente atenci�n del t�cnico');
insert into FEEDBACK (id, usuario_id, comentarios)
values (2, 2, 'Reparaci�n r�pida y efectiva');
commit;
prompt 2 records loaded
prompt Loading HISTORIAL...
insert into HISTORIAL (id, actividad_id, equipo_id)
values (1, 1, 1);
insert into HISTORIAL (id, actividad_id, equipo_id)
values (2, 2, 2);
insert into HISTORIAL (id, actividad_id, equipo_id)
values (3, 3, 3);
insert into HISTORIAL (id, actividad_id, equipo_id)
values (4, 4, 4);
commit;
prompt 4 records loaded
prompt Loading SOPORTE_ACT...
insert into SOPORTE_ACT (id, usuario_id, actividad_id, tipo_id, fecha, origen, localidad, atencion, descripcion, tiempo_solucion, solucion)
values (1, 1, 1, 1, to_date('12-05-2025 00:03:05', 'dd-mm-yyyy hh24:mi:ss'), 'Usuario Final', 'Oficina A', 'Soporte presencial', 'Revisar conexi�n red.', '+00 01:00:00.000000', 'Cable da�ado reemplazado');
insert into SOPORTE_ACT (id, usuario_id, actividad_id, tipo_id, fecha, origen, localidad, atencion, descripcion, tiempo_solucion, solucion)
values (2, 2, 1, 1, to_date('12-05-2025 00:03:05', 'dd-mm-yyyy hh24:mi:ss'), 'Usuario Final', 'Oficina B', 'Remoto', 'Problemas de sonido.', '+00 00:30:00.000000', 'Reinstalaci�n de drivers');
commit;
prompt 2 records loaded
prompt Loading TALLER_ACT...
insert into TALLER_ACT (id, usuario_id, actividad_id, fecha, origen, localidad, proceso, descripcion)
values (1, 1, 2, to_date('12-05-2025 00:03:05', 'dd-mm-yyyy hh24:mi:ss'), 'Taller Central', 'Dep. Mantenimiento', 'Revisi�n completa', 'Se reemplaz� ventilador');
insert into TALLER_ACT (id, usuario_id, actividad_id, fecha, origen, localidad, proceso, descripcion)
values (2, 2, 2, to_date('12-05-2025 00:03:05', 'dd-mm-yyyy hh24:mi:ss'), 'Taller Secundario', 'Dep. T�cnico', 'Limpieza interna', 'Eliminaci�n de polvo');
insert into TALLER_ACT (id, usuario_id, actividad_id, fecha, origen, localidad, proceso, descripcion)
values (3, 1, 3, to_date('01-05-2025', 'dd-mm-yyyy'), 'Taller Principal', 'Dep. Reparaciones', 'Reparaci�n de fuente de poder', 'Se sustituy� fuente de poder defectuosa');
insert into TALLER_ACT (id, usuario_id, actividad_id, fecha, origen, localidad, proceso, descripcion)
values (4, 2, 4, to_date('05-05-2025', 'dd-mm-yyyy'), 'Taller Central', 'Dep. Componentes', 'Sustituci�n de tarjeta madre', 'Se cambi� la tarjeta madre por una nueva');
commit;
prompt 4 records loaded

set feedback on
set define on
prompt Done
