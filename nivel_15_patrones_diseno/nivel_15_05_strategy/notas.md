# Capítulo 15.5 — Strategy en Dart

El patrón **Strategy** es un patrón **de comportamiento** cuyo objetivo es **encapsular familias de algoritmos** y
hacerlos **intercambiables** en tiempo de ejecución, sin cambiar el código cliente que los utiliza. En otras palabras,
Strategy desplaza el “*qué algoritmo aplicar*” desde el cliente hacia un **objeto estrategia** con un contrato estable (
una interfaz), promoviendo **bajo acoplamiento**, **sustituibilidad** y **extensibilidad**.

---

## 1. Motivación y propósito (por qué usar Strategy)

La motivación central de Strategy es resolver un problema clásico de diseño:

> El cliente necesita ejecutar un **algoritmo** (o política de cálculo) pero **no debe conocer** los detalles de su
> implementación ni depender de una versión fija del mismo.

Cuando la lógica de decisión se resuelve con condicionales repetidos (`if/else`, `switch`) repartidos por el código,
aparecen síntomas de **alto acoplamiento**, **violación del OCP** (cada nueva variante exige modificar clientes) y *
*duplicación de reglas**. Strategy propone:

- **Encapsular cada algoritmo** en su propia clase (o función, de forma idiomática en Dart).
- **Declarar un contrato común** (interfaz/typdef) que unifique la invocación.
- **Inyectar** la estrategia en el cliente, que solo conoce el **contrato**, no la implementación concreta.

### Casos de uso típicos

- **Políticas de ordenación/búsqueda**: establecer diferentes criterios sin tocar el consumidor.
- **Formatos / serialización**: JSON, XML, binario, conmutables según contexto o configuración.
- **Validaciones**: reglas intercambiables por país/mercado/versión.
- **Compresión / cifrado**: elegir algoritmo según rendimiento o compatibilidad.
- **Precio/impuestos**: reglas fiscales cambiantes por región o fecha.
- ***Retry* y *backoff***: alternativas de reintento (lineal, exponencial, con jitter).
- **Caché**: estrategias *write-through*, *write-back*, *no-cache*, etc.
- **UI/UX** (Flutter): estrategias de *layout*, *theming* o *formatting* dependientes del dispositivo.

### Beneficios académicos

- **SRP**: el cliente no carga con el “cómo”.
- **OCP**: añadir una nueva estrategia no exige tocar el cliente.
- **DIP**: el cliente depende de **abstracciones**, no de implementaciones.
- **Sustituibilidad (LSP)**: cualquier estrategia que respete el contrato es válida.

### Señales de que necesitas Strategy

- Condicionales proliferantes del tipo: `if (tipo == A) {...} else if (tipo == B) {...}`
- La lógica de selección de algoritmo aparece **duplicada** en varios puntos.
- Requisitos de **activar/desactivar** algoritmos **en runtime** (configuración, *feature flags*).

---

## 2. Conceptos clave

| Concepto                  | Descripción                                                                                   |
|---------------------------|-----------------------------------------------------------------------------------------------|
| **Estrategia (Strategy)** | La **abstracción** del algoritmo. En Dart: interfaz, clase abstracta o `typedef` de función.  |
| **Estrategia concreta**   | Implementación específica del algoritmo.                                                      |
| **Contexto**              | La clase que **usa** la estrategia. Delega el trabajo sin conocer detalles.                   |
| **Familia de algoritmos** | Conjunto de estrategias que resuelven el **mismo problema** con variantes intercambiables.    |
| **Política**              | Sinónimo informal en arquitectura: selección de reglas intercambiables (policy-based design). |

---

## 3. Estructura general

- El **Contexto** mantiene una referencia a una **Estrategia** (contrato).
- El **Cliente** configura el Contexto con la estrategia deseada (por inyección, fábrica, configuración).
- El Contexto delega la operación en la Estrategia, que ejecuta el algoritmo concreto.

---

## 4. Implementación idiomática en Dart

Dart permite varias formas de expresar Strategy:

### 4.1 Enfoque clásico orientado a objetos (interfaz)

