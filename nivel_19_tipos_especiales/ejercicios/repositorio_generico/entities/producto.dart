import 'entidad.dart';

class Producto extends Entidad {
  String nombre;
  double precio;

  Producto({required this.nombre, required this.precio, required super.id});

  @override
  String toString() {
    return "Producto: $nombre\nPrecio: $precio";
  }
}
