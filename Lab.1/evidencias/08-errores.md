# Actividad 08

### 1. ¿El intento de `soporte_ana` causó algún daño? ¿Por qué debe auditarse de todos modos?
No. La operación fue rechazada por PostgreSQL debido a que el usuario no contaba con los permisos necesarios para eliminar registros de la tabla. Como resultado, los datos permanecieron sin cambio.

Debe auditarse porque incluso los intentos fallidos pueden indicar abuso de privilegios, errores de configuración o actividades sospechosas que requieren investigación.

### 2. ¿Qué diferencia hay entre un error de autorización (esta actividad) y uno de autenticación (Actividad 5)?
Un error de autenticación ocurre cuando PostgreSQL no puede verificar la identidad del usuario, por ejemplo debido a una contraseña incorrecta o porque el usuario no existe.

Un error de autorización ocurre después de que el usuario ya fue identificado correctamente, pero intenta realizar una acción para la cual no tiene permisos suficientes. En este caso, el usuario sí existe y está autenticado, pero no está autorizado para la operación.

### 3. ¿Qué indica el error de `DROP ROLE` sobre el orden correcto para dar de baja a un usuario?
Indica que antes de eliminar un usuario deben revisarse y eliminarse sus dependencias, como privilegios, permisos o propiedades sobre objetos de la base de datos.
