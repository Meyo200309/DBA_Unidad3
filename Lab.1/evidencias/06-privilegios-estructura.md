# actividad 6

### 1. ¿Qué tipo de evento es cada una de las tres primeras sentencias (privilegio o estructura)?
- REVOKE UPDATE ON clientes FROM soporte_ana: cambio de privilegios.
- GRANT UPDATE ON clientes TO app_ventas: cambio de privilegios.
- ALTER TABLE clientes ADD COLUMN segmento VARCHAR(20): cambio de estructura de la base de datos.

### 2. ¿Por qué GRANT y REVOKE quedan registrados con log_statement = ddl?
Porque las sentencias GRANT y REVOKE forman parte del lenguaje de definición de datos (DDL). Aunque no modifican la estructura de una tabla, sí modifican la configuración de seguridad y los permisos del sistema, por lo que se consideran eventos relevantes para la auditoría.

### 3. Si la bitácora contiene contraseñas, ¿quién debería poder leerla? Relaciónalo con la gestión de secretos de la Unidad II.
La bitácora solo debería ser accesible para administradores de bases de datos y personal autorizado de seguridad o auditoría. Si contiene contraseñas o información sensible, su acceso debe controlarse con políticas de secretos, minimización y separación de funciones.
