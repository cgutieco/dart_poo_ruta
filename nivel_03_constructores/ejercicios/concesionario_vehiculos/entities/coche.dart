import 'vehiculo.dart';

class Coche extends Vehiculo {
  // Atributos privados para el principio de ocultación de información
  int _numeroDePuertas;
  String? _color;

  final String _codigoInterno;

  // Atributo privado de la clase, además constante, su valor no cambia y es
  // conocido en tiempo de compilación.
  static const String _colorPorDefecto = "Negro";

  // Constructor generativo: inicializa una nueva instancia de la clase
  Coche(
    // En dart primero se pasan los parámetros posicionales al constructor
    // Nro de puertas es parámetro posicional, el resto nombrados
    this._numeroDePuertas, {
    String color = Coche._colorPorDefecto,
    required super.marca,
    required super.modelo,
  }) : _color = color, _codigoInterno = "${marca}-${modelo}-${_numeroDePuertas}";

  // Constructor nombrado
  // En otros lenguajes podría ser sobrecarga de métodos
  // Constructor de redirección: delega la inicialización a un
  // constructor generativo
  Coche.deportivo({required String marca, required String modelo})
    : this(2, color: "Rojo", marca: marca, modelo: modelo);

  // Interfaz de la clase
  // Operador de coalescencia nula, en caso el color sea null devolver tal.
  String get color => _color ?? Coche._colorPorDefecto;

  set color(String value) {
    _color = value;
  }

  int get numeroDePuertas => _numeroDePuertas;

  String get codigoInterno => _codigoInterno;

  set numeroDePuertas(int value) {
    _numeroDePuertas = value;
  }
}
