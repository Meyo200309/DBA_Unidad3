# Actividad 1 

## Configuración observada

| Parámetro | Valor | Source |
|-----------|--------|--------|
| log_connections | off | default |
| log_destination | stderr | default |
| log_directory | log | default |
| log_disconnections | off | default |
| log_filename | postgresql-%Y-%m-%d_%H%M%S.log | default |
| logging_collector | off | default |
| log_line_prefix | %m [%p] | default |
| log_min_error_statement | error | default |
| log_statement | none | default |
| log_timezone | Etc/UTC | configuration file |

## Respuestas

### 1. Con esta configuración, ¿se registra quién se conecta?

No. El parámetro log_connections está configurado en off, por lo que PostgreSQL no registra los eventos de conexión de los usuarios al servidor.

### 2. ¿Se registran las sentencias UPDATE?

No. El parámetro log_statement tiene el valor none, lo que indica que las sentencias SQL ejecutadas no se registran en la bitácora de manera general. Solo podrían registrarse si producen errores y cumplen las condiciones de log_min_error_statement.

### 3. ¿La línea de bitácora incluye el usuario o la dirección IP del cliente?

No. El valor de log_line_prefix es %m [%p], que únicamente incluye la marca de tiempo (%m) y el identificador del proceso (%p). No contiene variables para mostrar el usuario (%u) ni la dirección IP o nombre del cliente (%h).

### 4. ¿En qué zona horaria se registran los eventos? ¿Por qué importa al reconstruir una cronología?

Los eventos se registran en la zona horaria `Etc/UTC`. Esto es importante porque todas las marcas de tiempo de la bitácora estarán expresadas en UTC. Al reconstruir una cronología o correlacionar eventos con sistemas externos, es necesario considerar la diferencia horaria para evitar interpretar incorrectamente cuándo ocurrió cada evento.

### 5. Con `logging_collector = off`, ¿quién decide dónde termina la bitácora: PostgreSQL o el mecanismo con que se desplegó el servidor?

Cuando `logging_collector` está en `off`, PostgreSQL envía los mensajes a la salida estándar de error (`stderr`), pero no administra directamente los archivos de log. En este caso, el destino final de la bitácora lo determina el mecanismo de despliegue o el sistema operativo (por ejemplo, Docker, systemd, Kubernetes o el gestor de servicios utilizado), que es quien captura y almacena dicha salida.
