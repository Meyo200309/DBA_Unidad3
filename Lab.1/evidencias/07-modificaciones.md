# Actividad 07

### 1. ¿Qué nivel habría registrado la lectura del RFC? ¿Qué costo tendría en un servidor con miles de consultas por minuto?

La lectura del RFC mediante una sentencia SELECT habría sido registrada con un nivel de auditoría que incluya todas las sentencias, como all. Esto permitiría conocer tanto las modificaciones como las consultas realizadas sobre los datos.

El costo sería un crecimiento considerable de la bitácora y un mayor consumo de almacenamiento, procesamiento y recursos. En un servidor con miles de consultas por minuto podría generar grandes volúmenes de registros y afectar el rendimiento general del sistema.

### 2. ¿Qué le falta a esta bitácora para revertir el cambio con certeza? (Lo resolverás en la Parte B.)

Le falta registrar el estado anterior de los datos. Aunque la bitácora muestra quién realizó el cambio, cuándo ocurrió, desde qué aplicación y cuál fue la sentencia ejecutada, no conserva automáticamente los valores previos de las columnas modificadas.
