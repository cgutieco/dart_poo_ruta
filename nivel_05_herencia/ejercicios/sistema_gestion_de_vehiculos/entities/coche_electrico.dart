import 'coche.dart';

class CocheElectrico extends Coche {
  int autonomiaBateria;

  CocheElectrico({
    required super.marca,
    required super.modelo,
    required super.anioFabricacion,
    required super.numeroSerie,
    required super.kilometraje,
    required super.precioBase,
    required super.numeroPuertas,
    required super.tipoCombustible,
    required this.autonomiaBateria,
  });

  @override
  String decribir() {
    return "${super.decribir()}Autonomía: $autonomiaBateria km.";
  }

  void cargarBateria() {
    print("Cargando batería...");
  }
}
