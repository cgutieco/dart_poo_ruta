import 'dart:math';

import 'figura.dart';

class Circulo extends Figura {
  final double _radio;

  // Constructor const, crea instancias inmutables en tiempo de compilación
  const Circulo({required super.color, required double radio}) : _radio = radio;

  @override
  double calcularArea() {
    return pi * pow(_radio, 2);
  }
}
