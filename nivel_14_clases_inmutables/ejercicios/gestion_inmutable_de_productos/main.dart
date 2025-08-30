import 'entities/producto.dart';

void main() {
  const productoOriginal = Producto(nombre: "laptop", precio: 1500.99);

  final productoDescuento = productoOriginal.copyWith(
    nuevoCodigoDescuento: "HOLA",
  );

  final productoRebajado = productoDescuento.copyWith(nuevoPrecio: 1455.90);

  print("Producto original: \n" + productoOriginal.toString());
  print("Producto con descuento: \n" + productoDescuento.toString());
  print("Producto rebajado: \n" + productoRebajado.toString());
}
