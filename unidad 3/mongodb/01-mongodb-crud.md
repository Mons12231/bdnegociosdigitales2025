# MongoDB Crud

## Crear una base de datos 
**Solo se crea si contiene por lo menos una coleccion**

```json
use basededatos
```
## Crear una coleccion
`use bd1
db.createCollection('Empleado')`

## Mostrar collecciones 
`show collections`

## Insercion de un documento 
db.Empleado.insertOne(
  {
      nombre:'Soyla',
      apellido: 'Vaca',
      edad: 32,
      cuidad: 'San Miguel de las Piedras'
  }
)