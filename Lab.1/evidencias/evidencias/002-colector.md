# actividad 2

### 1. ¿Por qué logging_collector requiere reinicio y log_statement solo recarga?
logging_collector requiere reinicio porque modifica la forma en que PostgreSQL captura y almacena las bitácoras, lo que implica iniciar o detener procesos internos relacionados con el registro de eventos.

### 2. ¿Qué ventaja tiene que la bitácora se lea con SQL y no con una herramienta del sistema operativo o del contenedor? ¿Qué riesgo introduce?

La principal ventaja es que permite consultar y analizar la bitácora desde PostgreSQL utilizando SQL, sin necesidad de acceder al sistema operativo o al contenedor. Además, facilita filtrar, buscar y ordenar información mediante consultas.

El riesgo es que la bitácora puede contener información sensible del sistema. Si usuarios no autorizados tienen acceso, podrían obtener detalles sobre el funcionamiento interno del servidor, errores o actividades de otros usuarios.

### 3. ¿Quién debería poder consultar dba.bitacora?

Únicamente los administradores de bases de datos y el personal autorizado para tareas de auditoría, monitoreo, soporte o seguridad. Los usuarios normales no deberían tener acceso debido a la naturaleza sensible de la información almacenada en las bitácoras.
