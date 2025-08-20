import 'entities/libro_prestado.dart';

void main() {
  LibroPrestado libroPrestado1 = LibroPrestado(
    "Ayer",
    titulo: "Don Quijote",
    autor: "Miguel Cervantes",
    nombreUsuario: "César",
  );
  LibroPrestado libroPrestado2 = LibroPrestado(
    "Mañana",
    titulo: "Hola mundo",
    autor: "Yo",
  );
  LibroPrestado libroPrestado3 = LibroPrestado.rapido(
    titulo: "Rayo Maquin",
    autor: "Quien sabe",
  );

  List<LibroPrestado> libros = [libroPrestado1, libroPrestado2, libroPrestado3];

  libros.forEach((libro) => print(libro.toString()));
}
