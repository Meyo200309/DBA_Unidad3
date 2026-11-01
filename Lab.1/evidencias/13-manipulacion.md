# Actividad 14

### 1. ¿Qué evidencia permite detectar que hubo un cambio sin auditar?

La evidencia se encuentra en la bitácora del servidor. Allí quedaron registradas la desactivación del disparador, la modificación realizada sobre los datos y la posterior reactivación del disparador. Aunque la tabla de auditoría no contiene el evento, la bitácora permite demostrar que el mecanismo de auditoría fue deshabilitado temporalmente y que se realizó un cambio durante ese periodo.

### 2. ¿Qué control administrativo (no técnico) reduciría este riesgo?

La separación de responsabilidades, las revisiones periódicas de auditoría, la supervisión por parte de otra área y la obligación de justificar cambios administrativos ayudarían a reducir este riesgo. También es recomendable que cualquier modificación relacionada con mecanismos de auditoría requiera autorización formal y quede documentada.

### 3. Relaciona esta actividad con el principio de separación de funciones de la Unidad II.

Esta actividad muestra que quien administra la base de datos no debería ser la misma persona que supervisa o custodia la evidencia de auditoría. Si una sola persona tiene control total sobre los datos y los mecanismos de auditoría, puede modificar información y ocultar rastros de sus acciones. La separación de funciones reduce este riesgo al distribuir las responsabilidades entre diferentes personas o áreas con capacidades de supervisión independientes.