```dart
// Contrato de estrategia
abstract interface class DiscountStrategy {
  double apply(double amount);
}

// Estrategias concretas
final class NoDiscount implements DiscountStrategy {
  @override
  double apply(double amount) => amount;
}

final class PercentageDiscount implements DiscountStrategy {
  final double percent; // 0.0 .. 1.0
  PercentageDiscount(this.percent);

  @override
  double apply(double amount) => amount * (1 - percent);
}

final class ThresholdDiscount implements DiscountStrategy {
  final double threshold;
  final double fixed;

  ThresholdDiscount({required this.threshold, required this.fixed});

  @override
  double apply(double amount) => amount >= threshold ? amount - fixed : amount;
}

// Contexto
final class Checkout {
  DiscountStrategy strategy;

  Checkout({required this.strategy});

  double total(double amount) => strategy.apply(amount);
}

void main() {
  final checkout = Checkout(strategy: PercentageDiscount(0.10));
  print(checkout.total(100)); // 90.0
}
```

Notas académicas

- Excelente testabilidad: el Contexto se prueba con mocks/fakes.
- Contratos no anulables por defecto: la firma guía el uso correcto.

---

#### 4.2 Enfoque funcional (first-class functions)

Para algoritmos simples o de alto rendimiento puede ser más directo usar funciones como estrategias. En Dart, las
funciones son objetos de primera clase.

```dart
typedef DiscountFn = double Function(double amount);

double noDiscount(double amount) => amount;

DiscountFn percentage(double p) => (amount) => amount * (1 - p);

final class CheckoutFn {
  DiscountFn strategy;

  CheckoutFn({required this.strategy});

  double total(double amount) => strategy(amount);
}

void main() {
  final checkout = CheckoutFn(strategy: percentage(0.15));
  print(checkout.total(200)); // 170.0
}
```

Ventajas: menos clases, muy ligero.  
Cuidado: si la estrategia tiene estado o requiere invariantes, una interfaz OO ofrece mejor encapsulación.

---

#### 4.3 Strategy genérico y asíncrono

Dart es asíncrono por naturaleza. Muchas estrategias (p. ej., retry, serialización remota, caché) son Future-basadas.

```dart
abstract interface class RetryStrategy {
  Future<T> run<T>(Future<T> Function() task);
}

final class NoRetry implements RetryStrategy {
  @override
  Future<T> run<T>(Future<T> Function() task) => task();
}

final class ExponentialBackoff implements RetryStrategy {
  final int maxAttempts;
  final Duration baseDelay;

  ExponentialBackoff({this.maxAttempts = 3, this.baseDelay = const Duration(milliseconds: 200)});

  @override
  Future<T> run<T>(Future<T> Function() task) async {
    int attempt = 0;
    while (true) {
      try {
        return await task();
      } catch (e) {
        attempt++;
        if (attempt >= maxAttempts) rethrow;
        final delay = baseDelay * (1 << (attempt - 1));
        await Future<void>.delayed(delay);
      }
    }
  }
}
```

Puntos académicos

- Uso de genéricos para no restringir el tipo de resultado.
- Contrato asíncrono explícito: `Future<T>` deja claras las expectativas.

---

#### 5. Selección de estrategias (DI, factorías, configuración)

- **Inyección de dependencias (DI):** el cliente recibe la estrategia adecuada (constructor/setter).
- **Factoría:** una clase/función decide qué estrategia devolver según configuración (entorno, feature flags, A/B
  testing).
- **Cambio en runtime:** el Contexto puede exponer un `setStrategy` o reconstruirse con otra estrategia (patrón
  `copyWith` si el Contexto es inmutable).

```dart
DiscountStrategy chooseDiscount({required bool vip}) => vip ? PercentageDiscount(0.20) : NoDiscount();
```

---

### 6. Buenas prácticas y contratos

1. Define un contrato mínimo y claro: evita “mega interfaces”.
2. Documenta invariantes: unidades, rangos, nulabilidad, idempotencia.
3. Evita estado compartido mutable en estrategias; si necesitas estado, que sea interno y encapsulado.
4. Falla rápido ante parámetros inválidos: lanza ArgumentError explícito.
5. No mezcles Strategy con lógica de selección compleja dentro del Contexto; delega a factorías o a DI.
6. Asíncrono: refleja la naturaleza Future en la firma si hay E/S o esperas.
7. Tipado genérico: usa genéricos si el dominio lo exige; evita dynamic.

---

### 7. Null safety y sustitución

- Contratos de Strategy deben especificar nulabilidad en parámetros y resultados con rigor (`T` vs `T?`).
- El Contexto no debe asumir detalles de la implementación concreta (evita downcasts).
- Si una estrategia no puede producir valor, decláralo (e.g., `T?`, `Result<T,E>`, o lanzar excepción documentada).

---

### 8. Rendimiento y diseño

- Clases vs funciones: funciones pueden ser más ligeras; clases encapsulan mejor políticas con estado y validación.
- Closures: habilitan estrategias parametrizadas sin ruido de clases, pero pueden capturar variables; vigila el ciclo de
  vida.
