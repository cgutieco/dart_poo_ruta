import 'entidad.dart';

class Repositorio<T extends Entidad> implements AccionesLista<T> {
  List<T> _lista = [];

  @override
  void agregarItem(T item) {
    _lista.add(item);
  }

  @override
  T? buscarPorId(int id) {
    for (final item in _lista) {
      if (item.id == id) {
        return item;
      }
    }
    return null;
  }
}

abstract interface class AccionesLista<T> {
  void agregarItem(T item);

  T? buscarPorId(int id);
}
