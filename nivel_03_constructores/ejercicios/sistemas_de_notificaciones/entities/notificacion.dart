import 'notificacion_email.dart';
import 'notificacion_push.dart';
import 'notificacion_sms.dart';

abstract class Notificacion {
   // factory no necesariamente devuelve una instancia de la misma clase
  // como un constructor generativo. Puede elegir que devolver.
  factory Notificacion(String tipo){
    switch(tipo) {
      case "email": return NotificacionEmail();
      case "sms": return NotificacionSms();
      case "push": return NotificacionPush();
      default: throw Exception("Tipo de notificación no soportado");
    }
  }

  void enviar(String mensaje);
}