class Producto {
  final String nombre;
  final double precio;
  final String? codigoDescuento;

  const Producto({
    required this.nombre,
    required this.precio,
    this.codigoDescuento,
  });

  Producto copyWith({
    String? nuevoNombre,
    double? nuevoPrecio,
    String? nuevoCodigoDescuento,
  }) {
    return Producto(
      nombre: nuevoNombre ?? nombre,
      precio: nuevoPrecio ?? precio,
      codigoDescuento: nuevoCodigoDescuento ?? codigoDescuento,
    );
  }

  @override
  String toString() {
    final textoCodigo = codigoDescuento != null ? "Código descuento $codigoDescuento\n" : "";
    return "Nombre: $nombre\nPrecio: $precio\n$textoCodigo";
  }
}
