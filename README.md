# CompiladoresFlexBison
Interprete con Flex y Bison

## Inventory Management System

Este proyecto es un sistema de gestión de inventario que permite agregar, eliminar, actualizar y buscar ítems en un inventario. Además, mantiene un historial de cambios para rastrear todas las modificaciones realizadas.

### Funcionalidades

- **Agregar ítems `add`**: Añade nuevos ítems al inventario.
- **Eliminar ítems `remove`**: Elimina ítems existentes del inventario.
- **Actualizar ítems `update =/category/description`**: Actualiza la cantidad/category/descripción de ítems en el inventario.
- **Mostrar inventario `show`**: Muestra todos los ítems en el inventario.
- **Guardar inventario `save`**: Guarda el inventario en un archivo.
- **Cargar inventario `load`**: Carga el inventario desde un archivo.
- **Buscar por categoría `search category/description/name`**: Busca ítems en el inventario por categoría/descripción/nombre.
- **Mostrar historial `show history`**: Muestra el historial de cambios realizados en el inventario.
- **Organizar por nombre `sort by name`**: Organizar en orden alfabético por los nombres de los ítems del inventario.
- **Mostrar ayuda `help`**: Muestra los comandos disponibles.

### Comandos

- `add <nombre> = <cantidad> description <descripción> category <categoría>;`
  - Ejemplo: `add apples = 10 description fruit category food;`
- `remove <nombre>;`
  - Ejemplo: `remove apples;`
- `update <nombre> = <cantidad>;`
  - Ejemplo: `update apples = 15;`
- `update <nombre> description <nueva descripción>;`
  - Ejemplo: `update laptops description electronics;`
- `update <nombre> category <nueva categoría>;`
  - Ejemplo: `update apples description food;`
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
- `search category <categoría>;`
  - Ejemplo: `search category tech;`
- `show history;`
  - Muestra el historial de cambios realizados en el inventario.
- `sort by name;`
  - Ordena el inventario por nombre.
- `help;`
  - Muestra una lista de todos los comandos disponibles.

### Ejemplo de archivo `data.txt`

`txt
help;
add ham = 20 description meat category food;
add apples = 10 description fruit category tech;
add laptop = 5 description fruit category tech;
add milk = 20 description dairy category food;
show;
update apples = 15;
update laptop description electronics;
update apples category food;
search category tech;
search category food;
search description fruit;
save inventory.txt;
load inventory.txt;
show history;
sort by name;
show;
`

## Estructura del Código

# Estructuras de Datos
**Item**: Representa un ítem en el inventario.
**Change**: Representa un cambio realizado en el inventario.

### Funciones Principales

**addItem**: Añade un ítem al inventario.
**removeItem**: Elimina un ítem del inventario.
**updateItemQuantity**: Actualiza la cantidad de un ítem en el inventario.
**updateItemDescription**: Actualiza la descripción de un ítem en el inventario.
**updateItemCategory**: Actualiza la categoría de un ítem en el inventario.
**showInventory**: Muestra todos los ítems en el inventario.
**saveInventory**: Guarda el inventario en un archivo.
**loadInventory**: Carga el inventario desde un archivo.
**searchByCategory**: Busca ítems por categoría.
**searchByDescription**: Busca ítems por descripción.
**showHistory**: Muestra el historial de cambios.
**sortInventoryByName**: Ordena el inventario por nombre.
**showHelp**: Muestra una lista de todos los comandos disponibles.
**searchByName**: Busca ítems por nombre.

### Ejecución

make clean
make
./inventory < data.txt








