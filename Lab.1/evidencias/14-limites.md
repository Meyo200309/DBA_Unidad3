# Actividad 15

### 1. Si `clientes` tuviera un millón de registros, ¿qué ocurriría con la auditoría tras un `UPDATE` sin `WHERE`?
La auditoría generaría un registro por cada fila modificada. Si la tabla tuviera un millón de registros, se crearían aproximadamente un millón de entradas de auditoría, cada una almacenando los datos antes y después del cambio.

Esto provocaría un crecimiento muy rápido de la tabla de auditoría, un mayor consumo de almacenamiento y un impacto significativo en el rendimiento de la operación.

### 2. Propón quién podría autorizar la depuración de `auditoria.cambios_clientes`.
La depuración debería ser autorizada por responsables con autoridad sobre la información y el cumplimiento normativo, como el responsable de seguridad de la información, el área de auditoría o un comité de gobierno de datos.

### 3. ¿Por qué `log_statement = 'all'` puede convertir la bitácora en un nuevo depósito de datos sensibles?
Porque registraría todas las sentencias ejecutadas, incluyendo consultas que contienen datos personales, financieros o confidenciales. Las sentencias podrían revelar nombres, RFC, correos electrónicos o información de negocio.
