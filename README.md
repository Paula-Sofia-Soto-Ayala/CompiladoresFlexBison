# CompiladoresFlexBison
Interprete con Flex y Bison

# Inventory Management System

Este proyecto es un sistema de gestión de inventario que permite agregar, eliminar, actualizar y buscar ítems en un inventario. Además, mantiene un historial de cambios para rastrear todas las modificaciones realizadas.

## Funcionalidades

- **Agregar ítems `add`**: Añade nuevos ítems al inventario.
- **Eliminar ítems `remove`**: Elimina ítems existentes del inventario.
- **Actualizar ítems `update`**: Actualiza la cantidad de ítems en el inventario.
- **Mostrar inventario `show`**: Muestra todos los ítems en el inventario.
- **Guardar inventario `save`**: Guarda el inventario en un archivo.
- **Cargar inventario `load`**: Carga el inventario desde un archivo.
- **Buscar por categoría `search category`**: Busca ítems en el inventario por categoría.
- **Mostrar historial `show history`**: Muestra el historial de cambios realizados en el inventario.

### Comandos

- `add <nombre> = <cantidad> description <descripción> category <categoría>;`
  - Ejemplo: `add apples = 10 description fruit category food;`
- `remove <nombre>;`
  - Ejemplo: `remove apples;`
- `update <nombre> = <cantidad>;`
  - Ejemplo: `update apples = 15;`
- `show;`
  - Muestra todos los ítems en el inventario.
- `save <archivo>;`
  - Ejemplo: `save inventory.txt;`
- `load <archivo>;`
  - Ejemplo: `load inventory.txt;`
- `search category <categoría>;`
  - Ejemplo: `search category tech;`
- `search description <description>;`
  - Ejemplo: `search description fruit;`
- `show history;`
  - Muestra el historial de cambios realizados en el inventario.

#### Ejemplo de archivo `data.txt`

`txt
add apples = 10 description fruit category food;
add laptop = 5 description electronics category tech;
add milk = 20 description dairy category food;
show;
update apples = 15;
remove milk;
search category tech;
search category fruit;
save inventory.txt;
load inventory.txt;
show history;`

#### Estructura del Código

## Estructuras de Datos
**Item**: Representa un ítem en el inventario.
**Change**: Representa un cambio realizado en el inventario.

## Funciones Principales
**addItem**: Añade un ítem al inventario.
**removeItem**: Elimina un ítem del inventario.
**updateItem**: Actualiza la cantidad de un ítem en el inventario.
**showInventory**: Muestra todos los ítems en el inventario.
**saveInventory**: Guarda el inventario en un archivo.
**loadInventory**: Carga el inventario desde un archivo.
**searchByCategory**: Busca ítems por categoría.
**searchByDescription**: Busca ítems por descripción.
**showHistory**: Muestra el historial de cambios.
**getCurrentTime**: Obtiene la hora actual para registrar los cambios.

###### Ejecución

make clean
make
./inventory < data.txt








