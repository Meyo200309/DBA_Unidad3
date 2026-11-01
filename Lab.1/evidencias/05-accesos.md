# actividad 5

### 1. La bitácora registra el usuario `app_ventas` en el intento fallido. ¿Eso prueba que la aplicación de ventas intentó entrar? ¿Qué prueba realmente?

No. Lo que prueba es que alguien intentó autenticarse utilizando el nombre de usuario `app_ventas`. La bitácora registra las credenciales presentadas durante el intento de conexión, pero no puede garantizar que la solicitud proviniera realmente de la aplicación legítima de ventas. Cualquier cliente podría intentar conectarse utilizando ese nombre de usuario.

### 2. ¿Qué información adicional registra PostgreSQL cuando el rol no existe? ¿Por qué aparece en la bitácora y no en el mensaje que recibe el cliente?

PostgreSQL registra un mensaje adicional indicando que el rol solicitado no existe. Esta información aparece en la bitácora porque resulta útil para tareas de administración, diagnóstico y seguridad.

No se muestra al cliente porque revelar demasiados detalles sobre los usuarios existentes podría facilitar el reconocimiento del sistema por parte de un atacante. El cliente recibe un mensaje genérico de fallo de autenticación, mientras que el administrador dispone de información más detallada en los registros.

### 3. ¿Por qué `app=[unknown]` en el intento fallido, pero `app=app-ventas-web` en la desconexión?

Porque el nombre de la aplicación solo puede registrarse después de que la conexión se autentica correctamente y se establece la sesión. Durante un intento fallido PostgreSQL todavía no dispone de una sesión autorizada completa, por lo que aparece `app=[unknown]`.

Una vez autenticado el usuario, PostgreSQL recibe y registra el valor de `application_name`, por lo que en la desconexión aparece `app=app-ventas-web`.

### 4. ¿Qué patrón de varias líneas te haría sospechar de un ataque de fuerza bruta? Escribe la consulta que contaría los intentos fallidos por usuario.

Un posible indicador sería observar múltiples errores de autenticación en un corto periodo de tiempo, especialmente contra el mismo usuario o desde la misma dirección IP. También resultaría sospechoso ver intentos repetidos contra muchos usuarios distintos desde un mismo origen.

Consulta para contar intentos fallidos por usuario:

```sql
SELECT
    substring(linea FROM 'user=([^ ]+)') AS usuario,
    COUNT(*) AS intentos_fallidos
FROM dba.bitacora
WHERE linea LIKE '%password authentication failed%'
GROUP BY usuario
ORDER BY intentos_fallidos DESC;
```
