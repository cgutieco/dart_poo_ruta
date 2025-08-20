# Capítulo 3. Constructores en Dart

En el paradigma orientado a objetos, los constructores desempeñan un papel esencial: son los responsables de inicializar
un objeto en el momento de su creación. Aunque a primera vista puedan parecer meros procedimientos de asignación, en
realidad constituyen un mecanismo sofisticado que garantiza que cada instancia de una clase comience su existencia en un
estado válido y coherente.

En Dart, los constructores se caracterizan por su flexibilidad. El lenguaje ofrece distintas formas de declararlos y
utilizarlos, lo que permite al programador adaptarse a escenarios variados, desde inicializaciones simples hasta
patrones más avanzados de creación de objetos.

---

## 3.1 Constructor por defecto

Cuando una clase no declara ningún constructor explícitamente, Dart genera de manera implícita un **constructor por
defecto** sin parámetros y de acceso público. Este constructor no realiza ninguna operación adicional, salvo invocar al
constructor de la superclase (si existe) y devolver un objeto válido.

Si el programador declara explícitamente cualquier otro constructor, el constructor por defecto deja de crearse
automáticamente. En ese caso, si se desea disponer de un constructor sin parámetros, debe declararse manualmente.

El constructor por defecto es particularmente útil en clases sencillas o en aquellas que representan entidades que
pueden inicializarse posteriormente mediante asignaciones a sus campos.

---

## 3.2 Parámetros posicionales, nombrados, requeridos y opcionales

Dart ofrece una notable riqueza en cuanto a la definición de parámetros de los constructores, lo que permite diseñar
APIs expresivas y seguras.

### 3.2.1 Parámetros posicionales

Los parámetros posicionales se especifican en un orden determinado. El programador debe proporcionarlos en la misma
secuencia al crear un objeto. Son adecuados cuando el significado de cada parámetro es evidente por su posición o cuando
el número de parámetros es reducido.

**Ejemplo:**

```dart
class Punto {
  int x, y;

  Punto(this.x, this.y);
}

void main() {
  var p = Punto(3, 4);
  print('x: ${p.x}, y: ${p.y}');
}
```

### 3.2.2 Parámetros nombrados

Los parámetros nombrados se indican mediante llaves `{}` y permiten al invocador especificar explícitamente el nombre de
cada argumento. Esto aumenta la legibilidad y reduce los errores por confusión de orden.

Además, los parámetros nombrados son los preferidos en Dart para constructores y funciones que aceptan múltiples
valores, ya que hacen que el código sea más autoexplicativo.

**Ejemplo:**

```dart
class Punto {
  int x, y;

  Punto({this.x = 0, this.y = 0});
}

void main() {
  var p = Punto(y: 5, x: 2);
  print('${p.x}, ${p.y}');
}
```

### 3.2.3 Parámetros requeridos

Para marcar un parámetro nombrado como obligatorio, se utiliza la palabra clave `required`. Esto obliga a quien crea el
objeto a proporcionar dicho valor, garantizando así que no quede sin inicializar.

La verificación se realiza en tiempo de compilación, lo que refuerza la seguridad del sistema de tipos y evita errores
en la ejecución.

**Ejemplo:**

```dart
class Punto {
  int x, y;

  Punto({required this.x, required this.y});
}
```

### 3.2.4 Parámetros opcionales

Dart permite definir parámetros opcionales, ya sea posicionales (entre corchetes `[]`) o nombrados con valores por
defecto. Los parámetros opcionales son útiles cuando existen atributos cuya inicialización no es estrictamente necesaria
o puede asumirse un valor estándar si no se proporciona.

Gracias a estas variantes, el programador puede diseñar constructores que se adapten a distintos casos de uso sin
necesidad de sobrecargar métodos como en otros lenguajes.

**Ejemplo:**

```dart
class Punto {
  int x, y;

  Punto([this.x = 0, this.y = 0]);
}
```

---

## 3.3 Constructores `const`

En Dart, los **constructores `const`** se emplean para crear objetos inmutables en tiempo de compilación.

Características principales:

- Todos los campos de la clase deben ser `final` o `const`.
- Los valores asignados a dichos campos deben conocerse en tiempo de compilación.
- Si dos objetos creados con un constructor `const` contienen los mismos valores, el compilador los trata como la misma
  instancia, aplicando una optimización denominada *canonicalización*.

Esto implica que las instancias `const` no solo son inmutables, sino que además ahorran memoria y mejoran el
rendimiento, ya que se reutiliza la misma referencia cuando se construyen objetos idénticos.

---

## 3.4 Inicializadores

Los **inicializadores de campos** permiten asignar valores a los atributos antes de ejecutar el cuerpo del constructor.
Se utilizan tras los dos puntos (`:`) en la declaración del constructor.

Funciones principales de los inicializadores:

- Permitir que los atributos no anulables reciban un valor válido desde el mismo momento de la creación.
- Ejecutar expresiones que preparen el estado inicial del objeto.
- Invocar a constructores de la superclase o de otras variables finales antes de que el objeto esté completamente
  construido.

**Ejemplo:**

```dart
class Punto {
  int x, y;

  Punto(int valor)
      : x = valor,
        y = valor;
}
```

