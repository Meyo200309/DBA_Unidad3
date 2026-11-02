# Act.2

| Conjunto de datos | Propietario | Custodio | Usuarios autorizados | Quién aprueba accesos | Quién aprueba correcciones |
|-------------------|-------------|----------|----------------------|-----------------------|----------------------------|
| comercial.public.clientes (PostgreSQL) | Área de Ventas o responsable del proceso comercial | DBA | Personal autorizado de ventas, soporte y aplicaciones autorizadas | Propietario del dato | Propietario del dato |
| auditoria.cambios_clientes (PostgreSQL) | Auditoría interna o responsable de cumplimiento | DBA | Auditores, personal de seguridad y administradores autorizados | Responsable de auditoría o cumplimiento | Responsable de auditoría o cumplimiento |
| Bitácora de PostgreSQL | Seguridad de la información o auditoría | DBA | Seguridad, auditoría y administradores autorizados | Responsable de seguridad | No aplica; la bitácora no debe modificarse |
| comercial.clientes (MongoDB) | Área de Ventas o responsable del proceso comercial | Administrador de MongoDB | Usuarios y aplicaciones autorizadas | Propietario del dato | Propietario del dato |
| comercial.system.profile (MongoDB) | Seguridad de la información o auditoría | Administrador de MongoDB | Auditores, seguridad y administradores autorizados | Responsable de seguridad o auditoría | No aplica; los registros de perfilado no deben modificarse |

# Preguntas y Respuestas

### 1. ¿Por qué el propietario de `auditoria.cambios_clientes` no debería ser el mismo que opera `clientes`?

Porque se produciría un conflicto de intereses. La misma persona que modifica los datos tendría la capacidad de controlar o alterar la evidencia de sus propias acciones. Mantener separados al responsable de la operación y al responsable de la auditoría fortalece la trazabilidad y reduce el riesgo de manipulación de evidencias.

### 2. ¿Quién debería poder leer las bitácoras y la vista `dba.bitacora`? Relaciónalo con lo observado en el LAB-01 (secretos en la bitácora).

Solo deberían tener acceso los administradores autorizados, el personal de seguridad y los responsables de auditoría. Durante el LAB-01 se observó que la bitácora puede contener información sensible, incluyendo sentencias SQL y posibles secretos o credenciales. 

### 3. ¿Qué ocurre con la responsabilidad sobre un dato cuando nadie la tiene asignada? Relaciónalo con el problema inicial de la unidad.

Cuando un dato no tiene propietario definido, nadie asume la responsabilidad de autorizar accesos, validar correcciones, resolver problemas de calidad o tomar decisiones sobre su uso. 
