
# Act.7

| Momento (bitácora) | Usuario | Sentencia | Folio que lo autoriza | ¿Autorizado? | Hallazgo |
|-------------------|----------|-----------|-----------------------|--------------|----------|
| 2026-10-25 22:54:26.533 | postgres | ALTER TABLE clientes ADD COLUMN canal_alta VARCHAR(20) | CAM-2026-014 | Sí | — |
| 2026-10-25 22:50:53.460 | app_ventas | ALTER TABLE clientes DISABLE TRIGGER trg_auditoria_clientes | No existe | No | Intento no autorizado de modificar el mecanismo de auditoría |
| 2026-10-25 22:50:53.549 | postgres | ALTER TABLE clientes DISABLE TRIGGER trg_auditoria_clientes | No existe | No | Cambio sin solicitud registrada; riesgo para la evidencia de auditoría |
| 2026-10-25 22:50:53.554 | postgres | ALTER TABLE clientes ENABLE TRIGGER trg_auditoria_clientes | No existe | No | Reactivación no respaldada por un folio formal |
| 2026-10-25 22:50:09.367 | postgres | GRANT UPDATE ON clientes TO app_ventas | No existe | No | Cambio de privilegios sin evidencia de autorización |
| 2026-10-25 22:50:09.341 | postgres | REVOKE UPDATE ON clientes FROM soporte_ana | No existe | No | Cambio de privilegios sin evidencia de autorización |
| 2026-10-25 22:50:09.372 | postgres | ALTER TABLE clientes ADD COLUMN segmento VARCHAR(20) | No existe | No | Cambio estructural realizado antes del registro formal de solicitudes |



### 1. ¿Qué cambios de la bitácora no tienen folio? Clasifícalos: ¿son de preparación del laboratorio o representan hallazgos?

Los cambios sin folio son:

- `GRANT UPDATE ON clientes TO app_ventas`
- `REVOKE UPDATE ON clientes FROM soporte_ana`
- `ALTER TABLE clientes ADD COLUMN segmento VARCHAR(20)`
- `ALTER TABLE clientes DISABLE TRIGGER trg_auditoria_clientes`
- `ALTER TABLE clientes ENABLE TRIGGER trg_auditoria_clientes`

Las operaciones `GRANT`, `REVOKE` y la creación de la columna `segmento` pueden clasificarse como actividades de preparación y desarrollo del laboratorio, ya que fueron ejecutadas como parte de los ejercicios.


### 2. La desactivación del disparador del LAB-01 (Actividad 14), ¿qué tan grave es como hallazgo? ¿Por qué? ¿Qué distingue la línea 163 de la 169?

Es un hallazgo de alta gravedad porque durante el periodo en que el disparador estuvo desactivado pudieron realizarse modificaciones que no quedarían registradas en la tabla de auditoría. Esto compromete la trazabilidad y la capacidad de reconstruir eventos.

La línea 163 corresponde al intento realizado por `app_ventas`, que no tenía privilegios suficientes para ejecutar la acción.

La línea 169 corresponde a la ejecución realizada por `postgres`, que sí tenía permisos y logró desactivar el mecanismo de auditoría.

### 3. ¿Qué limitación tiene esta conciliación si `log_statement` estuvo en `none` durante algún periodo?

La conciliación depende completamente de la existencia de registros en la bitácora. Si durante un periodo `log_statement` estuvo configurado en `none`, los cambios realizados en ese intervalo no quedaron registrados y no podrán compararse contra solicitudes de cambio posteriores.


### 4. ¿Quién debería realizar la conciliación: el DBA que hizo los cambios u otra persona?

La conciliación debería ser realizada por una persona distinta al DBA que ejecutó los cambios, preferentemente personal de auditoría, seguridad de la información o gobierno de datos.

La separación de funciones reduce conflictos de interés y proporciona una revisión independiente de la evidencia, fortaleciendo la confiabilidad del proceso de control.
