# Act.3

### 1. ¿Puedes saber cuál era el RFC antes del cambio con la información de `system.profile`?

No. `system.profile` registra la operación ejecutada, el filtro utilizado, el usuario, la aplicación, el cliente y otros detalles de ejecución, pero no conserva el valor anterior del documento. Es posible saber que se actualizó el RFC y cuál fue el nuevo valor enviado en la operación, pero no cuál era el valor que existía antes del cambio.

### 2. ¿Puedes saber qué datos tenía el documento eliminado?

No. El perfilador registra que se ejecutó una operación `remove`, el criterio utilizado para localizar el documento y estadísticas de ejecución, pero no almacena una copia completa del documento eliminado. Por lo tanto, no es posible reconstruir todos los datos del registro borrado únicamente a partir de `system.profile`.

### 3. A diferencia de `log_statement = 'mod'` en PostgreSQL, el nivel 2 sí registró la consulta. ¿Qué ventaja y qué riesgo tiene eso?

La principal ventaja es que permite auditar también las lecturas de información, no solamente las modificaciones. Esto facilita las investigaciones de seguridad y permite conocer quién consultó determinados datos y cuándo lo hizo.


### 4. ¿Por qué el campo `user` incluye `@comercial`?

Porque en MongoDB los usuarios se definen dentro de una base de datos específica. El valor `app_ventas@comercial` indica que el usuario autenticado es `app_ventas` y que dicho usuario pertenece a la base de datos `comercial`, donde se almacenan sus credenciales y roles.
