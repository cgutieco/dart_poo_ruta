# Capítulo 15.6 — Observer en Dart

El patrón **Observer** es un patrón **de comportamiento** que establece una relación de **uno a muchos** entre objetos,
de manera que cuando el estado de un objeto (el *sujeto*) cambia, todos los objetos dependientes (los *observadores*)
son notificados y actualizados automáticamente.

Este patrón es fundamental en sistemas reactivos y en arquitecturas basadas en eventos, ya que permite **desacoplar
productores y consumidores de información**. En Dart y Flutter, la idea de Observer subyace en mecanismos como
`Stream`, `ValueNotifier`, `ChangeNotifier` y la propia filosofía reactiva de Flutter.

---

## 1. Motivación y propósito

En el diseño de software, muchas veces necesitamos que **un cambio en un objeto se propague a otros**. Algunos ejemplos:

- Una interfaz de usuario debe actualizarse cuando cambian los datos.
- Un sistema de *logging* debe recibir notificaciones de diversos módulos.
- Un *cache* debe invalidarse cuando la fuente de datos cambia.
- En arquitecturas distribuidas, múltiples clientes deben enterarse de cambios en el servidor.

Sin el patrón Observer, el objeto sujeto tendría que **conocer explícitamente a todos sus dependientes** y
llamarlos manualmente, generando **alto acoplamiento** y reduciendo flexibilidad.  
Observer resuelve esto al introducir un mecanismo de **suscripción y notificación automática**.

### Propósitos fundamentales

- **Desacoplar productor y consumidores:** el sujeto no conoce las implementaciones de los observadores,
  solo su contrato.
- **Promover extensibilidad:** se pueden añadir nuevos observadores sin modificar el sujeto.
- **Facilitar reutilización:** distintos observadores pueden responder de maneras heterogéneas al mismo evento.

---

## 2. Conceptos clave

| Concepto                  | Descripción                                                                                            |
|---------------------------|--------------------------------------------------------------------------------------------------------|
| **Subject (Sujeto)**      | El objeto observado. Mantiene una lista de observadores y ofrece métodos de suscripción/desuscripción. |
| **Observer (Observador)** | Define una interfaz de notificación que el sujeto invoca cuando hay cambios.                           |
| **Concrete Subject**      | Implementación específica del sujeto que mantiene estado.                                              |
| **Concrete Observer**     | Implementación concreta de la reacción al cambio.                                                      |
| **Notificación**          | El mecanismo mediante el cual los observadores son informados (método, callback, evento).              |

---

## 3. Estructura general en Dart

```dart
// Interfaz del Observador
abstract interface class Observer {
  void update(String event);
}

// Sujeto (Subject)
abstract interface class Subject {
  void attach(Observer o);

  void detach(Observer o);

  void notify(String event);
}
```

En este esquema, el **Subject** gestiona la lista de observadores y les envía actualizaciones.  
Los **Observers** implementan `update` para reaccionar a los eventos.

---

## 4. Implementación básica en Dart

```dart
final class ConcreteSubject implements Subject {
  final List<Observer> _observers = [];

  @override
  void attach(Observer o) => _observers.add(o);

  @override
  void detach(Observer o) => _observers.remove(o);

  @override
  void notify(String event) {
    for (var o in _observers) {
      o.update(event);
    }
  }

  void changeState(String event) {
    // Simula un cambio en el estado
    notify(event);
  }
}

final class ConcreteObserver implements Observer {
  final String name;

  ConcreteObserver(this.name);

  @override
  void update(String event) {
    print("$name recibió notificación: $event");
  }
}

void main() {
  final subject = ConcreteSubject();
  final obs1 = ConcreteObserver("A");
  final obs2 = ConcreteObserver("B");

  subject.attach(obs1);
  subject.attach(obs2);

  subject.changeState("Nuevo estado disponible");
}
```

Este ejemplo muestra cómo dos observadores se suscriben a un sujeto y son notificados automáticamente al cambiar el
estado.

---

## 5. Observer en Dart idiomático

En Dart existen construcciones que implementan Observer de forma nativa o simplificada:

- **Streams:** ofrecen un modelo de suscripción basado en asincronía.
- **ValueNotifier / ChangeNotifier (Flutter):** encapsulan el patrón Observer para notificar cambios en UI.
- **Callbacks / closures:** permiten suscripciones ligeras sin necesidad de clases completas.

---

### Ejemplo con `Stream`

```dart
void main() {
  final controller = StreamController<String>();

  // Observadores
  controller.stream.listen((event) => print("Obs1: $event"));
  controller.stream.listen((event) => print("Obs2: $event"));

  // Sujeto emite eventos
  controller.add("Evento 1");
  controller.add("Evento 2");
}
```

Aquí el **StreamController** actúa como sujeto, y cada `listen` crea un observador.  
Este enfoque es ampliamente usado en Flutter para eventos de usuario, sockets, etc.

---

## 6. Comparación con otros patrones

| Patrón                   | Similaridad                     | Diferencia                                                                   |
|--------------------------|---------------------------------|------------------------------------------------------------------------------|
| **Mediator**             | Ambos coordinan comunicación    | Mediator centraliza interacciones; Observer propaga cambios desde un sujeto. |
| **Publisher–Subscriber** | Esencialmente el mismo concepto | Pub–Sub suele usarse en arquitecturas distribuidas y sistemas de mensajería. |
| **Strategy**             | Ambos cambian comportamiento    | Strategy selecciona políticas; Observer reacciona a notificaciones externas. |

---

## 7. Ventajas y desventajas

### Ventajas

- Bajo acoplamiento entre sujeto y observadores.
- Extensible: se pueden añadir observadores en runtime.
- Reutilizable en múltiples dominios (UI, eventos, redes).

### Desventajas

- Complejidad extra: más clases/interfaces.
- Notificaciones en cascada pueden degradar rendimiento.
- Riesgo de fugas de memoria si no se manejan bien las desuscripciones.

---

## 8. Buenas prácticas en Dart

1. **Gestionar suscripciones:** en `Stream`, usar `cancel` para liberar recursos.
2. **Evitar dependencias circulares:** un observador no debería modificar el sujeto en su `update` sin control.
3. **Documentar eventos:** definir claramente qué significa cada notificación.
4. **Usar abstracciones adecuadas:** `ValueNotifier<T>` y `ChangeNotifier` son preferibles en Flutter cuando se trata de
   UI.

---

## Conclusión

El patrón **Observer** es esencial para arquitecturas reactivas y orientadas a eventos.  
En Dart, sus principios se ven reflejados en construcciones modernas como `Stream` y `Notifier`, lo que lo convierte en
un
patrón casi omnipresente en aplicaciones reales (especialmente en Flutter).

Su propósito académico es claro: **mantener coherencia entre objetos sin acoplamiento rígido**, logrando sistemas más
flexibles, extensibles y fáciles de mantener.