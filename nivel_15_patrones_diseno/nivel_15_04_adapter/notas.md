# Capítulo 15.4 — Adapter en Dart

El patrón **Adapter** es un patrón de diseño **estructural** cuyo propósito es **permitir que dos interfaces
incompatibles trabajen juntas**. Su función es actuar como un “traductor” entre una clase existente (con una interfaz
que no podemos cambiar) y un cliente que espera otra interfaz diferente.

El Adapter es uno de los patrones más usados en la práctica, pues ayuda a **reutilizar código** ya escrito sin necesidad
de modificarlo, adaptándolo a nuevos contextos.

---

## 1. Motivación

En programación orientada a objetos, frecuentemente ocurre que:

- Queremos usar una clase existente, pero su interfaz no coincide con lo que nuestro sistema espera.
- No tenemos control sobre el código de esa clase (por ejemplo, pertenece a una librería externa).
- Necesitamos integrar dos sistemas o módulos que no fueron diseñados para comunicarse entre sí.

En lugar de modificar la clase original (lo cual rompería el principio de **cerrado para modificación** del OCP), se
construye una **capa intermedia**: el **Adapter**.

---

## 2. Conceptos clave

- **Target (objetivo):** La interfaz que el cliente espera.
- **Adaptee (adaptado):** La clase existente con una interfaz incompatible.
- **Adapter:** Clase intermediaria que traduce llamadas del Target al Adaptee.
- **Client (cliente):** El código que usa la interfaz esperada (Target).

---

## 3. Adapter en POO

El Adapter se fundamenta en la idea de **encapsulación**: en vez de heredar directamente de una clase incompatible,
encapsulamos su uso dentro de un envoltorio que expone una interfaz coherente.

- Puede implementarse por **herencia** (Adapter clásico).
- O mediante **composición** (más flexible, recomendado en Dart).

Este patrón preserva el **Principio de Inversión de Dependencias**, ya que el cliente depende de una abstracción (
Target) y no de una implementación concreta.

---

## 4. Ejemplo conceptual en Dart

### Supongamos:

- Un cliente espera un método `fetchData()`.
- Pero tenemos una librería externa cuya clase expone un método `getInfo()`.

### Código:

```dart
// Target: la interfaz esperada por el cliente
abstract class DataSource {
  String fetchData();
}

// Adaptee: clase existente con una interfaz incompatible
class LegacyAPI {
  String getInfo() => "Datos desde LegacyAPI";
}

// Adapter: traduce entre DataSource y LegacyAPI
class LegacyAPIAdapter implements DataSource {
  final LegacyAPI _legacy;

  LegacyAPIAdapter(this._legacy);

  @override
  String fetchData() {
    return _legacy.getInfo();
  }
}

// Client
void main() {
  DataSource source = LegacyAPIAdapter(LegacyAPI());
  print(source.fetchData()); // "Datos desde LegacyAPI"
}
```

---

#### 5. Comparación con otros patrones

| Patrón    | Enfoque                                                    | Diferencia con Adapter                                   |
|-----------|------------------------------------------------------------|----------------------------------------------------------|
| Decorator | Añadir responsabilidades dinámicamente a un objeto         | Adapter no añade comportamiento, solo traduce interfaces |
| Proxy     | Controlar acceso a un objeto (remoto, costoso, seguro)     | Adapter se centra en compatibilidad, no en control       |
| Facade    | Ofrecer una interfaz simplificada a un subsistema complejo | Adapter trabaja entre una clase individual y el cliente  |
| Bridge    | Separar una abstracción de su implementación               | Adapter conecta dos interfaces incompatibles             |

---

#### 6. Variantes de Adapter

1. **Object Adapter (composición)**
    - El Adapter contiene una instancia del Adaptee.
    - Más flexible, ya que se pueden adaptar múltiples clases distintas.
    - Es la forma recomendada en Dart.

2. **Class Adapter (herencia)**
    - El Adapter hereda del Adaptee y del Target.
    - Requiere herencia múltiple (no disponible en Dart).
    - Por esta razón, en Dart solo se utiliza la composición.

---

#### 7. Ejemplo más elaborado en Dart

Imaginemos que tenemos un sistema que necesita obtener datos en formato JSON, pero una librería externa solo ofrece
datos en XML.

```dart
// Target
abstract class JsonService {
  String getJson();
}

// Adaptee
class XmlService {
  String getXml() => "<data><value>42</value></data>";
}

// Adapter
class XmlToJsonAdapter implements JsonService {
  final XmlService _xmlService;

  XmlToJsonAdapter(this._xmlService);

  @override
  String getJson() {
    // Conversión simple ficticia de XML a JSON
    final xml = _xmlService.getXml();
    return '{"data": {"value": 42}}'; // En un caso real habría parsing
  }
}

// Cliente
void main() {
  JsonService service = XmlToJsonAdapter(XmlService());
  print(service.getJson()); // {"data": {"value": 42}}
}
```

Este ejemplo muestra cómo el cliente trabaja exclusivamente con JSON, mientras que la librería externa se mantiene
intacta.

---

#### 8. Ventajas y desventajas

**Ventajas**

- Permite la reutilización de clases existentes.
- Evita modificar código legado o externo.
- Favorece la adherencia a principios SOLID.
- Facilita la integración de librerías heterogéneas.

**Desventajas**

- Aumenta el número de clases en el diseño.
- Puede añadir cierta complejidad si hay muchos Adapters.
- No resuelve diferencias semánticas profundas, solo de interfaz.

---

### Conclusión

El patrón Adapter en Dart resulta indispensable para integrar clases o librerías incompatibles, actuando como traductor
entre interfaces.
En proyectos reales, es común encontrarlo cuando se combinan módulos desarrollados en distintos momentos o cuando se
adoptan librerías externas.

En definitiva, el Adapter fomenta la reutilización, preserva la encapsulación y mantiene la coherencia del sistema sin
forzar cambios en el código existente.