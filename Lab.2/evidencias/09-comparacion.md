# ACT.9
# Comparación de mecanismos de auditoría

| Evento auditable | PostgreSQL (bitácora + disparador) | MongoDB Community (perfilador + bitácora) | MongoDB Enterprise/Atlas (auditoría nativa) |
|------------------|------------------------------------|-------------------------------------------|---------------------------------------------|
| Acceso exitoso | Sí | Sí | Documentado, no practicado |
| Acceso fallido | Sí | Sí | Documentado, no practicado |
| Cambio de privilegios | Parcial. La bitácora registra GRANT y REVOKE, pero requiere que el registro esté habilitado. | Parcial. Se detecta mediante instantáneas de privilegios, no directamente. | Documentado, no practicado |
| Cambio de estructura | Sí | Sí | Documentado, no practicado |
| Modificación de datos | Sí | Sí | Documentado, no practicado |
| Valor anterior del dato | Sí. Mediante la tabla de auditoría con disparadores. | No. El perfilador registra la operación pero no conserva el valor anterior. | Documentado, no practicado |
| Lectura de datos sensibles | Parcial. Requiere registrar todas las consultas o mecanismos adicionales. | Sí. El nivel 2 del perfilador registra consultas. | Documentado, no practicado |
| Cambio de configuración del registro | Sí | Sí | Documentado, no practicado |

