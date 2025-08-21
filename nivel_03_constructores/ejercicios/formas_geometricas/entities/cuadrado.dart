import 'dart:math';

import 'figura.dart';

class Cuadrado extends Figura {
  final double lado;

  const Cuadrado({required super.color, required this.lado});

  // Se usa un factory para permitir lógica antes de la creación.
  // No puede ser const porque sqrt() es un cálculo de tiempo de ejecución.
  factory Cuadrado.desdeArea({required double area, required String color}) {
    final double ladoCalculado = sqrt(area);
    return Cuadrado(color: color, lado: ladoCalculado);
  }

  @override
  double calcularArea() {
    return pow(lado, 2).toDouble();
  }
}
