POL-01 — Acceso

Objetivo: Reducir el riesgo de acceso no autorizado a datos personales y sistemas de información.

Alcance: Aplica a PostgreSQL, MongoDB, bitácoras, tablas operativas, auditorías y ambientes de desarrollo, pruebas y producción.

Regla: Todo acceso debe solicitarse formalmente y ser aprobado por el propietario del dato. Los accesos se revisarán trimestralmente y se retirarán cuando ya no exista una necesidad de negocio documentada.

Responsable:

Decide: Propietario del dato.
Ejecuta: DBA o administrador de MongoDB.

Excepciones: Accesos temporales por incidentes críticos. Deben ser autorizados por el propietario del dato o responsable de seguridad.

Evidencia: Registros de usuarios, roles, GRANT/REVOKE observados en LAB-01 e instantáneas de privilegios observadas en LAB-02.

Revisión: Trimestral.
