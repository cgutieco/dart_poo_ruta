class Vehiculo {
  String marca;
  String modelo;
  int anioFabricacion;
  final String _numeroSerie;
  double kilometraje;
  double precioBase;

  static const TARIFA_IMPUESTO = 0.15;

  Vehiculo({
    required this.marca,
    required this.modelo,
    required this.anioFabricacion,
    required String numeroSerie,
    required this.kilometraje,
    required this.precioBase,
  }) : _numeroSerie = numeroSerie {
    if (anioFabricacion > 2023)
      Exception("No se puede asignar un año mayo al actual");
  }

  String get numeroSerie => _numeroSerie;

  set setKilometraje(double nuevoKilometraje) {
    if (nuevoKilometraje > kilometraje) kilometraje = nuevoKilometraje;
  }

  int calcularAntiguedad() {
    return 2025 - anioFabricacion;
  }

  String decribir() {
    return "Marca: ${marca}.\nModelo: ${modelo}.\nAño ${anioFabricacion} - Kilometraje: ${kilometraje}\n";
  }

  double calcularPrecioFinal() {
    return precioBase + (precioBase * TARIFA_IMPUESTO);
  }
}
