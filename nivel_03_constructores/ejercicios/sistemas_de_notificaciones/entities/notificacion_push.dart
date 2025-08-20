import 'notificacion.dart';

class NotificacionPush implements Notificacion {
  static final NotificacionPush _instance = NotificacionPush._();
  // Constructor privado
  NotificacionPush._();

  factory NotificacionPush() {
    return _instance;
  }

  @override
  void enviar(String mensaje) {
    print("Enviando notificación push: ${mensaje}");
  }
}