# Act.5

### 1. ¿Qué campo distingue un acceso fallido de uno exitoso?

El campo `msg` permite distinguirlos. Un acceso exitoso aparece con el mensaje `Successfully authenticated`, mientras que un acceso fallido aparece con el mensaje `Failed to authenticate`.

### 2. ¿Qué diferencia hay entre el error de contraseña incorrecta y el de usuario inexistente? ¿Por qué el cliente recibe el mismo mensaje en ambos casos?

Cuando la contraseña es incorrecta MongoDB encuentra al usuario pero no puede validar las credenciales generando un error relacionado con la autenticación SCRAM. Cuando el usuario no existe, MongoDB no encuentra ninguna cuenta asociada al nombre proporcionado.

A pesar de la diferencia interna, el cliente recibe el mismo mensaje genérico de autenticación fallida para evitar revelar información sobre los usuarios existentes. Esto reduce el riesgo de que un atacante utilice los mensajes de error para identificar cuentas válidas.

### 3. ¿Por qué el nombre de la aplicación del intento fallido es `mongosh 2.10.0` y no `app-ventas-web`?

Porque los intentos fallidos fueron realizados directamente desde la herramienta `mongosh` sin especificar el parámetro `appName=app-ventas-web` en la cadena de conexión. En ese caso MongoDB registra como aplicación el nombre del cliente que realiza la conexión, que es `mongosh 2.10.0`.
