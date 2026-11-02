# Act.10

### 1. ¿Quién cambió el RFC de María García en la Actividad 2? ¿Y en la Actividad 3?

**Actividad 2:** No hay evidencia con esta edición. En ese momento el perfilador estaba desactivado (`was: 0`) y la bitácora solo registra la conexión y la autenticación, no la operación que modificó el RFC.

**Actividad 3:** El cambio fue realizado por el usuario `app_ventas@comercial`. La evidencia se encuentra en `system.profile`, donde aparece una operación `update` sobre la colección `comercial.clientes` ejecutada desde la aplicación `app-ventas-web`.

### 2. ¿Cuándo y desde qué aplicación?

En la Actividad 3, la modificación quedó registrada con fecha y hora:

```text
2026-10-25T22:52:45.909Z
```

La operación fue realizada desde la aplicación:

```text
app-ventas-web
```

según los campos `ts` y `appName` registrados por el perfilador.

### 3. ¿Qué valor tenía antes?

El perfilador registra la operación ejecutada y el nuevo valor enviado en la actualización, pero no conserva el valor anterior del documento. Como no existe una colección de auditoría con versiones previas ni una auditoría nativa habilitada, no es posible determinar cuál era el RFC antes del cambio utilizando únicamente la evidencia disponible en este laboratorio.

### 4. ¿Cambió alguien los privilegios de `app_ventas`?

Sí. La comparación entre las dos instantáneas de privilegios demuestra que se añadió el rol `dbAdmin` al usuario `app_ventas`.

