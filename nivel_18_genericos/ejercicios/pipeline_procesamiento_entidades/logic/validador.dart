class Validador<T> {
  final List<bool Function(T)> _reglas = [];

  void agregarRegla(bool Function(T) regla) {
    _reglas.add(regla);
  }

  bool esValido(T objeto) {
    for (final regla in _reglas) {
      if (!regla(objeto)) return false;
    }
    return true;
  }
}
