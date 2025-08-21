import 'vehiculo.dart';

class Coche extends Vehiculo {
  int numeroPuertas;
  String tipoCombustible;

  Coche({
    required super.marca,
    required super.modelo,
    required super.anioFabricacion,
    required super.numeroSerie,
    required super.kilometraje,
    required super.precioBase,
    required this.numeroPuertas,
    required this.tipoCombustible,
  });

  @override
  String decribir() {
    return "${super.decribir()}Nro de puertas: ${numeroPuertas}\nTipo de combustible: ${tipoCombustible}.";
  }

  @override
  double calcularPrecioFinal() {
    return 500.0;
  }
}
