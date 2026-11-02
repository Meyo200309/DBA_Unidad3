
## Diccionario complementario

| Columna | Clasificación (Unidad II) | Finalidad | Control aplicado | ¿Cambios auditados? | Regla de calidad |
|----------|--------------------------|------------|-------------------|---------------------|------------------|
| rfc | Dato personal | Facturación | Vista enmascarada para soporte | Sí, LAB-01 Parte B | Formato RFC válido |
| correo | Dato personal | Comunicación con clientes | Control de acceso por roles | Sí, mediante auditoría de cambios | Formato de correo electrónico válido y unicidad |
| telefono | Dato personal | Contacto con clientes | Acceso restringido por rol | Sí, mediante auditoría de cambios | Longitud y formato válidos |
| ciudad | Dato personal indirecto | Segmentación geográfica | Acceso según perfil autorizado | Sí, mediante auditoría de cambios | Valor consistente con catálogo definido |
| codigo_postal | Dato personal indirecto | Segmentación territorial | Acceso según perfil autorizado | Sí, mediante auditoría de cambios | Longitud y formato válidos |
| fecha_alta | Dato operativo | Seguimiento histórico y auditoría | Registro automático del sistema | Sí | Fecha válida y consistente |
| segmento | Dato de negocio | Clasificación comercial | Controlado por procesos de negocio | Sí | Valores permitidos por catálogo de segmentos |


### 1. ¿Qué ventaja tiene guardar el significado en `COMMENT` en lugar de solo en un documento aparte?

La documentación permanece junto al objeto que describe y puede consultarse directamente desde el motor de base de datos. Esto reduce el riesgo de desactualización, facilita el mantenimiento y permite que cualquier administrador o desarrollador consulte el significado de las tablas y columnas utilizando las herramientas del propio sistema.

### 2. ¿Quedaron registrados los `COMMENT` en la bitácora? ¿Con qué nivel de `log_statement`?

Sí. Las sentencias `COMMENT` forman parte del lenguaje de definición de datos (DDL). Por lo tanto, quedan registradas cuando PostgreSQL tiene configurado `log_statement = 'ddl'` o un nivel superior como `all`.

### 3. ¿Qué información del diccionario debe mantenerse fuera del motor? ¿Por qué?

La información relacionada con políticas internas, clasificación de la información, responsables organizacionales, procedimientos de negocio, controles de seguridad y procesos de aprobación debe mantenerse fuera del motor. Estos elementos pertenecen al gobierno de datos de la organización, cambian con frecuencia y requieren participación de áreas distintas al equipo técnico responsable de la base de datos.
