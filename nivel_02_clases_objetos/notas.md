# Capítulo 2. Clases y Objetos en Dart

En Dart, las **clases** y los **objetos** constituyen los pilares de la programación orientada a objetos. Una clase es
una descripción abstracta de un conjunto de entidades con características comunes, mientras que un objeto es una
instancia concreta de dicha clase.

Este capítulo explora en profundidad cómo se definen y utilizan las clases en Dart, los elementos que las componen y las
palabras clave asociadas que permiten construir estructuras expresivas, coherentes y seguras.

---

## 2.1 Definición de clases

Una **clase** en Dart es una unidad de definición que encapsula tanto datos como comportamiento. En su forma más simple,
se declara mediante la palabra clave `class`, seguida de un identificador que representa su nombre.

La elección del nombre de la clase sigue las convenciones propias del lenguaje: se recomienda el uso de notación
*PascalCase* (cada palabra inicia con mayúscula y se escriben sin guiones ni guiones bajos). Por ejemplo, `Persona`,
`CuentaBancaria`, `VehiculoElectrico`.

Ejemplos de definición de clases:

```dart
    class Persona {}

class CuentaBancaria {}

class VehiculoElectrico {}
```

La definición de una clase puede contener:

- **Campos o atributos**, que representan el estado interno del objeto.
- **Métodos**, que representan las operaciones o comportamientos que dicho objeto puede realizar.
- Constructores, getters, setters, y eventualmente otras estructuras avanzadas que se estudiarán en capítulos
  posteriores.

La clase, por tanto, es un molde conceptual: no contiene datos reales hasta que se crea un objeto a partir de ella.

---

## 2.2 Atributos y métodos

Los **atributos** (también llamados campos o propiedades) son variables que residen dentro de una clase. Su función es
describir el **estado** del objeto, es decir, los datos que diferencian a un objeto de otro aunque ambos pertenezcan a
la misma clase.

Características principales de los atributos:

- Cada objeto creado a partir de una clase posee su propia copia de los atributos.
- Pueden declararse con modificadores como `final` o `const` para indicar inmutabilidad o valores constantes.
- Pueden tener valores por defecto o inicializarse en el momento de la instanciación.

Los **métodos** son funciones definidas dentro de la clase que operan sobre los atributos o que expresan comportamientos
del objeto.

- Los métodos permiten que los objetos no sean solo contenedores de datos, sino unidades con lógica propia.
- Pueden acceder a los atributos y modificarlos.
- Representan acciones, operaciones o transformaciones relacionadas con el dominio del objeto.

Ejemplos de definición de atributos y métodos:

```dart
    class Persona {
  // Atributos
  String nombre;
  int edad;
  String direccion;
  String telefono;
  String email;

  // Métodos
  void imprimirNombre() {
    print('Nombre: $nombre');
  }

  void cumplirAnos() {
    edad += 1;
  }
}
```

En el diseño de una clase bien estructurada, atributos y métodos deben estar en estrecha correspondencia: los primeros
definen el *qué es* un objeto, y los segundos, *qué puede hacer*.

---

## 2.3 Getters y setters

Dart proporciona mecanismos para controlar el acceso a los atributos mediante **getters** y **setters**.

- Un **getter** es una función especial que permite obtener el valor de un atributo de manera controlada. Aunque
  sintácticamente se utiliza como si fuese una propiedad, internamente se trata de un método.
- Un **setter** es una función que permite asignar un valor a un atributo. Al igual que el getter, se invoca con la
  sintaxis habitual de asignación, pero puede contener lógica adicional.

El propósito de los getters y setters no es simplemente redundar en el acceso a atributos, sino permitir:

- Validar los valores antes de asignarlos.
- Encapsular reglas de negocio.
- Ofrecer propiedades calculadas, cuyo valor no corresponde directamente a un atributo almacenado, sino al resultado de
  un cálculo.

Ejemplo de uso de getters y setters:

```dart
    class Persona {
  String nombre;
  int edad;

  // Getter
  String get nombreCompleto => '$nombre $apellido';

  // Setter
  set nombreCompleto(String nombreCompleto) {
    var partes = nombreCompleto.split(' ');
    nombre = partes[0];
    apellido = partes.length > 1 ? partes[1] : '';
  }
}
```

Este mecanismo favorece la **encapsulación**, principio fundamental de la POO, pues evita que los atributos queden
expuestos de forma indiscriminada y permite controlar el modo en que se consultan o modifican.

---

## 2.4 Inicializadores de campos

En Dart, los atributos de una clase pueden inicializarse de diversas formas:

