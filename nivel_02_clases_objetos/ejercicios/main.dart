import 'entities/libro.dart';

void main() {
  Libro libro1 = Libro(
    "Julio Idalgo",
    "Benito Perez",
    DateTime(2000, 2, 14),
    1000,
  );

  print(
    libro1.autor +
        libro1.titulo +
        libro1.anioPublicacion.toString() +
        libro1.nroPaginas.toString(),
  );
}
