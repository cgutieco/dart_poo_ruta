import 'vehiculo.dart';

class Camion extends Vehiculo {
  double capacidadCarga;
  int numeroEjes;

  Camion({
    required super.marca,
    required super.modelo,
    required super.anioFabricacion,
    required super.numeroSerie,
    required super.kilometraje,
    required super.precioBase,
    required this.capacidadCarga,
    required this.numeroEjes,
  });

  @override
  String decribir() {
    return "${super.decribir()}Capacidad de carga: ${capacidadCarga}\nNúmero de ejes: ${numeroEjes}";
  }

  void realizarInspeccionTacografo() {
    print("La revisión se ha realizado");
  }
}
