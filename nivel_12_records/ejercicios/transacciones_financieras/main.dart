import 'entities/analizador_transacciones.dart';

void main() {
  List<Transaccion> transacciones = [];

  Transaccion comida = (
    id: 123,
    categoria: "comida",
    descripcion: "Esta es una comida",
    monto: 13.40,
  );

  Transaccion transporte = (
    id: 1234,
    categoria: "transporte",
    descripcion: "Esto es un trasnporte",
    monto: 20.92,
  );

  Transaccion ocio = (
    id: 12345,
    categoria: "ocio",
    descripcion: "Esta es un ocio",
    monto: 10.1,
  );

  Transaccion comida1 = (
    id: 123456,
    categoria: "comida",
    descripcion: "Esta es una comida 1",
    monto: 80.2,
  );

  Transaccion transporte1 = (
    id: 1234567,
    categoria: "transporte",
    descripcion: "Esta es un transporte 1",
    monto: 27.9,
  );

  transacciones.add(comida);
  transacciones.add(transporte);
  transacciones.add(transporte1);
  transacciones.add(ocio);
  transacciones.add(comida1);

  AnalizadorTransacciones analizadorTransacciones = AnalizadorTransacciones(transacciones);

  double totalComida = analizadorTransacciones.calcularTotalPorCategoria("comida");

  print(totalComida);

  print(analizadorTransacciones.encontrarTransaccionMasAlta());

  print(analizadorTransacciones.resumenDeCategorias());
}
