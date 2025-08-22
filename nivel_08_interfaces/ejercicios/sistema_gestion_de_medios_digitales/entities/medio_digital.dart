import 'cancion.dart';
import 'podcast.dart';

abstract class MedioDigital {
  final String titulo;
  final String artista;
  final Duration duration;
  final String _idInterno;

  MedioDigital({
    required this.titulo,
    required this.artista,
    required this.duration,
  }) : _idInterno = _generarId();

  factory MedioDigital.crear(Map<String, dynamic> datos) {
    var tipo = datos["tipo"];

    switch (tipo) {
      case "cancion":
        return Cancion(
          titulo: datos["titulo"],
          artista: datos["artista"],
          duration: datos["duration"],
          album: datos["album"],
        );
      case "podcast":
        return Podcast(
          titulo: datos["titulo"],
          artista: datos["artista"],
          duration: datos["duration"],
          nombrePodcast: datos["nombrePodcast"],
          numeroEpisodio: datos["numeroEpisodio"],
        );
      default:
        throw ArgumentError("Tipo no soportado");
    }
  }

  void reproducir();

  String obtenerInfoBasica() {
    return "Titulo: $titulo.\nArtista: $artista.\nDuración: $duration\n";
  }

  String get idInterno => _idInterno;

  static String _generarId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }
}
