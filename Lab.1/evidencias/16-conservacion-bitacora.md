### 1. Un resumen SHA-256, ¿impide que alguien modifique la bitácora? ¿Qué permite demostrar?
No. Un resumen SHA-256 no impide que un archivo sea modificado. Su propósito es verificar posteriormente si el contenido permanece intacto. Si el archivo cambia, el hash calculado será distinto.

### 2. ¿Dónde debería guardarse el hash para que sea útil como control de integridad?
Debe almacenarse en una ubicación distinta a la de la bitácora, preferiblemente en otro sistema, repositorio o medio de almacenamiento protegido. De esta manera puede utilizarse para detectar modificaciones o pérdida de evidencia.

### 3. La guía NIST SP 800-92 trata la conservación y protección de bitácoras. ¿Qué riesgos tiene conservar la bitácora solo en el servidor que la produce?
Existe riesgo de pérdida de evidencia por fallos de hardware, errores administrativos, reinstalaciones del sistema, eliminación accidental o actividades maliciosas. Además, una persona con acceso privilegiado podría alterar o borrar la evidencia sin que quede rastro inmediato.

### 4. Propón durante cuánto tiempo conservarías esta bitácora y justifica tu criterio.
Conservaría la bitácora durante al menos un año, y en algunos entornos más, dependiendo del régimen regulatorio y del riesgo operativo. Este periodo permite realizar auditorías, investigar incidentes con retraso y mantener evidencia histórica suficiente.

## Observación

Se intentó exportar la bitácora mediante las funciones administrativas indicadas en la guía. Sin embargo, la cuenta proporcionada para el laboratorio no dispone de privilegios de superusuario, por lo que PostgreSQL rechazó el acceso a las funciones necesarias para leer el archivo de bitácora.

Errores observados:

- permission denied for function pg_read_file
- must be superuser or have privileges of pg_read_all_settings to examine "data_directory"

Por lo anterior, no fue posible exportar directamente la bitácora del entorno del laboratorio con los permisos disponibles.
