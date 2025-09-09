import 'entidad.dart';

class Usuario extends Entidad {
  String nombre;
  String email;

  Usuario({required this.nombre, required this.email, required super.id});

  @override
  String toString() {
    return "Usuario: $nombre\nEmail: $email";
  }
}
