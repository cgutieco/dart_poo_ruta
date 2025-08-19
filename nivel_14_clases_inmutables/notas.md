# Capítulo 14. Clases Inmutables

En el diseño de software, la **inmutabilidad** se refiere a la propiedad de un objeto cuyo estado no puede modificarse
una vez creado.  
La programación orientada a objetos en Dart adopta este concepto como un medio para mejorar la **seguridad, la
legibilidad y la concurrencia** en los programas.

Las clases inmutables son especialmente valiosas cuando se construyen sistemas donde la consistencia de datos es
crítica, como en aplicaciones concurrentes, programación reactiva o interfaces declarativas (por ejemplo, en Flutter).

---

## 14.1 Uso de `final` y `const`

Dart ofrece dos mecanismos principales para favorecer la inmutabilidad: **`final`** y **`const`**.  
Aunque puedan parecer similares, cumplen funciones diferentes:

### `final`

- Declara que un **campo o variable solo puede ser asignado una vez**.
- Su valor se establece en tiempo de ejecución y no puede ser modificado posteriormente.
- Es decir, la referencia es inmutable, aunque el objeto al que apunta podría no serlo (si ese objeto no es inmutable
  por diseño).

Ejemplo conceptual:

```dart

final DateTime ahora = DateTime.now(); // La referencia no puede cambiar
```

- **`const`**
    - Declara que el valor es constante en tiempo de compilación.
    - Puede aplicarse tanto a variables como a constructores y literales.
    - Los objetos creados con const son canónicos: múltiples instancias con los mismos valores se referirán a la misma
      representación en memoria.

Ejemplo conceptual:

```dart

const pi = 3.14159;
```

---

## 14.2 Constructores `const`

Un constructor `const` permite crear instancias inmutables en tiempo de compilación.  
Para ello, todos los campos de la clase deben ser `final`, y el constructor debe declararse con la palabra clave
`const`.

**Ejemplo ilustrativo:**

```dart
class Punto {
  final int x;
  final int y;

  const Punto(this.x, this.y);
}

const p1 = Punto(0, 0);
const p2 = Punto(0, 0);

// p1 y p2 referencian al mismo objeto en memoria
```

El uso de constructores `const` aporta:

1. Eficiencia en memoria: instancias idénticas son compartidas.
2. Seguridad semántica: garantiza que el estado del objeto nunca podrá alterarse.
3. Optimizaciones del compilador: los objetos `const` pueden ser evaluados en tiempo de compilación.

---

## 14.3 Patrones de Inmutabilidad

Más allá del uso de `final` y `const`, la inmutabilidad en Dart implica aplicar ciertos patrones de diseño:

### a) Clases con campos `final`

El patrón más común consiste en declarar todos los atributos de instancia como `final`.
Esto asegura que cada atributo solo pueda recibir un valor en el constructor y no pueda cambiar después.

```dart
class Usuario {
  final String nombre;
  final int edad;

  Usuario(this.nombre, this.edad);
}
```

### b) Uso de constructores `const` cuando es posible

Al declarar un constructor como `const`, se refuerza la inmutabilidad, permitiendo incluso crear instancias en tiempo de
compilación.
Este patrón es especialmente común en Flutter, donde los widgets inmutables optimizan la reconstrucción de la interfaz.

### c) Eliminación de setters

En clases inmutables, no se definen setters.
Esto evita la posibilidad de modificar atributos tras la construcción del objeto.

### d) Copia con modificaciones (“copy with”)

Cuando se requiere un objeto similar con cambios mínimos, se usa el patrón `copy with`: se crea una nueva instancia
copiando los atributos existentes y cambiando solo aquellos que varían.

**Ejemplo:**

```dart
class Usuario {
  final String nombre;
  final int edad;

  const Usuario(this.nombre, this.edad);

  Usuario copyWith({String? nombre, int? edad}) {
    return Usuario(nombre ?? this.nombre, edad ?? this.edad);
  }
}
```

---

## 14.4 Ventajas de la Inmutabilidad

- **Seguridad en concurrencia**: múltiples hilos pueden acceder al mismo objeto sin riesgo de interferencia.
- **Facilidad de razonamiento**: los objetos no cambian, lo que reduce la complejidad mental al seguir el flujo del
  programa.
- **Mayor confiabilidad**: se minimizan errores relacionados con estados inconsistentes.
- **Compatibilidad con el paradigma declarativo**: frameworks como Flutter se benefician enormemente de objetos
  inmutables, ya que facilitan la reconstrucción eficiente de interfaces.

---

## 14.5 Tabla Resumen

| Concepto            | Descripción                                                 | Ejemplo                         |
|---------------------|-------------------------------------------------------------|---------------------------------|
| `final`             | Valor asignado una vez, en tiempo de ejecución              | `final fecha = DateTime.now();` |
| `const`             | Valor constante en tiempo de compilación, canónico          | `const pi = 3.14;`              |
| Constructor `const` | Permite instancias inmutables y compartidas                 | `const Punto(0,0);`             |
| `copyWith`          | Patrón para crear nuevas instancias con variaciones mínimas | `usuario.copyWith(edad: 30)`    |

---

## Conclusión

Las clases inmutables en Dart se construyen principalmente con los modificadores `final` y `const`, junto con la
eliminación de setters y el uso de patrones como `copyWith`.
Lejos de ser una restricción, la inmutabilidad ofrece un marco de programación más predecible, seguro y eficiente, que
encaja de manera natural con la filosofía moderna de Dart y su aplicación en entornos como Flutter.
Al adoptar este enfoque, el desarrollador produce software más robusto y preparado para escenarios de alta concurrencia
y arquitecturas declarativas.
