import 'entities/curso.dart';
import 'entities/estudiante.dart';
import 'entities/plataforma_curso.dart';

void main() {
  Curso curso1 = Curso(
    nombre: "comunicacion",
    descripcion: "Curso de comunicación",
  );

  Estudiante estudiante1 = Estudiante(
    nombre: "César",
    email: "cesar@gmail.com",
  );

  PlataformaCurso plataformaCurso1 = PlataformaCurso();

  plataformaCurso1.agregarEstudiante(estudiante1);
  plataformaCurso1.agregarCurso(curso1);

  plataformaCurso1.inscribirEstudianteEnCurso(
    "cesar@gmail.com",
    "comunicacion",
  );

  print(plataformaCurso1.cursos.first.nombre);
  print(plataformaCurso1.estudiantes.first.nombre);

  plataformaCurso1.inicializar("Platzi");
  plataformaCurso1.mostrarBienvenida();
}
