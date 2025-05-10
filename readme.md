# Technical Support Database System

A comprehensive Oracle database system for managing technical support operations, equipment inventory, repairs, and user management.

## Repository

[https://github.com/kjarj54/db_soporte_tecnico](https://github.com/kjarj54/db_soporte_tecnico)

## Overview

This project implements an Oracle 23c XE database for tracking and managing technical support activities, equipment inventory, repairs, and user management. It features stored procedures, functions, packages, and materialized views to efficiently handle database operations.

## Project Structure

- **scripts/** - Database creation scripts
- **procedures/** - Individual stored procedures
- **funciones/** - Database functions
- **package/** - Oracle package implementation

## Database Features

### Tables

The database includes tables for:
- Equipment components (towers, monitors, keyboards, mice)
- Users and roles management
- Support activities and repair history
- Feedback collection

### Stored Procedures

1. **insertar_equipo** - Adds new equipment with validation of foreign key relationships
2. **insertar_usuario** - Creates new users with proper role and validation
3. **reiniciar_tipos_act** - Resets activity types with proper validation
4. **completar_feedback** - Updates empty feedback comments with default text

### Functions

1. **obtener_reparaciones_taller** - Retrieves complete information about repairs by date and equipment ID
2. **obtener_equipo_componentes** - Gets detailed information about equipment and its components

### Package

All procedures and functions are encapsulated in the **PACK_REPARACIONES** package for better organization and management.

### Materialized View

The **MAT_VISEQUIPXREP** materialized view displays equipment repair information with component details, ordered by repair date in ascending order.

## Installation

1. Clone the repository:
   ```
   git clone https://github.com/kjarj54/db_soporte_tecnico.git
   ```
2. Connect to your Oracle database
3. Run the main script:
   ```
   @scripts/lab#3_4_karauz.sql
   ```
4. Execute package creation script:
   ```
   @package/PACK_REPARACIONES.pck
   ```

## Usage Examples

### Creating a New Equipment Record

```sql
DECLARE
  v_mensaje VARCHAR2(200);
BEGIN
  PACK_REPARACIONES.insertar_equipo(
    p_estado_id => 1,
    p_torre_id => 1,
    p_monitor_id => 1,
    p_teclado_id => 1,
    p_raton_id => 1,
    p_otro_id => NULL,
    p_mensaje => v_mensaje
  );
  DBMS_OUTPUT.PUT_LINE(v_mensaje);
END;
/
```

### Creating a New User

```sql
DECLARE
  v_mensaje VARCHAR2(200);
BEGIN
  PACK_REPARACIONES.insertar_usuario(
    p_n_usuario => 'username',
    p_cedula => '1234567890',
    p_nombre => 'Nombre',
    p_apellido => 'Apellido',
    p_contra => 'password',
    p_genero_id => 1,
    p_rol_id => 2,
    p_mensaje => v_mensaje
  );
  DBMS_OUTPUT.PUT_LINE(v_mensaje);
END;
/
```

### Retrieving Equipment Repair Information

```sql
DECLARE
  v_cursor SYS_REFCURSOR;
  v_mensaje VARCHAR2(200);
BEGIN
  v_cursor := PACK_REPARACIONES.obtener_reparaciones_taller(
    p_fecha => TO_DATE('2023-05-10', 'YYYY-MM-DD'),
    p_equipo_id => 1,
    p_mensaje => v_mensaje
  );
  -- Process cursor results here
  DBMS_OUTPUT.PUT_LINE(v_mensaje);
END;
/
```

### Updating Feedback Comments

```sql
DECLARE
  v_mensaje VARCHAR2(200);
BEGIN
  PACK_REPARACIONES.completar_feedback(p_mensaje => v_mensaje);
  DBMS_OUTPUT.PUT_LINE(v_mensaje);
END;
/
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.