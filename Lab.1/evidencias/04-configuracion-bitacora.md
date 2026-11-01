# actividad 4

### 1. ¿Por qué el proceso que registra el cambio es el principal y no tu sesión?

Porque la recarga de la configuración afecta a todo el servidor. Aunque el comando fue ejecutado desde una sesión de usuario, quien aplica efectivamente los cambios y actualiza la configuración es el proceso principal de PostgreSQL. Por eso es ese proceso el que registra en la bitácora que los parámetros fueron modificados.

### 2. ¿Qué pasaría si alguien ejecutara `ALTER SYSTEM SET log_statement = 'none'`? ¿Quedaría rastro?

Sí. Aunque posteriormente se desactive el registro de sentencias SQL, el cambio de configuración quedaría registrado en la bitácora cuando el servidor procese la modificación y recargue la configuración. Esto permite detectar que alguien alteró el nivel de auditoría del sistema.

### 3. ¿Por qué no se recomienda editar `postgresql.auto.conf` a mano?

Porque ese archivo es administrado automáticamente por PostgreSQL mediante los comandos `ALTER SYSTEM`. Editarlo manualmente puede provocar errores de configuración, inconsistencias o la pérdida de cambios cuando PostgreSQL vuelva a escribir el archivo. Además, se dificulta el control y la trazabilidad de las modificaciones realizadas.
