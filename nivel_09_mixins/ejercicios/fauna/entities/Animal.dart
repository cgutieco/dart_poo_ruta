enum ModoMovimiento { caminar, nadar, volar }

abstract class Animal {
  String _id;
  int _energia;

  String get id => _id;

  int get energia => _energia;

  int setEnergia(int nuevoValor) {
    if (nuevoValor >= 0 && nuevoValor <= 100)
      return _energia = nuevoValor;
    else
      throw Exception("Rango soportado 0 - 100");
  }

  String mover(ModoMovimiento modo) {
    switch (modo) {
      case ModoMovimiento.caminar:
        if (energia >= 10) _energia -= 10;
        return "Estoy caminando";
      case ModoMovimiento.nadar:
        _energia -= 20;
        return "Estoy nadando";
      case ModoMovimiento.volar:
        _energia -= 30;
        return "Estoy volando";
    }
  }

  void recargarEnergia(int cantidad) {
    _energia += cantidad;
    if (_energia > 100) _energia = 100;
  }

  void emitirSonido();

  @override
  String toString() {
    return "Animal\nId: $_id\nEnergia: $_energia";
  }
}
