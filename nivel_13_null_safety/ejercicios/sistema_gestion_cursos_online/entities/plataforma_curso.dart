import 'dart:math';

import 'curso.dart';
import 'estudiante.dart';

class PlataformaCurso {
  List<Curso> cursos;
  List<Estudiante> estudiantes;
  late String nombrePlataforma;

  PlataformaCurso() : cursos = [], estudiantes = [];

  void mostrarBienvenida() {
    print("Bienvenido a la plataforma: $nombrePlataforma");
  }

  void inicializar(String nombrePlataforma) {
    this.nombrePlataforma = nombrePlataforma;
  }

  void agregarCurso(Curso curso) {
    cursos.add(curso);
  }

  void agregarEstudiante(Estudiante estudiante) {
    estudiantes.add(estudiante);
  }

  void inscribirEstudianteEnCurso(String emailEstudiante, String nombreCurso) {
    Estudiante? estudianteInscribir;
    Curso? cursoInscribir;

    for (Estudiante estudiante in estudiantes) {
      if (estudiante.email == emailEstudiante) estudianteInscribir = estudiante;
    }

    for (Curso curso in cursos) {
      if (curso.nombre == nombreCurso) cursoInscribir = curso;
    }

    if (estudianteInscribir == null || cursoInscribir == null) {
      throw Exception("No existe el curso o el estudiante");
    }

    estudianteInscribir.cursoInscrito = cursoInscribir;

    print(
      "El estudiante ${estudianteInscribir.nombre} ha sido inscrito en el curso ${cursoInscribir.nombre}",
    );
  }
}
