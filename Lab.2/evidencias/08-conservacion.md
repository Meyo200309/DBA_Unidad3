# Act.8

### 1. Menciona tres formas en que la evidencia del perfilador o de la bitácora puede perderse sin que nadie la borre deliberadamente.

- Reiniciar el servidor cuando el perfilador está configurado mediante comandos temporales, ya que el nivel de perfilado vuelve a su valor predeterminado.
- Alcanzar el límite de tamaño de `system.profile`, provocando que registros antiguos sean reemplazados por nuevos.
- Utilizar `getLog`, cuya información se mantiene únicamente en memoria y se pierde al reiniciar el servicio.

### 2. ¿Por qué el tamaño de 1 MB de `system.profile` es un problema de conservación y no solo de espacio?

Porque una colección limitada a 1 MB puede sobrescribirse rápidamente en entornos con mucha actividad. Esto significa que la evidencia más antigua desaparece aunque nadie la elimine manualmente. El problema principal es la pérdida de información histórica necesaria para auditorías e investigaciones, no únicamente el espacio ocupado.

### 3. ¿Por qué `getLog` sirve para interpretar pero no para conservar?

Porque `getLog` proporciona una vista temporal de los eventos recientes almacenados en memoria. Resulta útil para analizar lo que está ocurriendo en ese momento o revisar eventos recientes, pero no constituye un mecanismo de conservación permanente. Al reiniciar el servidor o superar la capacidad disponible, la información desaparece si no fue exportada previamente.