1. Mediante un valor por defecto en la declaración del campo.
   **Ejemplo:**
    ```dart
        class Persona {
          String nombre = 'Desconocido';
          int edad = 0;
        }
    ```
2. A través de los parámetros de un constructor (tema tratado en detalle en capítulos posteriores).
   **Ejemplo:**
    ```dart
        class Persona {
          String nombre;
          int edad;

          Persona(this.nombre, this.edad);
        }
    ```
3. Con inicializadores, que permiten asignar un valor antes de que el cuerpo del constructor se ejecute.
   **Ejemplo:**
    ```dart
        class Persona {
          String nombre;
          int edad;
          
          Persona(this.nombre, this.edad) : 
            nombre = nombre.isEmpty ? 'Desconocido' : nombre,
            edad = edad < 0 ? 0 : edad;
        }
   ```

Los inicializadores cumplen un papel importante en la consistencia del objeto. Garantizan que todos los atributos posean
un valor válido en el momento de la creación del objeto, evitando el estado inconsistente.

La regla general es que Dart obliga a inicializar todos los campos que no sean anulables. De esta manera, el sistema de
null safety y los inicializadores se complementan para asegurar que los objetos nacen siempre en un estado válido y
completo.

---

## 2.5 Métodos estáticos

Además de los métodos de instancia, que operan sobre objetos concretos, Dart permite definir **métodos estáticos**
mediante la palabra clave `static`.

Características principales de los métodos estáticos:

- Están asociados a la clase en sí misma, no a sus instancias.
- Se invocan utilizando el nombre de la clase, sin necesidad de crear un objeto.
- No pueden acceder directamente a atributos ni métodos de instancia, puesto que no dependen de un objeto específico.

Los métodos estáticos son útiles en situaciones donde una operación pertenece conceptualmente a la clase, pero no
requiere un contexto de instancia. Ejemplos típicos incluyen utilidades matemáticas, funciones de conversión o fábricas
de objetos.

En conjunto con los métodos estáticos, también existen **atributos estáticos**, que pertenecen a la clase y son
compartidos por todas las instancias. Esto permite modelar información global o común a todos los objetos de una misma
clase.

**Ejemplo:**

```dart
    class Persona {
      // Variable de la clase
      static const int MAX_EDAD = 120;
      String nombre;
      int edad;

      Persona(this.nombre, this.edad) : edad = edad > MAX_EDAD ? MAX_EDAD : edad;
      
      // Métod de la clase
      static String get nombreCompleto => '$nombre $apellido';
  }
```

---

## 2.6 Palabras clave fundamentales: `class`, `this`, `static`, `final`, `const`

Para comprender la definición y uso de clases en Dart, es necesario analizar las palabras clave más importantes en este
contexto.

### `class`

Introduce la definición de una clase. Es el punto de partida para construir cualquier estructura orientada a objetos.

### `this`

Hace referencia al objeto actual. Permite distinguir entre los atributos de la instancia y los parámetros de un método o
constructor que puedan tener el mismo nombre. También es útil para enfatizar que se está operando sobre el objeto en
curso.

### `static`

Asocia un campo o un método directamente a la clase, en lugar de a una instancia particular. Representa miembros que son
compartidos por todas las instancias o que no dependen de ninguna en absoluto.

### `final`

Indica que un atributo o variable solo puede recibir un valor una vez. No se puede reasignar posteriormente, aunque sí
puede ser mutable el contenido en caso de que se trate de un objeto complejo (por ejemplo, una lista). Es útil para
definir propiedades inmutables en cuanto a su referencia.

### `const`

Declara valores constantes en tiempo de compilación. Un atributo `const` es completamente inmutable y su valor debe
conocerse de antemano. La diferencia esencial con `final` radica en el momento de la asignación:

- `final`: se asigna en tiempo de ejecución, una única vez.
- `const`: se asigna en tiempo de compilación y jamás puede modificarse.

---

## Conclusión

Las clases en Dart constituyen el marco fundamental para modelar entidades mediante atributos y métodos. Los getters y
setters permiten controlar el acceso a los datos internos, mientras que los inicializadores aseguran que los objetos se
creen en estados consistentes. Los métodos estáticos y los campos compartidos amplían las posibilidades al permitir
operaciones a nivel de clase.

El conjunto de palabras clave asociadas (`class`, `this`, `static`, `final`, `const`) proporciona al programador un
vocabulario preciso y expresivo para definir tanto el comportamiento como las restricciones de los objetos.

Dominar estas herramientas es esencial antes de adentrarse en los mecanismos más sofisticados de la POO en Dart, pues
constituyen la base sobre la cual se construyen jerarquías de herencia, interfaces y otros elementos avanzados.