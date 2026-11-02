# Actividad 01

| # | Hallazgo | Registros | Regla de calidad | ¿Quién decide la corrección? | Acción propuesta |
|---|-----------|------------|------------------|------------------------------|------------------|
| C1 | Posible cliente duplicado por correo electrónico | 1, 7 | Unicidad del correo | Área dueña del dato (Ventas o Atención a Clientes) | Verificar si ambos registros corresponden a la misma persona y fusionar o corregir según corresponda |
| C2 | RFC incompleto | 7 | Formato del RFC | Área responsable de la captura de datos | Confirmar el RFC correcto con la documentación del cliente y actualizar el registro |
| C3 | Correo electrónico con formato no válido | 8 | Validez del correo electrónico | Área responsable de la captura de datos | Solicitar el correo correcto y actualizar el registro |
| C4 | Edad fuera de rango permitido | 8 | Validez del dominio de valores | Área responsable de la captura de datos | Verificar la edad real del cliente y corregir el dato |
| C5 | RFC ausente | 8 | Completitud | Área responsable de la captura de datos | Recabar el RFC faltante o justificar su ausencia conforme a la política del negocio |
| C6 | Teléfono con longitud incorrecta | 8 | Consistencia del formato | Área responsable de la captura de datos | Capturar nuevamente el número telefónico con el formato correcto |
| C7 | Código postal con longitud incorrecta | 8 | Consistencia del formato | Área responsable de la captura de datos | Verificar y corregir el código postal |

# Preguntas y Respuestas

### 1. ¿Por qué el DBA no debe corregir por su cuenta el RFC del registro 7?

Porque el DBA es responsable de administrar la base de datos, pero no es el propietario del dato ni conoce cuál es el valor correcto. Modificar el RFC sin validación podría introducir errores adicionales y afectar la integridad de la información. La corrección debe ser autorizada y validada por el área responsable del negocio.

### 2. ¿Qué restricción (`CHECK`, `UNIQUE`) habría evitado cada hallazgo? ¿Quién debería aprobar agregarla?

- **C1 (correo duplicado):** restricción `UNIQUE` sobre el correo electrónico normalizado.
- **C2 (RFC incompleto):** restricción `CHECK` con una expresión regular para validar el formato del RFC.
- **C3 (correo inválido):** restricción `CHECK` para validar el formato del correo electrónico.
- **C4 (edad fuera de rango):** restricción `CHECK` para permitir únicamente edades válidas.
- **C5 (RFC ausente):** restricción `NOT NULL`.
- **C6 (teléfono inválido):** restricción `CHECK` para validar longitud y formato.
- **C7 (código postal inválido):** restricción `CHECK` para validar longitud y formato.

La incorporación de estas restricciones debe ser aprobada por los responsables del negocio y los propietarios de los datos, ya que pueden afectar procesos existentes de captura y operación.

### 3. Si el DBA corrige un dato, ¿qué mecanismo del LAB-01 (Parte B) dejará evidencia del cambio?

La evidencia quedaría registrada mediante la tabla de auditoría implementada con disparadores (`triggers`) en el LAB-01. Dicho mecanismo conserva el usuario, la fecha, la operación realizada y los valores anteriores y posteriores del registro modificado.
