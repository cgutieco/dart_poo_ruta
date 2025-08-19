# Capítulo 16. Enums Avanzados

Los **enums** (enumeraciones) son una herramienta clave para modelar dominios con un conjunto finito de variantes.  
En Dart 3.9 los enums ya no son meras listas de constantes: son tipos enriquecidos que pueden contener campos `final`,
constructores `const`, métodos, getters, implementar interfaces y trabajar de forma segura con `switch` exhaustivos y
pattern matching.

En este capítulo profundizamos en: enums simples y enums con valores asociados, métodos y propiedades en enums, y el uso
de `switch` exhaustivo (incluyendo `switch` expresión). Además discutimos criterios de diseño, serialización, testing y
cuándo preferir un `sealed class` en vez de un enum.

---

## 1. Concepto y motivación

Un **enum** define un **dominio cerrado**: la lista de valores posibles está controlada por el autor del tipo. Esto
facilita:

- Razonamiento estático (el compilador sabe todas las alternativas).
- Manejo seguro en `switch` (posible verificación de exhaustividad).
- Modelado claro y expresivo de estados, flags y opciones finitas.

Utiliza enums cuando: las variantes son conceptualmente iguales (mismas propiedades o símbolos) y el conjunto es
relativamente estable y finito.

---

## 2. Enums simples — definición y propiedades básicas

Un enum sin datos asociados es la forma más simple: una lista nombrada de constantes.

```dart
enum Status { pending, approved, rejected }
```

**Propiedades importantes**:

- `Status.values` devuelve la lista de constantes.
- Cada constante tiene `index` (ordinal) y `name` (nombre como `String`).
- Son ideales para estados, etiquetas y opciones discretas.

**Precaución de diseño**: no uses el `index` para persistencia u interoperabilidad —es frágil ante reordenamientos—;
mejor usar `name` o un campo explícito (ver sección de serialización).

---

## 3. Enums con valores asociados (campos y constructores)

Dart permite que cada constante de enum lleve datos asociados mediante campos `final` y un constructor `const`. Esto
convierte cada constante en una instancia con estado inmutable.

```dart
enum Currency {
  usd('USD', '\$'),
  eur('EUR', '€'),
  gbp('GBP', '£');

  final String code;
  final String symbol;

  const Currency(this.code, this.symbol);

  String format(num amount) => '$symbol${amount.toStringAsFixed(2)}';
}
```

**Ventajas**:

- Agrupa datos relacionados con la variante en un único lugar (encapsulación).
- Mantiene inmutabilidad y seguridad de tipos (`final`, `const`).
- Facilita APIs expresivas: `Currency.usd.format(12.5)`.

**Cuando no usarlo**: si las variantes necesitan estructuras de datos radicalmente distintas o comportamientos muy
heterogéneos, considera `sealed classes` en vez de enums.

---

## 4. Métodos, getters y la implementación de interfaces

Un enum puede definir métodos y getters, e incluso implementar interfaces, lo que lo hace participar en arquitecturas
basadas en contratos.

```dart
enum LogLevel {
  debug(10),
  info(20),
  warning(30),
  error(40);

  final int severity;

  const LogLevel(this.severity);

  bool get isSevere => severity >= 30;

  void log(String message) {
    // Ejemplo sencillo de salida por consola
    print('[$name] $message');
  }
}
```

**Notas teóricas**:

- `name` y `index` son parte del contrato del tipo `Enum` en Dart.
- Evita sobrecargar métodos con efectos secundarios dentro del constructor; mantén los constructores `const` y los
  métodos puros cuando sea posible.
- Implementar interfaces (`implements`) permite tratar un enum como una estrategia o policy reutilizable.

---

## 5. Extensions para responsabilidades auxiliares

Para separar responsabilidades (modelo vs presentación), usa *extension methods*:

```dart
enum Color { red, green, blue }

extension ColorHex on Color {
  String toHex() {
    switch (this) {
      case Color.red:
        return '#FF0000';
      case Color.green:
        return '#00FF00';
      case Color.blue:
        return '#0000FF';
    }
  }
}
```

**Buenas prácticas**: usa `extension` para funciones de presentación, mapeos a recursos o helpers que no pertenecen al
contrato esencial del enum.

---

## 6. Uso con `switch` exhaustivo y `switch` expresión

Los enums facilitan la verificación de exhaustividad por parte del compilador. Evitar `_` o `default` permite que el
compilador detecte ramas faltantes si el enum cambia.

**Switch clásico (sentencia):**

```dart
String mensaje(Status s) {
  switch (s) {
    case Status.pending:
      return 'Pendiente';
    case Status.approved:
      return 'Aprobado';
    case Status.rejected:
      return 'Rechazado';
  }
}
```

**Switch expresión (Dart 3)** — estilo declarativo y conciso:

```dart
String mensaje(Status s) =>
    switch (s) {
      Status.pending => 'Pendiente',
      Status.approved => 'Aprobado',
      Status.rejected => 'Rechazado',
    };
```

**Reglas de diseño**:

- Prefiere `switch` expresión cuando el objetivo es mapear valores a resultados puros.
- Evita `default`/`_` si deseas que el compilador garantice que todos los casos están cubiertos.
- Si añades una nueva constante al enum, los `switch` no exhaustivos deberían producir advertencias o errores, obligando
  a actualizar el manejo.

---

