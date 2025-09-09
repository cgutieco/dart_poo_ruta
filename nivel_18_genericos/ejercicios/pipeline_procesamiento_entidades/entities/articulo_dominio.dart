import 'modelo.dart';

class ArticuloDominio extends Modelo {
  String titulo;
  String subtitulo;
  String emailDeAutor;

  ArticuloDominio({
    required this.titulo,
    required this.subtitulo,
    required this.emailDeAutor,
    required super.id,
  });
}
