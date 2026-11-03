# Expediente de auditoría interna — Base comercial

## 1. Alcance

### Sistemas revisados

| Sistema | Versión | Forma de despliegue |
|----------|----------|---------------------|
| PostgreSQL | 16 | Servidor utilizado en los laboratorios de bases de datos |
| MongoDB Community | 7.0.43 | Servidor MongoDB con autorización habilitada |

### Periodo revisado

Periodo correspondiente a las actividades realizadas en los laboratorios LAB-01, LAB-02 y LAB-03.

### Responsable del expediente

Alumno responsable del laboratorio y recopilación de evidencias.


## 2. Configuración de auditoría (A3)

### PostgreSQL

Se configuraron los siguientes mecanismos:

- `logging_collector = on`
- `log_connections = on`
- `log_disconnections = on`
- `log_statement = mod`
- `log_line_prefix` con usuario, base, aplicación e IP de origen

**Evidencia:**

- E1-configuracion-registro.txt
- E5-bitacora-postgresql.log

Además se implementó auditoría de cambios mediante disparadores sobre la tabla `clientes`.

**Evidencia:**

- E3-disparadores.txt
- E4-muestra-auditoria.txt

### MongoDB Community

Se utilizaron:

- Bitácora de `mongod`
- Perfilador (`system.profile`)
- Instantáneas de privilegios

**Evidencia:**

- E6-mongodb.txt
- system-profile.json
- bitacora-mongod.log


## 3. Bitácora interpretada (A3, A5)

### Evento 1 — Cambio de RFC de María García

| Elemento | Valor |
|-----------|--------|
| Usuario | app_ventas |
| Aplicación | app-ventas-web |
| Cliente | 127.0.0.1 |
| Momento | 2026-10-25 22:50:52 |
| Tipo | Modificación de datos |
| Evento | RFC modificado |
| Evidencia | E4-muestra-auditoria.txt y auditoria.cambios_clientes |

Interpretación:

La aplicación comercial modificó el RFC del cliente con identificador 3. La auditoría permitió identificar al usuario responsable, la aplicación utilizada y el momento exacto del cambio.


### Evento 2 — Intento fallido de autenticación

| Elemento | Valor |
|-----------|--------|
| Usuario | app_ventas |
| Aplicación | mongosh |
| Cliente | 127.0.0.1 |
| Momento | 2026-10-25 22:52:58 |
| Tipo | Acceso fallido |
| Evento | Contraseña incorrecta |
| Evidencia | bitacora-mongod.log |

Interpretación:

Se observó un intento de autenticación fallido debido a credenciales incorrectas. El servidor registró el origen, usuario y motivo del rechazo.


### Evento 3 — Desactivación de la auditoría

| Elemento | Valor |
|-----------|--------|
| Usuario | postgres |
| Aplicación | psql |
| Cliente | local |
| Momento | 2026-10-25 22:50:53 |
| Tipo | Cambio de configuración |
| Evento | Desactivación temporal del trigger de auditoría |
| Evidencia | E5-bitacora-postgresql.log |

Interpretación:

El mecanismo de auditoría fue deshabilitado temporalmente. Durante ese periodo pudieron realizarse cambios sin quedar registrados en la tabla de auditoría.


## 4. Elementos de gobierno (A1, A2)

### Responsables

Definidos en:

- evidencias/02-responsables.md

Se identificaron propietarios, custodios y usuarios autorizados para:

- Clientes PostgreSQL
- Auditoría PostgreSQL
- Clientes MongoDB
- Perfilado MongoDB

### Diccionario de datos

Definido mediante:

- COMMENT ON TABLE
- COMMENT ON COLUMN

**Evidencias:**

- evidencia/diccionario-clientes.csv
- evidencias/03-diccionario.md

### Catálogo de datos

Definido en:

- evidencias/04-catalogo.md

Incluye:

- Clientes PostgreSQL
- Auditoría PostgreSQL
- Solicitudes de cambio
- Clientes MongoDB
- Perfilado MongoDB


## 5. Conservación (A3)

Se establecieron criterios diferenciados para:

- Bitácoras PostgreSQL
- Cambios de privilegios
- Modificaciones de datos
- Auditoría de clientes
- Bitácora de MongoDB
- Perfilador
- Instantáneas de privilegios

**Evidencia:**

- evidencias/05-conservacion.md

Las evidencias exportadas deben acompañarse de hashes SHA-256 para validar integridad.


## 6. Políticas (A4)