Gracias a los inicializadores, Dart garantiza que un objeto no pueda existir en un estado inconsistente, ya que sus
campos deben tener valores válidos inmediatamente después de la instanciación.

---

## 3.5 Constructores nombrados y de redirección

Dart no admite la sobrecarga de constructores como otros lenguajes orientados a objetos (por ejemplo, Java o C++). Para
resolver este problema, el lenguaje introduce los **constructores nombrados**.

### Constructores nombrados

Un constructor nombrado se declara añadiendo un identificador adicional tras el nombre de la clase. Esto permite definir
múltiples formas de inicializar un objeto sin necesidad de repetir el constructor por defecto.

Ejemplo conceptual: una clase `Fecha` puede ofrecer constructores nombrados como `Fecha.desdeCadena()` o
`Fecha.desdeTimestamp()`, cada uno de los cuales construye el objeto de manera distinta.

**Ejemplo:**

```dart
class Fecha {
  int dia, mes, anio;

  Fecha(this.dia, this.mes, this.anio);

  Fecha.desdeCadena(String cadena)
      : dia = 1,
        mes = 1,
        anio = int.parse(cadena);
}
```

### Constructores de redirección

Un constructor de redirección no contiene lógica propia, sino que delega la creación en otro constructor de la misma
clase. Esto evita duplicar código y permite centralizar la lógica de inicialización en un único lugar.

**Ejemplo:**

```dart
class Punto {
  int x, y;

  Punto(this.x, this.y);

  Punto.origen() : this(0, 0);
}
```

Se declaran utilizando la sintaxis de redirección con `:` seguido de la llamada al otro constructor.

---

## 3.6 Constructores `factory`

Dart ofrece un tipo especial de constructor denominado **`factory`**, cuyo propósito es proporcionar mayor control sobre
el proceso de instanciación.

Características del constructor `factory`:

- Puede devolver una nueva instancia de la clase, pero también puede decidir devolver una instancia existente.
- Permite implementar patrones como **singleton** (una única instancia para toda la aplicación) o la reutilización de
  objetos ya creados.
- A diferencia de los constructores regulares, no tiene acceso directo a los inicializadores de campos; debe delegar en
  otros constructores o en lógica personalizada.

**Ejemplo:**

```dart
class Logger {
  static Logger? _instancia;

  Logger._privado();

  factory Logger() {
    _instancia ??= Logger._privado();
    return _instancia!;
  }

  void log(String mensaje) {
    print('Log: $mensaje');
  }
}

void main() {
  var logger1 = Logger();
  var logger2 = Logger();
  print(logger1 == logger2); // true
  logger1.log('Mensaje de prueba');
}
```

Los constructores `factory` son particularmente útiles cuando la creación de objetos no sigue una simple asignación de
valores, sino que depende de condiciones externas, cachés, registros o configuraciones.

---

## 3.7 Uso de `super`

La palabra clave `super` en Dart hace referencia a la **superclase inmediata**. En el contexto de los constructores,
`super` se utiliza para invocar al constructor de la clase base y asegurar que esta se inicialice correctamente antes de
que continúe la inicialización de la subclase.

Reglas principales:

- La llamada a `super` debe ser la primera operación de inicialización, antes de ejecutar cualquier lógica en el cuerpo
  del constructor.
- Si la superclase no tiene un constructor por defecto sin parámetros, la subclase debe invocar explícitamente a uno de
  los constructores disponibles de la superclase.
- `super` también puede usarse para inicializar directamente parámetros heredados en los campos de la subclase,
  simplificando así la sintaxis.

**Ejemplo:**

```dart
class Animal {
  String nombre;

  Animal(this.nombre);
}

class Perro extends Animal {
  int edad;

  Perro(String nombre, this.edad) : super(nombre);
}

void main() {
  var miPerro = Perro('Firulais', 3);
  print('Nombre: ${miPerro.nombre}, Edad: ${miPerro.edad}');
}
```

De este modo, `super` asegura la correcta construcción de toda la jerarquía de clases, desde las más generales hasta las
más específicas.

---

## Conclusión

Los constructores en Dart son un mecanismo flexible y potente que permite modelar distintos escenarios de creación de
objetos.

- El **constructor por defecto** proporciona una inicialización básica cuando no se requiere lógica adicional.
- Los **parámetros posicionales, nombrados, requeridos y opcionales** ofrecen un amplio abanico de posibilidades para
  definir interfaces de inicialización claras y expresivas.
- Los **constructores `const`** aportan inmutabilidad y optimización en tiempo de compilación.
- Los **inicializadores** garantizan estados coherentes desde el inicio.
- Los **constructores nombrados y de redirección** permiten múltiples formas de creación sin sobrecarga innecesaria.
- El **constructor `factory`** abre la puerta a patrones avanzados como singletons o reutilización de instancias.
- Finalmente, el uso de **`super`** asegura la correcta construcción de las jerarquías de herencia.

Dominar estas variantes es fundamental para comprender cómo Dart maneja la vida de los objetos, y constituye un paso
imprescindible antes de adentrarse en los conceptos de encapsulación y herencia.