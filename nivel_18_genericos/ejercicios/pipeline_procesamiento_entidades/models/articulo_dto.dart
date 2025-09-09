import '../entities/modelo.dart';

class ArticuloDTO extends Modelo {
  String tituloCompleto;
  String autorEmail;

  ArticuloDTO({
    required this.tituloCompleto,
    required this.autorEmail,
    required super.id,
  });
}
