# Actividad 07

### 1. ¿Por qué un cambio de privilegios es uno de los eventos auditables más importantes?

Porque los privilegios determinan qué acciones puede realizar cada usuario sobre los datos y la configuración del sistema. Un cambio de privilegios puede permitir accesos no autorizados, modificaciones de información sensible o alteraciones de la seguridad. 

### 2. ¿Con qué frecuencia tomarías instantáneas? ¿Qué factores influyen?

La frecuencia depende del nivel de riesgo, la cantidad de usuarios, la frecuencia de cambios administrativos y los requisitos de auditoría de la organización.

En un entorno con cambios poco frecuentes podría ser suficiente una instantánea diaria. En entornos críticos o con cambios frecuentes de permisos podrían requerirse instantáneas cada hora o después de cada ventana de mantenimiento.

### 3. ¿Quién debería poder escribir en `auditoria.instantaneas_privilegios`?

Únicamente administradores autorizados y personal responsable de auditoría o seguridad. 

### 4. Redacta en tres líneas cómo comunicarías esta limitación a Dirección.

La edición utilizada de MongoDB no registra de forma nativa los cambios de privilegios mediante el perfilador ni en la bitácora estándar. Como control compensatorio se mantienen instantáneas periódicas de usuarios y roles para detectar modificaciones. Este mecanismo permite identificar que hubo cambios, pero no determina con precisión quién los realizó ni el instante exacto en que ocurrieron.
