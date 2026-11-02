# actividad 2

### 1. ¿Por qué `logging_collector` requiere reinicio y `log_statement` solo recarga?
`logging_collector` requiere reinicio porque modifica la forma en que PostgreSQL captura y almacena las bitácoras. `log_statement` se puede activar o cambiar con recarga porque afecta a la sesión de configuración en ejecución del servidor.

### 2. ¿Qué ventaja tiene que la bitácora se lea con SQL y no con una herramienta del sistema operativo o del contenedor? ¿Qué riesgo introduce?
La principal ventaja es que permite consultar y analizar la bitácora desde PostgreSQL utilizando SQL, sin necesidad de acceder al sistema operativo o al contenedor. Además, facilita filtrar, correlacionar y auditar los eventos en el mismo motor de base de datos.

El riesgo es que la bitácora puede contener información sensible del sistema. Si usuarios no autorizados tienen acceso, podrían obtener detalles sobre el funcionamiento interno del servidor, errores, accesos, credenciales o comportamiento de la infraestructura.

### 3. ¿Quién debería poder consultar `dba.bitacora`?
Únicamente los administradores de bases de datos y el personal autorizado para tareas de auditoría, monitoreo, soporte o seguridad. Los usuarios normales no deberían tener acceso debido a la naturaleza sensible de la información.
