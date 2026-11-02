# Actividad 10

### 1. ¿Por qué `momento` usa `TIMESTAMPTZ` y no `TIMESTAMP`?
Porque `TIMESTAMPTZ` almacena la fecha y hora junto con la zona horaria, lo que permite interpretar correctamente los eventos aunque existan usuarios, servidores o aplicaciones en distintas regiones o husos horarios.

### 2. ¿Por qué se guarda el registro completo en `JSONB` y no solo la columna que cambió?
Porque almacenar el registro completo permite conservar el estado exacto de la fila antes y después de la modificación. Esto facilita la auditoría, la investigación de incidentes y la recuperación del estado anterior.

Además, si en el futuro la estructura de la tabla cambia al agregar o eliminar columnas, los registros históricos seguirán conservando toda la información disponible en el momento en que ocurrió el cambio.

### 3. La tabla de auditoría también contendrá RFC. ¿Qué implica eso para su clasificación y su control de acceso?
Implica que la tabla de auditoría contiene información sensible y debe recibir el mismo nivel de protección que la tabla original o incluso uno superior. El acceso debe limitarse a personal autorizado y debe registrarse el uso de esos datos.