| Política | Archivo | Evidencia asociada |
|-----------|----------|-------------------|
| POL-01 Acceso | politicas/POL-01-acceso.md | E2-privilegios.txt |
| POL-02 Respaldo | politicas/POL-02-respaldo.md | Registro de respaldos |
| POL-03 Retención | politicas/POL-03-retencion.md | 05-conservacion.md |
| POL-04 Restauración | politicas/POL-04-restauracion.md | Solicitudes de restauración |
| POL-05 Datos sensibles | politicas/POL-05-datos-sensibles.md | E4-muestra-auditoria.txt |
| POL-06 Cambios en producción | politicas/POL-06-cambios-produccion.md | gobierno.solicitudes_cambio |


## 7. Conciliación de cambios (A5)

### Cambio autorizado

| Sentencia | Folio |
|------------|---------|
| ALTER TABLE clientes ADD COLUMN canal_alta VARCHAR(20) | CAM-2026-014 |

Estado:

✅ Autorizado

### Cambios sin autorización registrada

| Sentencia | Hallazgo |
|------------|-----------|
| ALTER TABLE clientes DISABLE TRIGGER trg_auditoria_clientes | Cambio sin folio |
| GRANT UPDATE ON clientes TO app_ventas | Cambio sin folio |
| REVOKE UPDATE ON clientes FROM soporte_ana | Cambio sin folio |

**Evidencia:**

- evidencias/06-conciliacion.md
- E5-bitacora-postgresql.log

## 8. Hallazgos

| ID | Hallazgo | Fuente | Severidad | Impacto | Recomendación | Decisión requerida de |
|----|-----------|---------|------------|---------|----------------|----------------------|
| H-01 | Correo duplicado | 01-calidad.md | Media | Posibles registros duplicados | Validar y depurar clientes | Gerencia Comercial |
| H-02 | RFC inválido o incompleto | 01-calidad.md | Media | Errores de facturación | Corrección validada por negocio | Gerencia Comercial |
| H-03 | Edad fuera de rango | 01-calidad.md | Baja | Datos inconsistente | Corregir captura | Propietario del dato |
| H-04 | Trigger de auditoría deshabilitado | 06-conciliacion.md | Alta | Pérdida de evidencia | Exigir autorización formal | Comité de Cambios |
| H-05 | Cambios de privilegios sin folio | 06-conciliacion.md | Alta | Riesgo de acceso indebido | Formalizar gestión de cambios | Dirección |
| H-06 | MongoDB Community no registra privilegios de forma nativa | 07-privilegios-control-compensatorio.md | Media | Evidencia incompleta | Evaluar controles compensatorios o Enterprise | Dirección |

## 9. Limitaciones conocidas y riesgos aceptados (A6)

### Verificado en laboratorio

| Riesgo | Evidencia | Acepta |
|----------|------------|---------|
| PostgreSQL puede tener periodos sin evidencia si `log_statement = none` | LAB-01 | Dirección |
| Administrador puede desactivar auditoría | LAB-01 Actividad 14 | Dirección |
| MongoDB Community no audita privilegios de forma nativa | LAB-02 Actividad 7 | Dirección |
| system.profile se sobrescribe automáticamente | LAB-02 Actividad 8 | Dirección |


| Riesgo o control | Estado |
|------------------|---------|
| Auditoría nativa de MongoDB Enterprise | Documentado |
| Auditoría nativa de MongoDB Atlas | Documentado |
| Auditoría de objetos mediante pgaudit | Documentado |

## 10. Índice de evidencias

| Evidencia | Archivo |
|------------|----------|
| Configuración de registro | E1-configuracion-registro.txt |
| Privilegios vigentes | E2-privilegios.txt |
| Disparadores de auditoría | E3-disparadores.txt |
| Muestra de auditoría | E4-muestra-auditoria.txt |
| Bitácora PostgreSQL | E5-bitacora-postgresql.log |
| Hash de bitácora PostgreSQL | E5-bitacora-postgresql.sha256 |
| Evidencias MongoDB | E6-mongodb.txt |
| Perfilado MongoDB | system-profile.json |
| Bitácora MongoDB | bitacora-mongod.log |
| Hashes MongoDB | hashes.sha256 |
| Diccionario de datos | diccionario-clientes.csv |
| Catálogo de datos | 04-catalogo.md |
| Conservación | 05-conservacion.md |
| Conciliación | 06-conciliacion.md |

## Conclusión

 MongoDB Community proporciona visibilidad sobre operaciones y accesos mediante perfilado y bitácoras, aunque presenta limitaciones para la auditoría de privilegios. El expediente integra controles técnicos, elementos de gobierno de datos y mecanismos de conservación que permiten respaldar investigaciones y procesos de auditoría interna.
