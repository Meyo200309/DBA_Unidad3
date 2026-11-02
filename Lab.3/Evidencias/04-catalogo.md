# Act.4
| ID | Conjunto de datos | Motor | Ubicación | Propietario | Custodio | Clasificación | Contiene datos personales | Finalidad | Conservación | Diccionario |
|----|-------------------|--------|-----------|-------------|----------|---------------|---------------------------|-----------|--------------|-------------|
| CAT-01 | Clientes | PostgreSQL 16 | servidor-pg / comercial / public.clientes | Gerencia Comercial | DBA | Confidencial | Sí | Gestión de clientes, ventas y facturación | Mientras exista relación comercial y según políticas de retención | diccionario-clientes.csv |
| CAT-02 | Auditoría de clientes | PostgreSQL 16 | servidor-pg / comercial / auditoria.cambios_clientes | Auditoría Interna | DBA | Confidencial | Sí | Trazabilidad de modificaciones sobre clientes | Según política de auditoría y cumplimiento | Documentación de auditoría |
| CAT-03 | Registro de cambios | PostgreSQL 16 | servidor-pg / comercial / gobierno.solicitudes_cambio | Comité de Gobierno de Datos | DBA | Interna | No | Control y aprobación de cambios | Histórica según política organizacional | Procedimiento de gestión de cambios |
| CAT-04 | Clientes (tienda) | MongoDB 7 | servidor-mongo / comercial / clientes | Gerencia Comercial | Administrador MongoDB | Confidencial | Sí | Gestión operativa de clientes | Mientras exista relación comercial y según políticas de retención | Diccionario funcional de clientes |
| CAT-05 | Perfilado | MongoDB 7 | servidor-mongo / comercial / system.profile | Seguridad de la Información | Administrador MongoDB | Restringida | Sí | Auditoría y análisis de operaciones realizadas sobre los datos | Temporal y según configuración del perfilador | Documentación de perfilado |


### 1. ¿Por qué CAT-02 y CAT-05 contienen datos personales aunque su propósito sea la auditoría?

Porque registran actividades realizadas sobre información de clientes y usuarios. Los registros de auditoría pueden contener identificadores, direcciones IP, nombres de usuario, consultas ejecutadas y referencias a datos personales. 

### 2. ¿Qué pasa si CAT-01 y CAT-04 tienen propietarios distintos y el RFC de un cliente difiere entre ambos motores?

Se genera una inconsistencia de datos y deja de existir una versión única y confiable de la información. Esto puede provocar errores operativos, problemas de facturación, reportes contradictorios y dificultades para determinar cuál es el dato correcto. 

### 3. ¿Qué información del catálogo cambia con más frecuencia y quién debe actualizarla?

La información que suele cambiar con mayor frecuencia es la relacionada con responsables, usuarios autorizados, ubicación de los conjuntos de datos, clasificaciones, tiempos de conservación y finalidades de uso. Estas actualizaciones deben ser realizadas por los propietarios de los datos y por los responsables de gobierno de datos, con apoyo del custodio técnico correspondiente.
