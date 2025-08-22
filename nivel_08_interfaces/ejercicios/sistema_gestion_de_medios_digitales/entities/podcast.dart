import 'medio_digital.dart';

class Podcast extends MedioDigital {
  final String nombrePodcast;
  final int numeroEpisodio;

  Podcast({
    required super.titulo,
    required super.artista,
    required super.duration,
    required this.nombrePodcast,
    required this.numeroEpisodio,
  });

  @override
  void reproducir() {
    print(
      "Reproduciendo podcast: $nombrePodcast, episodio $numeroEpisodio: $titulo\n",
    );
  }
}
