import 'entities/producto.dart';
import 'entities/repositorio.dart';
import 'entities/usuario.dart';

void main() {
  final productos = Repositorio<Producto>();
  final usuarios = Repositorio<Usuario>();

  final usuario1 = Usuario(nombre: "César", email: 'cgutieco@gmail.com', id: 3);
  final usuario2 = Usuario(nombre: "Pollo", email: 'pollo@gmail.com', id: 4);
  final producto1 = Producto(nombre: "Lavanda", precio: 14.5, id: 7);
  final producto2 = Producto(nombre: "Taza", precio: 60.3, id: 32);

  productos.agregarItem(producto1);
  productos.agregarItem(producto2);

  usuarios.agregarItem(usuario1);
  usuarios.agregarItem(usuario2);

  print(usuarios.buscarPorId(3));
  print(usuarios.buscarPorId(4));
  print(usuarios.buscarPorId(9));

  linea();

  print(productos.buscarPorId(7));
  print(productos.buscarPorId(32));

  linea();


  //final repositorioString = Repositorio<String>(); Me dice que el tipo debe
  // ser Entidad o una subclase de Entidad
}

void linea() {
  print("-----------------------------");
}