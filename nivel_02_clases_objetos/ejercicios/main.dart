import 'entities/libro.dart';

void main() {
  Libro libro1 = Libro(
    "Julio Idalgo",
    "Benito Perez",
    DateTime(2000, 2, 14),
    500,
  );

  libro1.imprimirInformacion();

  libro1.aumentarNroPaginas(2500);

  libro1.imprimirInformacion();
}
