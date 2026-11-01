# Actividad 12

### 1. Compara tu hipótesis de la Actividad 11 con este resultado.
La auditoría permite identificar quién realizó el cambio, cuándo ocurrió, desde qué dirección IP se realizó, qué aplicación lo ejecutó y exactamente qué dato fue modificado. Además, conserva tanto el valor anterior como el nuevo, proporcionando evidencia suficiente para investigar el incidente.

### 2. Escribe la sentencia UPDATE que restauraría el valor anterior.

```sql
UPDATE clientes
SET rfc = 'GAMA780912XYZ'
WHERE id = 3;
```

### 3. ¿Qué columna conserva más valor para una investigación: aplicacion o ip_cliente? ¿Cuál puede falsificar el cliente con más facilidad?

La columna ip_cliente suele aportar más valor porque indica desde qué origen de red se realizó la operación y es información obtenida por el servidor durante la conexión.
La columna aplicacion también es útil para distinguir entre distintas aplicaciones o procesos, pero puede ser modificada fácilmente por el cliente al establecer la conexión. Por ello, resulta más sencilla de falsificar que ip_cliente y debe considerarse evidencia complementaria, no una prueba definitiva de identidad.
