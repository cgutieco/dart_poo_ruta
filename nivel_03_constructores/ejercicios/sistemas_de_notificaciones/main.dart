import 'entities/notificacion.dart';

void main() {
  Notificacion notificacion1 = Notificacion("sms");
  Notificacion notificacion2 = Notificacion("sms");
  Notificacion notificacion3 = Notificacion("push");
  Notificacion notificacion4 = Notificacion("email");

  notificacion1.enviar("Hola que tal, soy una notificación sms");
  notificacion2.enviar("Hola que tal, soy una notificación sms 2");
  notificacion3.enviar("Hola que tal, soy una notificación push 3");
  notificacion4.enviar("Hola que tal, soy una notificación email 4");

  print(identical(notificacion1, notificacion2));
  print(identical(notificacion4, notificacion2));
}