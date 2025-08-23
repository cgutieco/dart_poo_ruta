# Ejercicio: Gestión de Inventario con Records

## Objetivo

Crear un sistema simple para gestionar el inventario de una tienda utilizando **Records** para representar los productos
y una **clase** para manejar la lógica del inventario.

---

### Paso 1: Definir el Tipo de Dato del Producto

1. Usa `typedef` para crear un alias de tipo llamado `Producto`.
2. Este alias debe representar un **record nombrado** con los siguientes campos:
    * `nombre` (de tipo `String`)
    * `precio` (de tipo `double`)
    * `stock` (de tipo `int`)

---

### Paso 2: Crear la Clase de Gestión de Inventario

1. Define una clase llamada `InventarioTienda`.
2. Esta clase debe tener una única propiedad privada: una lista (`List`) que almacenará los registros de tipo
   `Producto`.

---

### Paso 3: Implementar la Lógica del Inventario

Añade los siguientes métodos a la clase `InventarioTienda`:

1. **`agregarProducto`**:
    * **Parámetro**: Un `Producto`.
    * **Acción**: Añade el producto recibido a la lista interna del inventario.

2. **`buscarProducto`**:
    * **Parámetro**: Un `String` con el nombre del producto a buscar.
    * **Retorno**: Un **record posicional** `(Producto?, int?)`.
        * El primer valor (`$1`) será el `Producto` encontrado o `null` si no existe.
        * El segundo valor (`$2`) será el índice del producto en la lista o `null` si no se encuentra.
    * **Acción**: Busca en la lista un producto cuyo nombre coincida con el parámetro.

3. **`actualizarStock`**:
    * **Parámetros**: Un `String` con el nombre del producto y un `int` con la nueva cantidad de stock.
    * **Acción**: Utiliza el método `buscarProducto` para encontrar el producto. Si existe, reemplaza el producto
      antiguo en la lista por uno nuevo con el stock actualizado (recuerda que los records son inmutables).

4. **`imprimirInventario`**:
    * **Parámetros**: Ninguno.
    * **Acción**: Recorre la lista de productos e imprime los detalles de cada uno de forma clara en la consola.

---

### Paso 4: Probar la Implementación

En la función `main`, realiza las siguientes acciones para verificar que tu código funciona correctamente:

1. Crea una instancia de `InventarioTienda`.
2. Crea al menos tres `Producto` diferentes y añádelos al inventario.
3. Imprime el inventario completo.
4. Busca un producto existente usando `buscarProducto`. Desestructura el record retornado para obtener el producto y su
   índice, y luego imprime esta información.
5. Intenta buscar un producto que no exista y maneja el caso de los valores `null` retornados.
6. Actualiza el stock de uno de los productos.
7. Vuelve a imprimir el inventario para confirmar que el stock se ha actualizado.