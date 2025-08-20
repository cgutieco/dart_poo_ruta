import "libro.dart";

class LibroPrestado extends Libro {
  String _fechaPrestamo;
  String? _nombreUsuario;

  final String _codigoPrestamo;

  static const String _usuarioPorDefecto = "Invitado";

  // Constructor generativo: inicializa los atributos de la instancia
  LibroPrestado(
    this._fechaPrestamo, {
    required super.titulo,
    required super.autor,
    // Parametro opcional y nombrado
    String? nombreUsuario,
  }) : _nombreUsuario = nombreUsuario ?? LibroPrestado._usuarioPorDefecto,
       _codigoPrestamo =
           "${titulo}-${autor}-${_fechaPrestamo}"; // ":" es el iniciador de campo

  // Constructor de redirección, delega la inicialización a un constructor generativo
  // mediante this
  LibroPrestado.rapido({required String titulo, required String autor})
    : this("hoy", titulo: titulo, autor: autor, nombreUsuario: "Express");

  // Interfaz de la clase
  static String get usuarioPorDefecto => _usuarioPorDefecto;

  String? get nombreUsuario => _nombreUsuario;

  set nombreUsuario(String value) {
    _nombreUsuario = value;
  }

  String get fechaPrestamo => _fechaPrestamo;

  set fechaPrestamo(String value) {
    _fechaPrestamo = value;
  }

  String get codigoPrestamo => _codigoPrestamo;

  @override
  String toString() {
    return """Nombre del usuario: ${_nombreUsuario}
Código del libro prestado: ${_codigoPrestamo}\n""";
  }
}
