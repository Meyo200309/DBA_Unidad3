# Actividad 04

### 1. ¿Qué perdiste de evidencia al aplicar el filtro? ¿Qué ganaste?

Se perdió evidencia de las operaciones de lectura, como las consultas `find`, ya que el filtro solo conserva operaciones de tipo `insert`, `update` y `remove`. Por lo tanto, ya no es posible saber qué documentos fueron consultados ni quién los consultó.

Se ganó una reducción importante en el volumen de información almacenada. La colección `system.profile` contiene únicamente las modificaciones de datos, lo que facilita el análisis, reduce el consumo de espacio y disminuye la cantidad de registros que deben revisarse durante una investigación.

### 2. ¿Qué filtro usarías si solo interesaran operaciones sobre la colección `clientes`?

Utilizaría un filtro que conserve únicamente operaciones realizadas sobre el espacio de nombres correspondiente a la colección `clientes`:

```javascript
db.setProfilingLevel(1, {
  filter: {
    ns: "comercial.clientes",
    op: { $in: ["insert", "update", "remove"] }
  }
})
```

De esta manera solo se registrarían inserciones, modificaciones y eliminaciones realizadas específicamente sobre la colección `clientes`.
