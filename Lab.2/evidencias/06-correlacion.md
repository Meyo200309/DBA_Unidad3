# Actividad 06

### 1. ¿Qué usuario cambió la configuración del perfilador? ¿Qué dos eventos lo demuestran?

El usuario que cambió la configuración del perfilador fue `admin`.

La evidencia se obtiene correlacionando dos eventos:

1. El evento `Profiler settings changed`, que registra el cambio de configuración y muestra la conexión asociada mediante el valor `ctx`.
2. El evento `Successfully authenticated` correspondiente al mismo valor de `ctx`, donde se identifica al usuario autenticado como `admin`.

### 2. ¿Qué condición debe cumplirse para que esta correlación sea válida? (Piensa en qué pasa si el servidor se reinicia y los números de conexión vuelven a empezar.)

La correlación solo es válida cuando ambos eventos pertenecen al mismo periodo de ejecución del servidor y no existe ambigüedad respecto al identificador de conexión (`ctx`).

Si el servidor se reinicia, los identificadores de conexión pueden volver a comenzar desde valores similares. Por ello también deben considerarse las marcas de tiempo y el contexto temporal de los eventos para evitar asociar incorrectamente actividades de sesiones diferentes.

### 3. ¿Por qué es relevante que quede registrado un cambio de configuración del propio mecanismo de registro?

Porque permite detectar intentos de modificar, desactivar o alterar el propio sistema de auditoría. Los cambios sobre el mecanismo de registro pueden afectar la capacidad de conservar evidencia y reconstruir incidentes.