- Estrategias “const”: si son puras y sin estado, puedes reutilizar instancias (o top-level final) para evitar
  construcciones repetidas.
- Sealed unions: si el conjunto de estrategias es cerrado y pequeño, un sealed class con switch puede ser alternativa (
  ver §10).

---

### 9. Pruebas y sustituibilidad

- Mocks/Fakes: crea estrategias de prueba para simular escenarios (éxito/error) sin tocar el Contexto.
- Property-based testing: útil para validar familias de algoritmos con invariantes (p. ej., orden total, simetrías).
- Medición: si la estrategia afecta rendimiento, mide con benchmarks controlando entradas.

---

### 10. Comparaciones académicas

| Patrón          | Similaridad                              | Diferencia clave                                                                                    |
|-----------------|------------------------------------------|-----------------------------------------------------------------------------------------------------|
| State           | Ambos intercambian comportamiento        | State modela transiciones internas del objeto; Strategy es política externa elegida por el cliente  |
| Template Method | Ambos comparten estructura de algoritmo  | Template fija pasos en una superclase; Strategy encapsula el algoritmo completo y es intercambiable |
| Command         | Ambos encapsulan acciones                | Command encapsula invocaciones (con undo); Strategy encapsula cómo se calcula                       |
| Policy-based    | Sinónimo conceptual                      | En Dart se puede implementar con interfaces o typedefs                                              |
| Sealed + switch | Alternativa cuando el conjunto es finito | Pierdes extensibilidad abierta; ganas exhaustividad en compilación                                  |

---

### 11. Tabla de escenarios y elección de enfoque

| Escenario                                        | Recomendación                                               |
|--------------------------------------------------|-------------------------------------------------------------|
| Muchas variantes, evoluciona con el tiempo       | Strategy OO (interfaces) para extensibilidad y testabilidad |
| Variantes simples, sin estado                    | Funciones (typedef); menos ruido                            |
| E/S o lógica asíncrona                           | Strategy asíncrono (Future, Stream)                         |
| Conjunto finito y estable, exhaustividad deseada | sealed class + switch                                       |
| Necesidad de configurar por archivo/env          | Factoría + DI; deporte la selección fuera del cliente       |

---

### 12. Micro‐ejemplos adicionales

#### 12.1 Strategy con copyWith en un contexto inmutable

```dart
final class PriceEngine {
  final DiscountStrategy strategy;

  const PriceEngine({required this.strategy});

  PriceEngine copyWith({DiscountStrategy? strategy}) =>
      PriceEngine(strategy: strategy ?? this.strategy);

  double total(double amount) => strategy.apply(amount);
}
```

### 12.2 Strategy funcional parametrizable

```dart
typedef
Scoring = int Function(int hits, int misses);

Scoring linearScore({required int hitPts, required int missPenalty}) =>
        (hits, misses) => hits * hitPts - misses * missPenalty;

void main() {
  final score = linearScore(hitPts: 5, missPenalty: 2)(10, 3); // 44
  print(score);
}
```

### 12.3 Selección de estrategia por configuración (factoría simple)

```dart
DiscountStrategy pickStrategy(String code) =>
    switch (code) {
      'NONE' => NoDiscount(),
      'PERC10' => PercentageDiscount(0.10),
      'THRESH_20_5' => ThresholdDiscount(threshold: 20, fixed: 5),
      _ => NoDiscount(),
    };
```

---

## 13. Errores comunes (antipatrones)

- Estrategias que conocen al Contexto: violan encapsulación; usar parámetros o eventos en su lugar.
- Contratos demasiado amplios: cada estrategia implementa solo una parte → olor de diseño; refactoriza en contratos más
  pequeños.
- Selección dispersa: lógica de elección repetida en varios módulos; centraliza en factoría o DI.
- Estado global mutable compartido por estrategias: fuente de errores y pruebas frágiles.

---

### Conclusión

Strategy es un patrón esencial para lograr código extensible y mantenible cuando el cómo (el algoritmo) debe variar sin
impactar al qué (la intención del cliente).
En Dart, puedes implementarlo tanto con interfaces/clases (excelente encapsulación y testabilidad) como con funciones de
primera clase (ligero y expresivo), y combinarlo con factorías e inyección de dependencias para una selección limpia y
controlada.
La clave teórica está en separar políticas de cálculo del uso que se hace de ellas, preservando SRP, OCP y DIP y
permitiendo que las familias de algoritmos evolucionen sin erosión del diseño.