# Informe – Trazabilidad y Auditoría en MongoDB Community

## 1. Despliegue, edición y limitación

El laboratorio se realizó sobre MongoDB Community Edition 7.0.43 con autenticación habilitada. La verificación se realizó mediante la consulta de información del servidor, observando que el arreglo `modules` se encontraba vacío. Esto confirmó que no se estaba utilizando MongoDB Enterprise ni una instancia de Atlas con auditoría nativa.

La principal limitación observada es que MongoDB Community no incluye la funcionalidad de auditoría nativa disponible en Enterprise y Atlas. Como consecuencia, ciertos eventos de seguridad, especialmente los relacionados con cambios de privilegios y administración de usuarios, no quedan registrados de manera detallada ni atribuidos directamente a un responsable.

Durante el laboratorio fue necesario recurrir a mecanismos alternativos como el perfilador, la bitácora de `mongod` y las instantáneas de privilegios para obtener evidencia parcial de algunos eventos.


## 2. Perfilador

El perfilador se utilizó para registrar operaciones ejecutadas sobre la base de datos `comercial`.

Inicialmente se encontraba desactivado, por lo que las modificaciones realizadas no dejaron evidencia suficiente para identificar la operación ejecutada. Posteriormente se activó en nivel 2, permitiendo registrar consultas, modificaciones y eliminaciones realizadas sobre la colección `clientes`.

Los documentos almacenados en `system.profile` permitieron conocer:

- Usuario autenticado.
- Aplicación utilizada.
- Dirección IP del cliente.
- Fecha y hora de la operación.
- Tipo de operación ejecutada.
- Cantidad de documentos afectados.

Posteriormente se aplicó un filtro para registrar únicamente operaciones `insert`, `update` y `remove`, reduciendo significativamente el volumen de información almacenada.

El principal costo del perfilador es el consumo adicional de recursos y almacenamiento. Mientras más operaciones se registran, mayor es el impacto en rendimiento y capacidad de conservación.


## 3. Bitácora de mongod

La bitácora de MongoDB permitió observar eventos de autenticación, conexiones y cambios de configuración.

Se comprobó que los accesos exitosos y fallidos quedan registrados indicando información como:

- Usuario.
- Cliente de origen.
- Aplicación utilizada.
- Resultado de autenticación.

También fue posible identificar cambios en la configuración del perfilador mediante eventos como `Profiler settings changed`.

La bitácora puede almacenarse en memoria mediante `getLog` o de forma persistente mediante la configuración `systemLog.path` dentro del archivo de configuración del servidor.

Los registros permitieron correlacionar cambios de configuración utilizando el identificador de conexión (`ctx`) y los eventos de autenticación asociados.


## 4. Privilegios

La auditoría de privilegios representó la mayor limitación observada en MongoDB Community.

A pesar de habilitar el perfilador y revisar la bitácora, no fue posible obtener evidencia directa de la operación que otorgó el rol `dbAdmin` al usuario `app_ventas`.

Como mecanismo compensatorio se implementaron instantáneas periódicas de privilegios almacenadas en una colección de auditoría. La comparación entre instantáneas permitió detectar que el rol había sido agregado.

Sin embargo, este método presenta limitaciones importantes:

- No identifica quién realizó el cambio.
- No indica el momento exacto.
- Solo permite determinar que el cambio ocurrió entre dos capturas.

Por ello la solución únicamente ofrece evidencia parcial de modificaciones sobre privilegios.


## 5. Conservación

Durante el laboratorio se observaron diversos riesgos relacionados con la conservación de evidencia.

El nivel de perfilado no permanece activo después de reiniciar el servidor cuando se configura mediante comandos temporales.

La memoria utilizada por `getLog` también se vacía al reiniciar el servicio, eliminando los eventos almacenados.

Además, la colección `system.profile` posee un tamaño limitado, por lo que los eventos antiguos pueden ser reemplazados por nuevos registros.

Para reducir estos riesgos se realizaron exportaciones de:

- `system.profile`
- Bitácora de `mongod`
- Archivos de comandos ejecutados

Asimismo se generaron hashes SHA-256 para facilitar verificaciones posteriores de integridad.


## 6. Comparación

Las pruebas realizadas permitieron comparar tres enfoques distintos de auditoría.

PostgreSQL complementado con bitácora y disparadores proporciona la capacidad de identificar quién modificó un dato y conservar tanto el valor anterior como el nuevo.

MongoDB Community permite identificar usuarios, operaciones y consultas mediante el perfilador y la bitácora, pero no conserva automáticamente los valores previos de los documentos ni registra adecuadamente los cambios de privilegios.

MongoDB Enterprise y Atlas incluyen auditoría nativa especializada para eventos de seguridad, administración y acceso, aunque dichas capacidades solamente fueron revisadas mediante documentación y no fueron practicadas durante el laboratorio.

En términos de capacidad de reconstrucción de incidentes, PostgreSQL mostró una ventaja significativa cuando se implementó una tabla de auditoría específica para los datos.


## 7. Recomendación

Para una organización que necesite auditar cambios de privilegios en MongoDB recomendaría utilizar MongoDB Enterprise o un servicio Atlas con auditoría nativa habilitada.

Hechos verificados durante el laboratorio:

- MongoDB Community no registró directamente la asignación de roles mediante el perfilador.
- La bitácora estándar tampoco proporcionó evidencia suficiente para identificar al responsable del cambio.
- Las instantáneas de privilegios solo permitieron detectar diferencias entre dos momentos.

Supuestos razonables basados en la documentación:

- La auditoría nativa de Enterprise y Atlas proporciona registros específicos de eventos administrativos y de seguridad.
- Estos registros permitirían obtener trazabilidad más completa sobre la administración de usuarios y privilegios.

Por lo tanto, cuando la organización requiera evidencia formal de cambios de permisos y cumplimiento normativo, la opción más adecuada sería utilizar una solución con auditoría nativa en lugar de depender únicamente de controles compensatorios.
