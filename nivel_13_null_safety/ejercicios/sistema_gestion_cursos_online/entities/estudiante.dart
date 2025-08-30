import 'curso.dart';

class Estudiante {
  String nombre;
  String email;
  Curso? cursoInscrito;
  late DateTime ultimoLogin;

  Estudiante({
    required this.nombre,
    required this.email,
    this.cursoInscrito = null,
  });

  void registrarLogin() {
    ultimoLogin = DateTime.now();
  }

  String? obtenerNombreCurso() {
    return cursoInscrito?.nombre ?? "No inscrito";
  }
}
