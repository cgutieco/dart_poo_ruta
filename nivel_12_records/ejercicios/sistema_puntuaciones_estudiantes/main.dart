import 'entities/gestor_notas.dart';

void main() {
  Estudiante estudiante1 = (
    nombre: "César",
    edad: 25,
    nota1: 20,
    nota2: 20,
    nota3: 20,
  );

  Estudiante estudiante2 = (
  nombre: "Juanito",
  edad: 13,
  nota1: 10,
  nota2: 16,
  nota3: 20,
  );

  Estudiante estudiante3 = (
  nombre: "Juan",
  edad: 19,
  nota1: 10,
  nota2: 11,
  nota3: 08,
  );

  Estudiante estudiante4 = (
  nombre: "Ramón",
  edad: 89,
  nota1: 14,
  nota2: 19,
  nota3: 12,
  );

  Estudiante estudiante5 = (
  nombre: "Pedro",
  edad: 16,
  nota1: 20,
  nota2: 10,
  nota3: 10,
  );
  
  
  GestorNotas gestorNotas1 = GestorNotas();
  
  gestorNotas1.agregarEstudiante(estudiante1);
  gestorNotas1.agregarEstudiante(estudiante2);
  gestorNotas1.agregarEstudiante(estudiante3);
  gestorNotas1.agregarEstudiante(estudiante4);
  gestorNotas1.agregarEstudiante(estudiante5);
  
  print(gestorNotas1.calcularPromedio("Juan"));
  
  print(gestorNotas1.estudianteConMejorPromedio());
  
}
