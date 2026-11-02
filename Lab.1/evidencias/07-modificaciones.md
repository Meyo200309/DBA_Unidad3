# Actividad 07

### 1. ¿Qué nivel habría registrado la lectura del RFC? ¿Qué costo tendría en un servidor con miles de consultas por minuto?
La lectura del RFC mediante una sentencia SELECT habría sido registrada con un nivel de auditoría que incluya todas las sentencias, como all. Esto permitiría conocer tanto las modificaciones como las consultas de lectura.

El costo sería un crecimiento considerable de la bitácora y un mayor consumo de almacenamiento, procesamiento y recursos. En un servidor con miles de consultas por minuto podría generar grandes volúmenes de evidencia y afectar el rendimiento.

### 2. ¿Qué le falta a esta bitácora para revertir el cambio con certeza? (Lo resolverás en la Parte B.)
Le falta registrar el estado anterior de los datos. Aunque la bitácora muestra quién realizó el cambio, cuándo ocurrió, desde qué aplicación y cuál fue la sentencia ejecutada, no conserva el valor previo del registro antes de la modificación.
