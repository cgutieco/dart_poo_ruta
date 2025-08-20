// Clase inmutable, todos sus atributos son final o const
class Libro {
  // Métodos privados para el principio de ocultación de información
  // Atributos final: se le asigna un valor inmutable una vez en tiempo de ejecución
  final String _titulo;
  final String _autor;

  // Constructor const: crea una instancia inmutable en tiempo de compilación
  // Los atributos deben ser final o const
  const Libro({required String titulo, required String autor})
    : _titulo = titulo,
      _autor = autor;
}
