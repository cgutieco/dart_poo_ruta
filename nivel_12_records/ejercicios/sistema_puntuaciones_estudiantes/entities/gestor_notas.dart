typedef Estudiante = ({
  String nombre,
  int edad,
  double nota1,
  double nota2,
  double nota3,
});

class GestorNotas {
  final List<Estudiante> _estudiantes = [];

  void agregarEstudiante(Estudiante nuevoEstudiante) {
    _estudiantes.add(nuevoEstudiante);
  }

  (String nombre, double? promedio) calcularPromedio(String nombreEstudiante) {
    if (_estudiantes.isEmpty) return ("No hay estudiantes", null);

    for (Estudiante estudiante in _estudiantes) {
      if (estudiante.nombre == nombreEstudiante) {
        double promedio =
            (estudiante.nota1 + estudiante.nota2 + estudiante.nota3) / 3;
        return (nombreEstudiante, promedio);
      }
    }

    return (nombreEstudiante, null);
  }

  (Estudiante? estudiante, double? promedio) estudianteConMejorPromedio() {
    if (_estudiantes.isEmpty) return (null, null);

    Estudiante mejorEstudiante = _estudiantes.first;
    double mejorPromedio =
        (mejorEstudiante.nota1 +
            mejorEstudiante.nota2 +
            mejorEstudiante.nota3) /
        3;

    for (Estudiante estudiante in _estudiantes) {
      double promedioActual =
          (estudiante.nota1 + estudiante.nota2 + estudiante.nota3) / 3;
      if (promedioActual > mejorPromedio) {
        mejorPromedio = promedioActual;
        mejorEstudiante = estudiante;
      }
    }

    return (mejorEstudiante, mejorPromedio);
  }
}
