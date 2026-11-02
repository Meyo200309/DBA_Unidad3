# Act.2

### 1. ¿Puedes demostrar qué cambió? ¿Y quién se conectó a esa hora?

No es posible demostrar qué cambió porque el perfilador estaba desactivado (`was: 0`) y no existe ningún registro de la operación `updateOne()` que modificó el RFC. Tampoco hay evidencia del valor anterior ni del valor nuevo dentro de los registros disponibles.

Sí es posible demostrar que hubo conexiones de la aplicación en ese momento. La bitácora registra la presencia de la aplicación `app-ventas-web`, así como eventos relacionados con la conexión y la autenticación satisfactoria de un cliente.

### 2. ¿Por qué `mongosh` abre varias conexiones (`conn8`, `conn9`, …) para una sola instrucción? ¿Cuál es la que se autentica?

MongoDB utiliza varias conexiones internas para diferentes tareas, como el intercambio de metadatos, el establecimiento de la sesión, la autenticación y la ejecución de operaciones. Por ese motivo pueden aparecer varias conexiones asociadas a una única instrucción ejecutada desde `mongosh`.

La conexión que se autentica es aquella en la que la bitácora registra el evento `Successfully authenticated`. En el resultado observado corresponde a `conn9`, ya que es la primera conexión donde MongoDB confirma que la autenticación fue exitosa.
