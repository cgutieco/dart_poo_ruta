import 'entities/vehiculo.dart';
import 'entities/camion.dart';
import 'entities/coche.dart';
import 'entities/coche_electrico.dart';

void main() {
  Coche coche1 = Coche(
    marca: "Toyota",
    modelo: "Yaris",
    anioFabricacion: 2000,
    numeroSerie: "12345",
    kilometraje: 2000,
    precioBase: 45000.90,
    numeroPuertas: 4,
    tipoCombustible: "gasolina",
  );

  Camion camion1 = Camion(
    marca: "Hino",
    modelo: "H200",
    anioFabricacion: 1990,
    numeroSerie: "324gas",
    kilometraje: 450000.89,
    precioBase: 500000.99,
    capacidadCarga: 70000.13,
    numeroEjes: 8,
  );

  CocheElectrico cocheElectrico1 = CocheElectrico(
    marca: "Tesla",
    modelo: "X",
    anioFabricacion: 2020,
    numeroSerie: "fasacf",
    kilometraje: 10000,
    precioBase: 1000000.80,
    numeroPuertas: 4,
    tipoCombustible: "bateria",
    autonomiaBateria: 50000,
  );

  List<Vehiculo> vehiculos = [coche1, camion1, cocheElectrico1];

  for (final vehiculo in vehiculos) {
    print("Información del vehículo:");
    print(vehiculo.decribir());
    print("Precio final: ${vehiculo.calcularPrecioFinal()}");
    print("---------------------------------------\n");
  }

  cocheElectrico1.cargarBateria();
  camion1.realizarInspeccionTacografo();
}
