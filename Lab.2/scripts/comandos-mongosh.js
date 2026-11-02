// Actividad 1
db.version()
db.adminCommand({ buildInfo: 1 }).modules
db.serverCmdLineOpts().parsed

// Actividad 2
db.getProfilingStatus()

// Actividad 3
db.setProfilingLevel(2)

db.clientes.find(
  { ciudad: "Culiacán" },
  { nombre: 1, ciudad: 1 }
).toArray()

db.clientes.updateOne(
  { _id: 3 },
  { $set: { rfc: "GAMA780912XYZ" } }
)

db.clientes.deleteOne({ _id: 2 })

// Actividad 4
db.setProfilingLevel(
  1,
  {
    filter: {
      op: {
        $in: ["insert", "update", "remove"]
      }
    }
  }
)

// Actividad 5
db.clientes.updateOne(
  { _id: 1 },
  { $set: { telefono: "6670000000" } }
)

// Actividad 7
db.grantRolesToUser(
  "app_ventas",
  [
    { role: "dbAdmin", db: "comercial" }
  ]
)

db.revokeRolesFromUser(
  "app_ventas",
  [
    { role: "dbAdmin", db: "comercial" }
  ]
)
