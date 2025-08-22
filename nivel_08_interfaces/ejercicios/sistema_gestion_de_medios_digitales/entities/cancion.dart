import '../interfaces/calificable.dart';
import 'medio_digital.dart';

class Cancion extends MedioDigital implements Calificable {
  final String album;
  List<int> _calificaciones;

  Cancion({
    required super.titulo,
    required super.artista,
    required super.duration,
    required this.album,
  }) : _calificaciones = [];

  double _calcularCalificacionPromedio() {
    if (_calificaciones.length >= 1) {
      double calificacionAcumulada = _calificaciones
          // Value es el valor acumulado, en la primera iteración es el primer elemento
          // Element es el siguiente valor
          .reduce((value, element) => value + element)
          .toDouble();
      return calificacionAcumulada / _calificaciones.length;
    }
    return 0.0;
  }

  @override
  double get calificacionPromedio => _calcularCalificacionPromedio();

  @override
  void calificar(int estrellas) {
    if (estrellas > 0 && estrellas <= 5) _calificaciones.add(estrellas);
  }

  @override
  void reproducir() {
    print("Reproduciendo la canción $titulo de $artista");
  }
}
