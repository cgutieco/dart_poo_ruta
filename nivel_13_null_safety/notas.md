# Capítulo 13. Null Safety en Programación Orientada a Objetos

La gestión de valores nulos ha sido históricamente una de las principales fuentes de errores en los lenguajes de
programación. En particular, la famosa excepción *Null Pointer Exception* (NPE) ha afectado durante décadas a lenguajes
como Java o C#.  
Dart, desde su versión 2.12, adoptó un sistema de **null safety** que en la actualidad (Dart 3.9, agosto de 2025)
constituye un pilar fundamental de su modelo de tipos.

El objetivo de la **null safety** es permitir que los programas sean más seguros y predecibles, minimizando los errores
en tiempo de ejecución asociados con referencias nulas, y trasladando la detección de problemas al **tiempo de
compilación**.

---

## 13.1 Tipos Anulables (`String?`)

En Dart, por defecto, todas las variables **no son anulables**.  
Esto significa que un campo declarado como `String nombre;` debe contener siempre un valor válido del tipo `String`.

Para permitir la ausencia de valor, el tipo debe declararse explícitamente como anulable añadiendo un **signo de
interrogación (`?`)**:

- `String?` → Puede contener un valor de tipo `String` o `null`.
- `int?` → Puede contener un valor de tipo `int` o `null`.

De este modo, el compilador obliga al desarrollador a reconocer los posibles casos en los que `null` puede aparecer,
evitando omisiones peligrosas.

**Ejemplo conceptual:**

```dart
String? nombre; // Puede ser null
String apellido; // Debe ser inicializado antes de usarse
```

---

13.2 Operadores de Null Safety

Dart provee una serie de operadores que permiten trabajar de forma segura con valores anulables, ofreciendo expresiones
más claras y evitando verificaciones redundantes.

a) Operador de acceso condicional (?.)

Permite invocar métodos o acceder a propiedades únicamente si la referencia no es nula.
Si es nula, devuelve null sin lanzar excepción.

```dart
persona?.saludar
();
```

b) Operador de coalescencia (??)

Devuelve un valor alternativo si la expresión es null.

```dart

String nombre = entrada ?? "Desconocido";
```

c) Asignación por coalescencia (??=)

Asigna un valor únicamente si la variable es actualmente null.

```dart
nombre ??= "
Invitado
";
```

d) Operador de aserción (!)

Indica al compilador que una variable anulable no es nula en ese contexto.
Se debe usar con precaución, ya que si la variable resulta ser null en tiempo de ejecución, se lanzará una excepción.

```dart

String? posible = obtenerDato();
String seguro = posible!; // El programador garantiza que no es null
```

---

## 13.3 Inicialización tardía (`late`)

En ocasiones es necesario declarar una variable no anulable que aún no puede inicializarse en el momento de su
declaración, pero que con certeza será asignada antes de usarse.

Para ello, Dart ofrece la palabra clave `late`, que pospone la inicialización de la variable sin necesidad de marcarla
como anulable.

```dart
late String configuracion;
```

Las variables marcadas con `late` deben recibir un valor antes de su primer acceso. Si no ocurre así, en tiempo de
ejecución se lanzará un error.

---

### Usos principales de `late`

1. **Inicialización diferida**: cuando el valor depende de un cálculo o de datos no disponibles en el momento de la
   declaración.
2. **Optimización**: permite diferir la creación de objetos costosos hasta que realmente se necesiten.

---

## 13.4 Null Safety y POO

Dentro del paradigma de la programación orientada a objetos, la null safety tiene implicaciones importantes:

1. **Atributos de clases**: deben ser inicializados en el constructor, declarados como anulables, o marcados como
   `late`.  
   Esto garantiza que toda instancia de la clase se cree en un estado válido.
2. **Métodos y parámetros**: la firma de los métodos deja explícito qué valores pueden ser nulos, lo que incrementa la
   autodocumentación del código.

   **Ejemplo:**
    ```dart
    void procesar(String? entrada);
    ```
3. **Sobreescritura y polimorfismo**: una subclase no puede relajar las restricciones de null safety de la superclase (
   por ejemplo, no puede permitir nulos donde la superclase exige no nulos). Esto preserva la solidez del sistema de
   tipos.

---

## 13.5 Tabla Resumen

| Operador / Palabra clave | Función principal            | Ejemplo               |
|--------------------------|------------------------------|-----------------------|
| `?`                      | Marca un tipo como anulable  | `int? edad;`          |
| `?.`                     | Acceso condicional seguro    | `obj?.método()`       |
| `??`                     | Valor alternativo si es null | `x ?? 0`              |
| `??=`                    | Asignar solo si es null      | `y ??= 5`             |
| `!`                      | Aserción de no nulidad       | `z!`                  |
| `late`                   | Inicialización diferida      | `late String config;` |

---

## Conclusión

La null safety en Dart constituye una de las características más importantes del lenguaje moderno.  
Gracias a su tipado estricto, los errores asociados a referencias nulas se detectan durante la compilación, lo que eleva
significativamente la fiabilidad del código.

El uso de tipos anulables, junto con los operadores `?.`, `??`, `??=`, `!` y la inicialización tardía con `late`,
proporcionan al programador herramientas precisas y expresivas para manejar escenarios donde la ausencia de valor es
legítima, sin comprometer la robustez del sistema.