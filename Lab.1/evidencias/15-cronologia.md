# Cronología de eventos

| # | Fecha y hora | Usuario | Cliente | Tipo de evento | Qué ocurrió | ¿Exitoso? | Fuente |
|---|--------------|----------|----------|----------------|-------------|-----------|---------|
| 1 | 2026-10-25 22:49:50 | postgres | local | Configuración | Se activaron los registros de conexiones y desconexiones y se modificó el formato de la bitácora | Sí | Bitácora línea 8-11 |
| 2 | 2026-10-25 22:50:00 | app_ventas | 127.0.0.1 | Acceso | Intento de conexión con contraseña incorrecta | No | Bitácora línea 91 |
| 3 | 2026-10-25 22:50:00 | usuario_inexistente | 127.0.0.1 | Acceso | Intento de conexión con usuario inexistente | No | Bitácora línea 98 |
| 4 | 2026-10-25 22:50:00 | app_ventas | 127.0.0.1 | Acceso | Conexión autenticada y autorizada correctamente | Sí | Bitácora línea 105 |
| 5 | 2026-10-25 22:50:09 | postgres | local | Privilegio | Se revocó un permiso UPDATE a soporte_ana | Sí | Bitácora línea 119 |
| 6 | 2026-10-25 22:50:09 | postgres | local | Estructura | Se agregó la columna segmento a la tabla clientes | Sí | Bitácora línea 119 |
| 7 | 2026-10-25 22:50:20 | app_ventas | 127.0.0.1 | Datos | Se modificó el teléfono de un cliente | Sí | Bitácora línea 162 |
| 8 | 2026-10-25 22:50:52 | app_ventas | 127.0.0.1 | Datos | Se modificó el RFC del cliente con id 3 | Sí | id_evento 1 |
| 9 | 2026-10-25 22:50:00 | soporte_ana | 127.0.0.1 | Error | Intentó eliminar un cliente sin permisos suficientes | No | Bitácora línea 168 |
| 10 | 2026-10-25 22:50:00 | postgres | local | Error | Intentó eliminar un rol con dependencias activas | No | Bitácora línea 175 |

# Respuestas a Dirección

### 1. ¿Quién cambió el RFC la primera vez (Actividad 3)? ¿Y en las Actividades 7, 12 y 14?

**Actividad 3:** No hay evidencia. En ese momento no se registraban conexiones ni sentencias UPDATE, por lo que no existe información suficiente para identificar al responsable.

**Actividad 7:** El usuario `app_ventas` realizó el cambio del RFC. La bitácora registra la sentencia UPDATE ejecutada desde la aplicación `app-ventas-web` y la dirección IP correspondiente.

**Actividad 12:** El usuario `app_ventas` realizó el cambio del RFC. La tabla de auditoría registra el usuario de sesión, la aplicación, la dirección IP y los valores antes y después del cambio mediante el `id_evento 1`.

**Actividad 14:** El usuario `postgres` modificó el RFC mientras el disparador de auditoría estaba desactivado. La evidencia se encuentra en la bitácora del servidor, donde aparecen la desactivación del disparador, el UPDATE y la reactivación del disparador.

### 2. ¿Quién cambió el teléfono?

El usuario `app_ventas` modificó el teléfono. La bitácora registra la sentencia UPDATE ejecutada desde la aplicación `app-ventas-web` y la conexión asociada a ese usuario.

### 3. ¿Hubo intentos de acceso fallidos? ¿De qué usuarios y desde dónde?

Sí.

- Usuario `app_ventas` desde la dirección IP `127.0.0.1`, con error de autenticación por contraseña incorrecta.
- Usuario `usuario_inexistente` desde la dirección IP `127.0.0.1`, con error porque el rol no existía.

Ambos eventos quedaron registrados en la bitácora.

### 4. ¿Qué valor tenía el RFC antes de cada cambio?

**Actividad 3:** No hay evidencia. El sistema no registraba cambios de datos ni conservaba valores anteriores.

**Actividad 7:** No hay evidencia. Aunque el UPDATE quedó registrado en la bitácora, no existía todavía la auditoría que almacenara los valores previos.

**Actividad 12:** El valor anterior era `GAMA780912XYZ` y el nuevo valor fue `GAMA780912ZZZ`, según el registro de auditoría `id_evento 1`.

**Actividad 14:** No hay evidencia en la tabla de auditoría porque el disparador fue desactivado antes del cambio. La bitácora demuestra que ocurrió el UPDATE, pero no conserva el valor anterior ni el nuevo.
