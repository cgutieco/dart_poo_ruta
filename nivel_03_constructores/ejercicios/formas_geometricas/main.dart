import 'entities/cuadrado.dart';
import 'entities/figura.dart';

void main() {
  print('--- Tarea Final ---');

  final figura1 = Figura.crear(
    tipo: TipoFigura.circulo,
    medida: 10,
    color: 'rojo',
  );
  print('Área del círculo rojo: ${figura1.calcularArea()}');

  final figura2 = Figura.crear(tipo: TipoFigura.cuadrado, medida: 5);
  print('Área del cuadrado por defecto: ${figura2.calcularArea()}');

  final cuadradoDesdeArea = Cuadrado.desdeArea(area: 100, color: 'verde');
  print(
    'Área del cuadrado desde área 100: ${cuadradoDesdeArea.calcularArea()} (Lado: ${cuadradoDesdeArea.lado})',
  );

  final figuras = [figura1, figura2, cuadradoDesdeArea];
  figuras.forEach((figura) => print(figura.calcularArea().toStringAsFixed(2)));
}
