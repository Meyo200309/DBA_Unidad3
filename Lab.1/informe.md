# Informe – Bitácoras y Auditoría del Dato en PostgreSQL

## 1. Despliegue y situación inicial

El laboratorio se realizó utilizando PostgreSQL accesible mediante pgAdmin 4. Al inicio, la configuración de registro utilizaba los valores predeterminados del servidor, entre ellos `logging_collector = off`, `log_connections = off`, `log_disconnections = off` y `log_statement = none`.

Con esta configuración, PostgreSQL no registraba las conexiones de los usuarios ni las sentencias SQL ejecutadas. Como consecuencia, cuando ocurrió el primer cambio del RFC en la tabla `clientes`, no existía evidencia suficiente para determinar quién realizó la modificación, desde qué aplicación se ejecutó o cuál era el valor anterior del dato.

Por esta razón no era posible responder adecuadamente las preguntas planteadas por Dirección ni reconstruir una cronología confiable de los eventos.

---

## 2. Configuración aplicada

Se habilitaron mecanismos de registro adicionales para mejorar la trazabilidad de las operaciones realizadas en el servidor.

| Parámetro | Valor configurado | Aplicación |
|------------|------------------|------------|
| logging_collector | on | Requiere reinicio |
| log_connections | on | Recarga |
| log_disconnections | on | Recarga |
| log_line_prefix | %m [%p] user=%u db=%d app=%a client=%h | Recarga |
| log_statement | ddl y posteriormente mod | Recarga |

La activación de `logging_collector` permitió que PostgreSQL administrara directamente sus archivos de bitácora.

Los parámetros `log_connections` y `log_disconnections` permitieron registrar aperturas y cierres de sesión.

El nuevo `log_line_prefix` incorporó información relevante para auditoría como usuario, base de datos, aplicación y dirección del cliente.

Inicialmente se utilizó `log_statement = ddl` para registrar cambios de configuración, privilegios y estructura. Posteriormente se cambió a `log_statement = mod` para registrar también las modificaciones de datos realizadas mediante `INSERT`, `UPDATE` y `DELETE`.

---

## 3. Eventos observados

### Configuración

Se registró la modificación de parámetros de auditoría mediante cambios de configuración aplicados al servidor. La bitácora mostró cuándo se activaron las opciones de registro y quién realizó dichos cambios.

### Acceso

Se observaron conexiones exitosas y fallidas de usuarios. La bitácora registró el usuario utilizado, la dirección IP de origen, el método de autenticación y la aplicación empleada.

### Privilegios

Se registraron operaciones `GRANT` y `REVOKE`, permitiendo identificar cuándo se modificaron permisos sobre la tabla `clientes`.

### Estructura

La sentencia `ALTER TABLE clientes ADD COLUMN segmento VARCHAR(20)` quedó registrada en la bitácora como un cambio de estructura de la base de datos.

### Datos

Con `log_statement = mod` fue posible identificar quién modificó registros de la tabla `clientes`, desde qué aplicación y mediante qué sentencia.

### Error de autenticación

Se registraron intentos fallidos de acceso utilizando credenciales incorrectas y usuarios inexistentes.

### Error de autorización

Se registró un intento fallido de eliminación de registros por parte de un usuario sin permisos suficientes.

### Actividad de sesiones

Mediante `pg_stat_activity` fue posible observar sesiones activas, usuarios conectados, aplicaciones utilizadas y consultas en ejecución.

---

## 4. Auditoría del dato

Para conservar evidencia detallada de los cambios realizados sobre la tabla `clientes`, se implementó una tabla de auditoría denominada `auditoria.cambios_clientes`.

La tabla almacena:

- Fecha y hora del evento.
- Usuario de sesión.
- Usuario efectivo.
- Aplicación utilizada.
- Dirección IP del cliente.
- Operación realizada.
- Identificador del cliente.
- Valores anteriores.
- Valores posteriores.

Los valores anteriores y posteriores se almacenan en formato JSONB, permitiendo conservar el estado completo del registro independientemente de cambios futuros en la estructura de la tabla.

La función de auditoría utiliza `SECURITY DEFINER`, lo que permite insertar registros en la tabla de auditoría incluso cuando los usuarios finales no poseen permisos directos sobre ella.

El campo `session_user` resultó fundamental para identificar correctamente el usuario que originó la operación. Si únicamente se hubiera utilizado `current_user`, todos los eventos habrían aparecido como ejecutados por el propietario de la función de auditoría.

Durante el incidente auditado fue posible identificar:

- Quién realizó el cambio.
- Cuándo ocurrió.
- Desde qué dirección IP.
- Mediante qué aplicación.
- Qué campo fue modificado.
- Cuál era el valor anterior.
- Cuál fue el valor nuevo.

---

## 5. Limitaciones

La solución implementada presenta varias limitaciones.

Las consultas `SELECT` no quedan registradas en la tabla de auditoría mediante disparadores, por lo que no es posible determinar quién leyó información sensible.

Un cambio masivo sobre muchas filas genera un registro de auditoría por cada fila afectada, lo que puede incrementar significativamente el volumen de almacenamiento utilizado.

Además, un administrador con privilegios suficientes puede desactivar temporalmente el disparador de auditoría y realizar modificaciones que no quedarán reflejadas en la tabla de auditoría.

---

## 6. Riesgos de la bitácora

La bitácora puede contener información sensible.

Durante el laboratorio se observó que ciertas sentencias pueden registrar contraseñas o información confidencial en texto claro cuando se utilizan directamente dentro de instrucciones SQL.

También existe riesgo de pérdida de evidencia si las bitácoras permanecen únicamente en el servidor que las genera y no son exportadas o respaldadas periódicamente.

Otro riesgo importante es el acceso no autorizado. Las bitácoras contienen información sobre usuarios, aplicaciones, direcciones IP y operaciones realizadas, por lo que deben protegerse mediante controles de acceso estrictos.

---

## 7. Cronología y conclusión

La combinación de la bitácora del servidor y la tabla de auditoría permitió reconstruir una secuencia cronológica de eventos que incluyó cambios de configuración, accesos, modificaciones de privilegios, cambios estructurales, operaciones sobre datos y errores.

Durante las primeras actividades no fue posible determinar quién modificó ciertos datos porque la información no estaba siendo registrada.

Una vez habilitados los mecanismos de auditoría y la tabla de cambios, fue posible identificar con precisión:

- El usuario responsable.
- La aplicación utilizada.
- La dirección IP de origen.
- La fecha y hora del evento.
- El valor anterior del dato.
- El valor nuevo del dato.

Por lo tanto, con la configuración final implementada sí es posible demostrar quién modificó un dato sensible, cuándo ocurrió el cambio y qué valor tenía antes de ser modificado, siempre que los mecanismos de auditoría permanezcan activos y protegidos.
