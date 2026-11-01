# actividad 3

### 1. ¿Puedes demostrar quién modificó el RFC?

No. Con la configuración actual no existe evidencia en la bitácora que permita identificar qué usuario ejecutó el `UPDATE`. Las sentencias SQL no se registran y tampoco se registran las conexiones, por lo que no es posible atribuir el cambio a un usuario específico.

### 2. ¿Puedes demostrar que el cambio no lo hizo `soporte_ana`?

No. Al no existir registros de conexiones ni de sentencias ejecutadas, tampoco es posible descartar que `soporte_ana` haya realizado el cambio. La ausencia de evidencia impide demostrar tanto la autoría como la no autoría de una modificación.

### 3. Los privilegios de la Unidad II, ¿impidieron el cambio? ¿Debían impedirlo?

No. El cambio se realizó correctamente porque el usuario utilizado por la aplicación contaba con permisos suficientes para actualizar datos en la tabla correspondiente. En este caso los privilegios no debían impedir el cambio, ya que la operación formaba parte de las funciones permitidas para la aplicación. El problema no fue de autorización, sino de falta de auditoría.

### 4. ¿Qué tendría que haber estado configurado antes del incidente?

Debían estar habilitados previamente los mecanismos de auditoría y registro, como el registro de conexiones y desconexiones, el registro de sentencias relevantes (`UPDATE`, `INSERT`, `DELETE`) o algún sistema de auditoría que permitiera identificar al usuario, la aplicación, el momento y la operación realizada. Estas configuraciones deben existir antes de que ocurra el incidente, ya que no es posible reconstruir información que nunca fue registrada.
