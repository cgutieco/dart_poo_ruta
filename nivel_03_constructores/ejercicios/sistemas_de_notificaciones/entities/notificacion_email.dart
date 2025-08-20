import 'notificacion.dart';

class NotificacionEmail implements Notificacion {
  static final NotificacionEmail _instance = NotificacionEmail._();
  //Constructor privado
  NotificacionEmail._();

  factory NotificacionEmail() {
    return _instance;
  }

  @override
  void enviar(String mensaje) {
    print("Enviando email: ${mensaje}");
  }
}