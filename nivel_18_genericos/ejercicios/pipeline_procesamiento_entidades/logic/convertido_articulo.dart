import '../entities/articulo_dominio.dart';
import '../interfaces/convertidor.dart';
import '../models/articulo_dto.dart';

class ConvertidorArticulo implements Convertidor<ArticuloDTO, ArticuloDominio> {
  @override
  ArticuloDominio convertir(ArticuloDTO entrada) {
    final tituloDividido = entrada.tituloCompleto.split("-");
    return ArticuloDominio(
      titulo: tituloDividido.first,
      subtitulo: tituloDividido[1],
      emailDeAutor: entrada.autorEmail,
      id: entrada.id,
    );
  }
}
