### Ejercicio: Sistema de Notificaciones con Constructores `factory`

**Objetivo:** Comprender el uso de los constructores `factory` en Dart para devolver instancias de diferentes subtipos
según una condición, desacoplando al cliente de la lógica de creación específica.

**Requisitos:**

1. **Clase Base Abstracta `Notificacion`:**
    * Crea una clase `abstract` llamada `Notificacion`.
    * Debe tener un método abstracto `void enviar(String mensaje)`.
    * Define un constructor `factory` llamado `Notificacion` que acepte un parámetro `String tipo`.

2. **Clases Derivadas:**
    * Crea tres clases que hereden de `Notificacion`:
        * `NotificacionEmail`
        * `NotificacionSMS`
        * `NotificacionPush`
    * Cada una de estas clases debe implementar el método `enviar`, mostrando por consola un mensaje distintivo (ej:
      `"Enviando email: [mensaje]"`).
    * Para evitar que estas clases se puedan instanciar directamente, define para cada una un constructor privado y sin
      nombre (ej: `NotificacionEmail._();`).

3. **Implementación del Constructor `factory`:**
    * Dentro de la clase `Notificacion`, implementa la lógica del constructor `factory`.
    * Dependiendo del valor del parámetro `tipo` (`'email'`, `'sms'`, `'push'`), el constructor debe devolver una
      instancia de la subclase correspondiente (`NotificacionEmail`, `NotificacionSMS`, `NotificacionPush`).
    * Si el `tipo` no es uno de los esperados, debe lanzar una excepción
      `Exception('Tipo de notificación no soportado')`.

**Tarea final:**

En tu función `main`, utiliza el constructor `factory` de `Notificacion` para crear una instancia de cada tipo de
notificación y llama a su método `enviar` para verificar que se está creando el objeto correcto.

* Crea una notificación de tipo `'email'`.
* Crea una notificación de tipo `'sms'`.
* Crea una notificación de tipo `'push'`.

Este ejercicio te permitirá entender cómo un constructor `factory` puede actuar como una "fábrica" que decide qué tipo
de objeto concreto devolver, una de sus aplicaciones más potentes más allá del patrón Singleton.