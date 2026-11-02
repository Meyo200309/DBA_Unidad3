# Act.1
### 1. ¿Qué edición de MongoDB estás usando? ¿Qué evidencia lo demuestra?

Se está utilizando MongoDB Community Edition. La evidencia es que la consulta `db.adminCommand({ buildInfo: 1 }).modules` devuelve un arreglo vacío (`[]`). En MongoDB Enterprise aparecería el módulo `enterprise` dentro de ese resultado.

### 2. ¿A dónde escribe tu servidor su bitácora? ¿Cómo lo sabes?

La ubicación de la bitácora se determina mediante la configuración del servidor mostrada por `db.serverCmdLineOpts().parsed`. Si existe una sección `systemLog`, ahí se especifica la ruta del archivo de log. En caso de no aparecer, la ubicación dependerá de la configuración utilizada durante el despliegue o del entorno donde se ejecuta MongoDB.

### 3. Según REF-U3-04, ¿qué cuatro categorías de eventos registraría la auditoría nativa?

Las cuatro categorías principales son:

- Autenticación.
- Autorización.
- Administración de roles y usuarios.
- Operaciones sobre datos y configuración del sistema.

Estas categorías permiten registrar quién accede al sistema, qué permisos utiliza, qué cambios realiza sobre la seguridad y qué operaciones ejecuta sobre los datos y la configuración.

### 4. ¿Qué tendría que evaluar una organización antes de licenciar Enterprise o migrar a Atlas solo para obtener auditoría?

La organización debería evaluar:

- El costo de licenciamiento o suscripción.
- Los requisitos regulatorios y de cumplimiento.
- El volumen de eventos que necesita auditar.
- El impacto en almacenamiento y rendimiento.
- Los beneficios de la auditoría frente a alternativas disponibles.
- Los requisitos de operación, soporte y administración de la plataforma.

La decisión debe basarse en si las capacidades de auditoría justifican la inversión económica y operativa necesaria.
