-- Actualizar estadísticas para obtener estimaciones de filas
ANALYZE;

-- Inventario de tablas de usuario
SELECT
    n.nspname AS esquema,
    c.relname AS tabla,
    pg_get_userbyid(c.relowner) AS propietario_tecnico,
    c.reltuples::bigint AS filas_estimadas,
    pg_size_pretty(pg_total_relation_size(c.oid)) AS tamano,
    obj_description(c.oid, 'pg_class') AS descripcion
FROM pg_class c
JOIN pg_namespace n
    ON n.oid = c.relnamespace
WHERE c.relkind = 'r'
  AND n.nspname NOT IN ('pg_catalog', 'information_schema')
ORDER BY esquema, tabla;

-- Inventario de vistas
SELECT
    table_schema AS esquema,
    table_name AS vista
FROM information_schema.views
WHERE table_schema NOT IN ('pg_catalog', 'information_schema')
ORDER BY esquema, vista;

-- Inventario de esquemas de trabajo
SELECT
    schema_name AS esquema
FROM information_schema.schemata
WHERE schema_name NOT IN ('pg_catalog', 'information_schema')
ORDER BY schema_name;

-- Inventario de columnas de clientes
SELECT
    c.ordinal_position AS posicion,
    c.column_name AS columna,
    c.data_type AS tipo,
    c.character_maximum_length AS longitud,
    c.is_nullable AS acepta_nulos,
    c.column_default AS valor_por_defecto,
    col_description('public.clientes'::regclass, c.ordinal_position) AS descripcion
FROM information_schema.columns c
WHERE c.table_schema = 'public'
  AND c.table_name = 'clientes'
ORDER BY c.ordinal_position;
