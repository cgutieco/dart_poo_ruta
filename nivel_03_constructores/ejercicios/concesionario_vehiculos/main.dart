import 'entities/coche.dart';

void main() {
  Coche cocheEstandarCustom = Coche(
    4,
    marca: "Toyota",
    modelo: "Yaris",
    color: "Azul Marino",
  );

  Coche cocheEstandarColorDefault = Coche(6, marca: "Jaguar", modelo: "X9");

  Coche cocheDeportivo = Coche.deportivo(
    marca: "Ferrari",
    modelo: "La Ferrari",
  );

  List<Coche> coches = [
    cocheEstandarCustom,
    cocheEstandarColorDefault,
    cocheDeportivo,
  ];

  for (int i = 0; i <= coches.length - 1; i++) {
    String informacion =
        """Marca: ${coches[i].marca}
Modelo: ${coches[i].modelo}
Número de puertas ${coches[i].numeroDePuertas}
Color: ${coches[i].color}\n""";
    print(informacion);
  }
}
