#act.5
# Criterio de conservación de registros

| Registro | Ubicación actual | Riesgo de pérdida observado | Sensibilidad | Periodo propuesto | Justificación | Dónde se conserva | Quién puede leerlo | Acción al vencer |
|-----------|------------------|-----------------------------|--------------|------------------|---------------|-------------------|-------------------|------------------|
| Accesos de PostgreSQL | Archivo del colector (`pg_current_logfile()`) | Rotación del archivo, reinstalación o recreación del servidor | Media | 6 meses | Permite investigar accesos, autenticaciones y actividades recientes | Repositorio central de bitácoras y respaldo externo | DBA, Seguridad y Auditoría | Eliminación segura |
| Cambios de privilegios y estructura | Archivo del colector | Alta | Alta | 2 años | Son eventos críticos para auditorías e investigaciones de seguridad | Repositorio de auditoría con respaldo externo | Seguridad, Auditoría y administradores autorizados | Eliminación segura previa validación |
| Modificaciones de datos (`log_statement = 'mod'`) | Archivo del colector | Rotación del archivo | Alta | 1 año | Permite rastrear cambios relevantes sobre los datos | Repositorio central de bitácoras | Seguridad, Auditoría y DBA | Eliminación segura |
| `auditoria.cambios_clientes` | Tabla en `comercial` | Eliminación accidental, corrupción o pérdida de la base de datos | Alta (contiene datos personales) | 1 año o plazo a confirmar con el área jurídica | Sirve para reconstruir cambios sobre información sensible | Base de datos y respaldos protegidos | Auditoría, Seguridad y administradores autorizados | Eliminación o anonimización según política |
| Bitácora de `mongod` | `systemLog.path` o salida estándar; `getLog` solo en memoria | Reinicio del servicio, rotación de archivos, pérdida de memoria | Media | 6 meses | Permite analizar conexiones, autenticaciones y configuraciones | Archivo centralizado y respaldado | Seguridad, Auditoría y administradores autorizados | Eliminación segura |
| `system.profile` | Colección limitada de 1 MB | Sobrescritura automática de registros antiguos | Media | Exportación periódica y conservación de exportes por 6 meses | El tamaño limitado impide conservar evidencia histórica por largo tiempo | Exportaciones en almacenamiento protegido | Seguridad, Auditoría y administradores autorizados | Eliminación segura |
| Instantáneas de privilegios (MongoDB) | `auditoria.instantaneas_privilegios` | Pérdida de la base de datos o eliminación accidental | Alta | 2 años | Permite detectar cambios de roles y permisos cuando no existe auditoría nativa | Base de datos y respaldos protegidos | Seguridad, Auditoría y administradores autorizados | Eliminación segura previa validación |


### 1. ¿Por qué la bitácora de cambios de privilegios merece más tiempo de conservación que la de consultas rutinarias?

Porque los cambios de privilegios modifican las capacidades de acceso de los usuarios y pueden tener impacto durante largos periodos. Estos eventos son fundamentales para investigaciones de seguridad, auditorías y revisiones de cumplimiento. 

### 2. ¿Qué control de integridad aplicarás a las bitácoras exportadas?

Se aplicará un hash SHA-256 a cada archivo exportado. El valor generado se almacenará por separado junto con la fecha de exportación para poder verificar posteriormente que la evidencia no fue modificada ni alterada.

### 3. ¿Qué diferencia hay entre conservar una bitácora y respaldar una base de datos?

Conservar una bitácora tiene como objetivo preservar evidencia histórica de eventos, accesos, cambios y actividades realizadas sobre los sistemas. Respaldar una base de datos busca recuperar información operativa en caso de fallo, corrupción o pérdida de datos. 
