# Actividad 13

### 1. El cliente `Pedro Ruiz` ya no existe en `clientes`. ¿Dónde queda evidencia de que existió y de sus datos?

La evidencia permanece en la tabla de auditoría. Los registros de tipo `INSERT` y `DELETE` conservan la información del cliente antes de que fuera eliminado, incluyendo sus datos y el contexto de la operación. Esto permite demostrar que el registro existió aunque ya no se encuentre en la tabla principal.

### 2. ¿Por qué `ip_cliente` está vacía en los eventos 2 y 3?

Porque las operaciones fueron realizadas por el administrador mediante una conexión local al servidor. En este tipo de conexión no existe una dirección IP remota asociada al cliente, por lo que el campo ip_cliente queda vacío o nulo.

### 3. La política de retención de la Unidad II pedía eliminar datos cuando ya no fueran necesarios. ¿Qué conflicto aparece? ¿Quién debe resolverlo?

Aparece un conflicto entre la necesidad de conservar información para fines de auditoría y la obligación de eliminar datos que ya no son necesarios. Aunque el registro fue eliminado de la tabla principal, sus datos siguen existiendo en la auditoría.

La resolución de este conflicto corresponde a la organización mediante sus políticas de gobierno de datos, cumplimiento normativo, auditoría y protección de datos. Estas políticas deben definir cuánto tiempo conservar los registros de auditoría y cuándo deben eliminarse o anonimizarse.
