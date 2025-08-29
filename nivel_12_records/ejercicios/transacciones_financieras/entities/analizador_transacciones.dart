typedef Transaccion = ({
  int id,
  String descripcion,
  double monto,
  String categoria,
});

class AnalizadorTransacciones {
  List<Transaccion> _transacciones;

  AnalizadorTransacciones(List<Transaccion> transacciones)
    : _transacciones = transacciones;

  double calcularTotalPorCategoria(String nombreCategoria) {
    double sumaTotal = 0;
    for (Transaccion transaccion in _transacciones) {
      if (transaccion.categoria == nombreCategoria)
        sumaTotal += transaccion.monto;
    }
    return sumaTotal;
  }

  (Transaccion? transaccion, double? montoMaximo)
  encontrarTransaccionMasAlta() {
    if (_transacciones.isEmpty) return (null, null);

    Transaccion transaccionMasAlta = _transacciones.first;
    double montoMasAlto = _transacciones.first.monto;

    for (Transaccion transaccion in _transacciones) {
      if (transaccion.monto > montoMasAlto) {
        transaccionMasAlta = transaccion;
        montoMasAlto = transaccion.monto;
      }
    }
    return (transaccionMasAlta, montoMasAlto);
  }

  Map<String, (int cantidad, double total)> resumenDeCategorias() {
    final Map<String, (int cantidad, double total)> resumen = {};

    for (Transaccion transaccion in _transacciones) {
      final categoria = transaccion.categoria;
      final monto = transaccion.monto;
  
      if (resumen.containsKey(categoria)) {
        final (cantidad, total) = resumen[categoria]!;
        resumen[categoria] = (cantidad + 1, total + monto);
      } else {
        resumen[categoria] = (1, monto);
      }
    }

    return resumen;
  }
}
