# Actividad 09

### 1. ¿Qué columna permite relacionar una sesión con sus líneas de bitácora?

La columna pid permite relacionar una sesión activa con las líneas correspondientes en la bitácora. El mismo identificador de proceso aparece tanto en `pg_stat_activity` como en los registros del log, lo que facilita rastrear la actividad de una sesión específica.

### 2. Después de que termina el reporte, ¿qué fuente conserva evidencia de que existió?

Una vez finalizada la sesión, su información desaparece de `pg_stat_activity` porque esta vista solo muestra actividad actual. La evidencia de que existió permanece en la bitácora, donde quedan registradas la conexión, la autenticación, la autorización y la desconexión de la sesión.

### 3. ¿Por qué `client_addr` aparece vacío en la sesión del administrador?

Porque la sesión del administrador se realizó mediante una conexión local en el mismo servidor. En este tipo de conexiones PostgreSQL no utiliza una dirección IP remota, por lo que el campo `client_addr` aparece vacío o nulo.