## 7. Enums con datos y pattern matching / guardas

Cuando un enum lleva datos asociados, puedes combinar `switch` con desestructuración y guardas para refinar
comportamiento.

```dart
enum Response {
  success(200),
  notFound(404),
  serverError(500);

  final int code;

  const Response(this.code);
}

String interpret(Response r) =>
    switch (r) {
      Response.success(code: var code) when code < 300 => 'OK',
      Response.notFound() => 'No encontrado',
      Response.serverError() => 'Error servidor',
    };
```

**Observaciones**:

- La desestructuración por nombre (`Response.success(code: var code)`) permite extraer campos directamente en la rama.
- Las guardas (`when`) permiten filtrar aún más sin dispersar lógica fuera del `switch`.
- Mantén las guardas simples; si se vuelven complejas, mueve la lógica a métodos auxiliares.

---

## 8. Serialización y persistencia

Decidir cómo serializar enums es crítico para la compatibilidad:

- **Por `name`**: legible y estable mientras no renombres variantes.
- **Por campo `code` (recomendado)**: define explícitamente el valor de persistencia; robusto frente al reordenamiento.
- **Nunca por `index`** salvo en sistemas controlados donde el orden no cambiará.

Ejemplo robusto de serialización por código:

```dart
enum Priority {
  low('L'),
  medium('M'),
  high('H');

  final String code;

  const Priority(this.code);

  static Priority fromCode(String code) =>
      Priority.values.firstWhere((p) => p.code == code);
}
```

**Recomendaciones**:

- Documenta el formato de persistencia (versionado si procede).
- Para JSON o mapeo automático, usa generadores (`json_serializable`, `freezed`) que manejan enums explícitamente.

---

## 9. Enum vs Sealed class — criterio de elección

| Criterio                                                       |          Enum |    Sealed class |
|----------------------------------------------------------------|--------------:|----------------:|
| Dominio finito y simple                                        |             ✅ |               ✅ |
| Variantes con datos homogéneos                                 |             ✅ |               ✅ |
| Variantes con estructuras heterogéneas                         | ⚠️ (limitado) |  ✅ (preferible) |
| Necesidad de subclases con comportamiento polimórfico complejo |             ❌ |               ✅ |
| Simplicidad y concisión                                        |             ✅ | ❌ (más verboso) |

**Regla práctica**: usa enums cuando las variantes comparten naturaleza y, a lo sumo, cargan datos simples; usa
`sealed class` cuando cada variante tiene forma o comportamiento muy distinto.

---

## 10. Buenas prácticas, anti-patrones y testing

**Buenas prácticas**:

- Prefiere `code` o `name` para serialización, no `index`.
- Mantén campos `final` y constructores `const`.
- Usa `extension` para lógica de presentación.
- Evita lógica compleja en constructores de enum.
- Usa `switch` exhaustivo; evita `_` salvo justificación.
- Documenta cada variante con su semántica.

**Anti-patrones**:

- Tratar un enum como contenedor de lógica pesada o estado mutable.
- Usar `index` como clave persistente.
- Forzar enums cuando la jerarquía requiere variantes heterogéneas (mejor `sealed class`).

**Testing**:

- Testea mappers (`fromCode`, `toJson`) para cada variante.
- Añade pruebas que validen `values` (permite detectar cambios indeseados).
- Aprovecha errores de compilación por `switch` no exhaustivos al añadir nuevas variantes.

---

## 11. Rendimiento y consideraciones prácticas

- Las constantes de enum son instancias canónicas y están creadas en tiempo de carga; el coste en tiempo de ejecución es
  despreciable para la mayoría de aplicaciones.
- Evita almacenar datos pesados dentro de enums; en su lugar guarda identificadores o referencias ligeras.
- Los métodos en enums deben preferentemente ser puros y sin efectos colaterales.

---

## 12. Ejemplos compuestos (enum con fields + extension + switch expresión + record)

```dart
enum HttpStatus {
  ok(200, 'OK'),
  notFound(404, 'Not Found'),
  internalServerError(500, 'Internal Server Error');

  final int code;
  final String reason;

  const HttpStatus(this.code, this.reason);
}

({String title, String body}) responseFor(HttpStatus s) =>
    switch (s) {
      HttpStatus.ok => (title: 'Éxito', body: '${s.code} ${s.reason}'),
      HttpStatus.notFound => (title: 'No encontrado', body: '${s.code} ${s.reason}'),
      HttpStatus.internalServerError => (title: 'Error', body: '${s.code} ${s.reason}'),
    };
```

Este ejemplo junta los conceptos: datos asociados, `switch` expresión y `record` como retorno. Es un patrón muy práctico
para transformar enums en vistas o DTOs de salida.

---

## Conclusión

Los **enums avanzados** en Dart 3.9 son una herramienta potente para modelar dominios finitos con seguridad, claridad y
soporte del compilador para verificar exhaustividad. Al combinar campos `final`, constructores `const`, métodos,
`extension` y `switch` expresiones, puedes escribir APIs concisas, robustas y fáciles de mantener.

Recuerda: elige enums cuando las variantes sean homogéneas y relativamente simples; si las variantes difieren mucho en
estructura o comportamiento, opta por `sealed classes`. Aplica buenas prácticas de serialización, evita el uso de
`index` para persistencia y explota la verificación de exhaustividad para reducir bugs en tiempo de ejecución.