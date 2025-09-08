import 'pedido.dart';
import 'prioridad.dart';

void main() {
  // Pruebas de Pedido
  print('--- Estados de Pedido ---');
  for (var estado in Pedido.values) {
    print(
      'name: ${estado.name}, index: ${estado.index}, mensaje: ${mensaje(estado)}, mensajeExpresion: ${mensajeExpresion(estado)}',
    );
  }

  // Serialización y deserialización de Pedido
  var estadoSerializado = Pedido.pagado.name;
  var estadoDeserializado = Pedido.values.firstWhere(
    (e) => e.name == estadoSerializado,
  );
  print('Serialización Pedido: $estadoSerializado');
  print('Deserialización Pedido: $estadoDeserializado');

  // Pruebas de Prioridad
  print('\n--- Prioridades ---');
  for (var prioridad in Prioridad.values) {
    print(
      'code: ${prioridad.code}, esSevera: ${prioridad.esSevera}, color: ${prioridad.toColorName()}, emoji: ${prioridad.toEmoji()}',
    );
  }

  // Serialización y deserialización de Prioridad
  var prioridadSerializada = Prioridad.H.code;
  var prioridadDeserializada = Prioridad.fromCode(prioridadSerializada);
  print('Serialización Prioridad: $prioridadSerializada');
  print('Deserialización Prioridad: ${prioridadDeserializada.code}');
}
