import 'entities/inventario_tienda.dart';

void main() {
  InventarioTienda inventarioTienda1 = InventarioTienda();

  inventarioTienda1.agregarProducto((
    nombre: "Llanta",
    precio: 20.90,
    stock: 2,
  ));

  inventarioTienda1.agregarProducto((
    nombre: "Perno",
    precio: 1.9,
    stock: 1000,
  ));

  inventarioTienda1.agregarProducto((
    nombre: "Radiador",
    precio: 200.20,
    stock: 5,
  ));

  inventarioTienda1.imprimirInventario();

  var (nombreProducto, indiceProducto) = inventarioTienda1.buscarProducto(
    "Metro",
  );

  print("Producto: ${nombreProducto ?? "Producto no encontrado"}");
  print("Índice del producto: ${indiceProducto ?? "Índice no encontrado"}");

  inventarioTienda1.actualizarStock("Llanta", 19);

  inventarioTienda1.imprimirInventario();
}
