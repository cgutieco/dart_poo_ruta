class Libro {
  // Atributos privados
  // Principio de oculatación de información
  String _titulo;
  String _autor;
  DateTime _anioPublicacion;
  int _nroPaginas;

  // Atributo de la clase
  static const int maximoPaginas = 1000;
  static const int fechaMinima = 1900;

  Libro(this._titulo, this._autor, this._anioPublicacion, this._nroPaginas) {
    if (_anioPublicacion.year < Libro.fechaMinima) {
      throw ArgumentError("El año debe ser mayor a ${Libro.fechaMinima}");
    }
    if (_nroPaginas > Libro.maximoPaginas) {
      throw ArgumentError(
        "El máximo de páginas permitido es ${Libro.maximoPaginas}",
      );
    }
  }

  // Interfaz de la clase
  // Métodos públicos para manipular los atributos
  String get titulo => _titulo;

  String get autor => _autor;

  DateTime get anioPublicacion => _anioPublicacion;

  int get nroPaginas => _nroPaginas;

  void setTitulo(String nombre) {
    _titulo = nombre;
  }

  void setAutor(String autor) {
    _autor = autor;
  }

  void setAnioPublicacion(DateTime anioPublicacion) {
    if (anioPublicacion.year > Libro.fechaMinima) {
      _anioPublicacion = anioPublicacion;
    }
  }

  void setNroPaginas(int nroPaginas) {
    if (nroPaginas <= Libro.maximoPaginas) {
      _nroPaginas = nroPaginas;
    }
  }
}