enum Pedido { creado, pagado, enviado, cancelado, devuelto }

String mensaje(Pedido p) {
  switch (p) {
    case Pedido.creado:
      return "Pedido creado";
    case Pedido.pagado:
      return "Pedido pagado";
    case Pedido.enviado:
      return "Pedido enviado";
    case Pedido.cancelado:
      return "Pedido cancelado";
    case Pedido.devuelto:
      return "Pedido devuelto";
  }
}

String mensajeExpresion(Pedido p) => switch (p) {
  Pedido.creado => "Pedido creado",
  Pedido.pagado => "Pedido pagado",
  Pedido.enviado => "Pedido enviado",
  Pedido.cancelado => "Pedido cancelado",
  Pedido.devuelto => "Pedido devuelto",
};
