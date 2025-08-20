import 'notificacion.dart';

class NotificacionSms implements Notificacion{
  static final NotificacionSms _instance = NotificacionSms._();
  // Constructor privado
  NotificacionSms._();

  factory NotificacionSms() {
    return _instance;
  }

  @override
  void enviar(String mensaje) {
    print("Enviando SMS: ${mensaje}");
  }

}