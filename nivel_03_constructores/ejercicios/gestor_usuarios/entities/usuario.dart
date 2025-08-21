enum ROL { admin, invitado }

class Usuario {
  String _nombre;
  ROL _rol;
  static Usuario? _instance;

  Usuario._(this._nombre, this._rol);

  // Constructor generativo, crea una nueva instancia de la clase cada vez.
  Usuario.generador({required String nombre, required ROL rol})
    : _nombre = nombre,
      _rol = rol;

  factory Usuario({required String nombre, required ROL rol}) {
    if (rol == ROL.admin) {
      return _instance ??= Usuario._(nombre, rol);
    }
    if (rol == ROL.invitado) {
      return Usuario.generador(nombre: nombre, rol: rol);
    } else {
      throw Exception("Rol no soportado");
    }
  }

  String get nombre => _nombre;

  ROL get rol => _rol;

  void saludar() {
    if (_rol == ROL.admin) {
      print("Hola soy un administrador");
    }
    if (_rol == ROL.invitado) {
      print("Hola soy un invitado");
    }
  }
}
