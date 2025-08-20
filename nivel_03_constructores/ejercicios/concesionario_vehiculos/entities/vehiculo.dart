// Clase inmutable. Todos sus atributos serán final
class Vehiculo {
  // Principio de ocultación de información
  final String _marca;

  // final: su valor es inmutable y se asigna en tiempo de ejecución
  final String _modelo;

  // constructor const: crea objetos inmutables en tiempo de compilación
  // Todos sus atributos deben ser final o const
  const Vehiculo({required String marca, required String modelo})

    // ":" Es el inicializador de campos, asigna el valor del parámetro al atributo
    : this._marca = marca,
      this._modelo = modelo;

  // Interfaz de la clase
  String get modelo => _modelo;

  String get marca => _marca;
}
