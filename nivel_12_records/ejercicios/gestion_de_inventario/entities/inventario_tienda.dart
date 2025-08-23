// Record nombrado; typedef define un tipo reutilizable
// Record es un tipo de valor, no de referencia
// Agrupa valores relacionados
typedef Producto = ({String nombre, double precio, int stock});

class InventarioTienda {
  List<Producto> productos = [];

  void agregarProducto(Producto producto) {
    productos.add(producto);
  }

  (Producto?, int?) buscarProducto(String nombreProducto) {
    // indexWhere devuelve -1 si no encuentra el elemento, en lugar de lanzar un error.
    final int indice = productos.indexWhere((p) => p.nombre == nombreProducto);

    // Si se encontró el producto (el índice es diferente de -1)
    if (indice != -1) {
      // Devolvemos el producto y su índice.
      return (productos[indice], indice);
    }

    // Si no se encontró, devolvemos un record con valores nulos.
    return (null, null);
  }

  void actualizarStock(String nombreProducto, int nuevaCantidadStock) {
    // Usamos el métod de búsqueda
    // Acá se está desestructurando
    final (productoEncontrado, indice) = buscarProducto(nombreProducto);

    // Usamos un if-case (pattern matching) para verificar si el producto no es nulo
    // Esto es más seguro y claro que comprobar contra (null, null)
    if (indice != null && productoEncontrado != null) {
      // Creamos el nuevo producto con el stock actualizado
      final productoActualizado = (
        nombre: productoEncontrado.nombre,
        precio: productoEncontrado.precio,
        stock: nuevaCantidadStock,
      );

      // Reemplazamos el producto directamente en su índice para mantener el orden
      productos[indice] = productoActualizado;
    } else {
      print("No se encontró el producto '$nombreProducto' para actualizar.");
    }
  }

  void imprimirInventario() {
    for (Producto producto in productos) {
      // Al ser un record nombrado se sigue esta sintaxis para
      // la desestructuración
      final (:nombre, :precio, :stock) = producto;
      print("-----------------------------------------------");
      print("Datos del producto:");
      print("Nombre: $nombre\nPrecio: \$$precio\nStock: $stock");
      print("-----------------------------------------------");
    }
  }
}
