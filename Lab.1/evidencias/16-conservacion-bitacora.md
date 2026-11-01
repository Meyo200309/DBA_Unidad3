

### 1. Un resumen SHA-256, ¿impide que alguien modifique la bitácora? ¿Qué permite demostrar?

No. Un resumen SHA-256 no impide que un archivo sea modificado. Su propósito es permitir verificar posteriormente si el contenido permanece intacto. Si el archivo cambia, el hash calculado será diferente.

### 2. ¿Dónde debería guardarse el hash para que sea útil como control de integridad?

Debe almacenarse en una ubicación distinta a la de la bitácora, preferiblemente en otro sistema, repositorio o medio de almacenamiento protegido. De esta manera puede utilizarse para detectar modificaciones no autorizadas.

### 3. La guía NIST SP 800-92 trata la conservación y protección de bitácoras (REF-U3-03). ¿Qué riesgos tiene conservar la bitácora solo en el servidor que la produce?

Existe riesgo de pérdida de evidencia por fallos de hardware, errores administrativos, reinstalaciones del sistema, eliminación accidental o actividades maliciosas. Además, una persona con privilegios suficientes podría modificar o eliminar tanto la bitácora como la configuración que la genera.

### 4. Propón durante cuánto tiempo conservarías esta bitácora y justifica tu criterio. No existe una cifra única correcta.

Conservaría la bitácora durante al menos un año. Este periodo permite realizar auditorías, investigar incidentes reportados con retraso y mantener evidencia histórica suficiente para fines operativos y de seguridad.

## Observación

Se intentó exportar la bitácora mediante las funciones administrativas indicadas en la guía.

Sin embargo, la cuenta proporcionada para el laboratorio no dispone de privilegios de superusuario, por lo que PostgreSQL rechazó el acceso a las funciones necesarias para leer el archivo de bitácora y consultar información protegida de configuración.

Errores observados:

- permission denied for function pg_read_file
- must be superuser or have privileges of pg_read_all_settings to examine "data_directory"

Por lo anterior, no fue posible exportar directamente la bitácora del entorno del laboratorio con los permisos disponibles.
