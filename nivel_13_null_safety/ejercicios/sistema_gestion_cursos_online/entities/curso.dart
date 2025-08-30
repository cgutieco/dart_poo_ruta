class Curso {
  String nombre;
  String descripcion;
  String? instructor;
  double? calificacionPromedio;

  Curso({
    required this.nombre,
    required this.descripcion,
    String? instructor,
    double? calificacionPromedio,
  }) : instructor = instructor,
       calificacionPromedio = calificacionPromedio;

  String? obtenerInstructor() {
    return instructor ?? "Instructor no asignado";
  }

  void asignarInstructor(String nuevoInstructor) {
    instructor ??= nuevoInstructor;
  }
}
