// Clase inmutable, sus atributos son final o const
import 'circulo.dart';
import 'cuadrado.dart';

enum TipoFigura { circulo, cuadrado }

abstract class Figura {
  final String _color;

  const Figura({required String color}) : _color = color;

  factory Figura.crear({
    required TipoFigura tipo,
    required double medida,
    String color = "negro",
  }) {
    if (tipo == TipoFigura.circulo) {
      return Circulo(color: color, radio: medida);
    }
    if (tipo == TipoFigura.cuadrado) {
      return Cuadrado(color: color, lado: medida);
    } else {
      throw Exception("Tipo no válido");
    }
  }

  String get color => _color;

  double calcularArea();
}
