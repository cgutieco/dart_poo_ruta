import 'entities/cancion.dart';
import 'entities/medio_digital.dart';
import 'interfaces/calificable.dart';

void main() {
  List<MedioDigital> mediosDigitales = [];

  Map<String, dynamic> cancion1 = {
    "tipo": "cancion",
    "artista": "Rosa",
    "duration": Duration(days: 1, hours: 3),
    "album": "Los enanitos verdes",
  };

  Map<String, dynamic> podcast1 = {
    "tipo": "cancion",
    "artista": "Rosa",
    "duration": Duration(hours: 3),
    "nombrePodcast": "Hola mundo 2",
    "numeroEpisodio": 2,
  };

  Cancion cancion2 = Cancion(
    titulo: "A ver",
    artista: "José José",
    duration: Duration(hours: 1),
    album: "Enanitos encarcelados",
  );

  cancion2.calificar(4);
  cancion2.calificar(3);
  cancion2.calificar(5);
  cancion2.calificar(2);
  cancion2.calificar(1);

  mediosDigitales = [
    MedioDigital.crear(cancion1),
    MedioDigital.crear(podcast1),
    cancion2,
  ];

  for (final medio in mediosDigitales) {
    print("Información básica:\n ${medio.obtenerInfoBasica()}");
    medio.reproducir();
    if (medio is Calificable) {
      print(
        "Calificación promedio: ${(medio as Calificable).calificacionPromedio}",
      );
    }
    print("--------------------\n");
  }
}
