# Capítulo 6. Polimorfismo en Dart

El **polimorfismo** es uno de los pilares fundamentales de la Programación Orientada a Objetos.  
La palabra proviene del griego *poly* (“muchos”) y *morphé* (“formas”), y hace referencia a la capacidad de un mismo
elemento —un método, un objeto, una referencia— de adoptar distintas formas según el contexto.

En términos prácticos, el polimorfismo permite que el mismo mensaje (invocar un método, acceder a un atributo) produzca
comportamientos diferentes dependiendo del tipo concreto del objeto sobre el cual se aplica.

Dart implementa el polimorfismo principalmente a través de cuatro mecanismos:

1. La **sobrescritura de métodos**.
2. La noción de **interfaces implícitas**.
3. El uso de **clases abstractas**.
4. La relación de **subtipado**.

A continuación, examinaremos cada uno en detalle.

---

## 6.1 Polimorfismo de sobrescritura

La sobrescritura (o *overriding*) ocurre cuando una subclase redefine un método que ya existía en su superclase.  
Gracias a ello, una misma operación puede variar de comportamiento según la clase concreta del objeto que la recibe.

En Dart, la sobrescritura debe marcarse con la anotación `@override`. Esto no es meramente decorativo: el compilador
valida que realmente exista un método con la misma firma en la superclase, garantizando que el programador no comete
errores de ortografía o de parámetros.

**Ejemplo conceptual:**

- La clase `Figura` declara un método `area()`.
- La clase `Cuadrado` sobrescribe este método para calcular el área como lado × lado.
- La clase `Círculo` sobrescribe el mismo método para calcular π × radio².

El resultado es que, aunque el código trabaje con referencias del tipo general `Figura`, la llamada a `area()` invocará
el cálculo correspondiente al tipo concreto (cuadrado o círculo).

Este comportamiento se conoce como **despacho dinámico de métodos** (*dynamic dispatch*), y constituye la esencia del
polimorfismo en tiempo de ejecución.

**Comparación con Java:**  
Dart y Java coinciden en este punto: ambos resuelven la sobrescritura de métodos en tiempo de ejecución. Sin embargo,
Dart no permite la **sobrecarga de métodos** (*overloading*), es decir, no se pueden definir varios métodos con el mismo
nombre pero distinta lista de parámetros dentro de una misma clase, cosa que en Java sí está permitida. Esto simplifica
el modelo de invocación en Dart.

---

## 6.2 Interfaces implícitas

En muchos lenguajes orientados a objetos, como Java, las **interfaces** son un constructo explícito: deben declararse
con la palabra clave `interface` y ser implementadas por las clases mediante `implements`.

En Dart, sin embargo, todas las clases definen de manera automática una **interfaz implícita**.  
Esto significa que cualquier clase puede actuar como interfaz, y otra clase puede “implementarla” simplemente declarando
`implements NombreClase`.

- **Superficie de la interfaz**: está formada por todos los métodos y atributos públicos de la clase original.
- **Independencia de la implementación**: implementar una interfaz no hereda el código de la clase original, solo obliga
  a la nueva clase a proporcionar implementaciones concretas para los métodos y atributos declarados.

**Ventaja:** no es necesario mantener dos constructos separados (clases e interfaces) como ocurre en Java.  
**Inconveniente:** el programador debe recordar que implementar una clase con `implements` no trae consigo su
comportamiento, solo su contrato.

Este diseño simplifica la semántica del lenguaje, aunque obliga a ser más explícito en la implementación de métodos.

---

## 6.3 Clases abstractas

Las **clases abstractas** son aquellas que no pueden instanciarse directamente y que están destinadas a servir de base
para otras clases.

Se definen con la palabra clave `abstract`.  
Una clase abstracta puede contener:

- Métodos **abstractos**, es decir, declarados pero sin implementación.
- Métodos con implementación completa, que podrán ser reutilizados por las subclases.

El propósito de una clase abstracta es doble:

1. **Establecer contratos parciales:** define qué métodos deben implementar las subclases.
2. **Favorecer la reutilización:** permite incluir código común a todas las subclases.

En la práctica, una clase abstracta se sitúa entre la generalidad de una interfaz y la concreción de una clase
instanciable.

**Ejemplo conceptual:**

- Una clase abstracta `Vehiculo` puede declarar un método abstracto `acelerar()`.
- Sus subclases, como `Automóvil` o `Bicicleta`, estarán obligadas a proporcionar su propia versión de `acelerar()`.
- Pero al mismo tiempo, `Vehiculo` puede ofrecer un método común como `detener()`, que las subclases reutilizan sin
  necesidad de reescribirlo.

**Comparación con Java:**  
La idea es equivalente en ambos lenguajes. No obstante, Dart no admite la existencia de métodos *protected*, lo cual en
Java es habitual en clases abstractas para encapsular cierta lógica accesible solo a las subclases. En Dart, todo es
público o privado por convención de librerías.

---

## 6.4 Subtipado

El **subtipado** es la relación lógica que se establece cuando una clase hereda o implementa otra.

Se dice que una clase B es subtipo de una clase A si:

- B **extiende** a A, o
- B **implementa** a A, o
- B es más específica que A en la jerarquía de tipos.

En consecuencia, una referencia del tipo A puede contener un objeto de tipo B, porque todo objeto B es también un A (
principio de sustitución de Liskov).

El subtipado en Dart funciona de manera coherente con la herencia simple y las interfaces implícitas:

- Una clase que extiende de otra hereda automáticamente su contrato y su comportamiento.
- Una clase que implementa otra hereda únicamente el contrato, pero no el comportamiento.

**Ejemplo conceptual:**  
Si `Perro` extiende de `Animal`, entonces `Perro` es subtipo de `Animal`.  
Si `RobotPerro` implementa `Animal`, entonces `RobotPerro` también es subtipo de `Animal`, aunque no comparta su
implementación.

Este modelo uniforme hace que el polimorfismo pueda operar tanto con clases heredadas como con interfaces implementadas,
sin distinción para el código que invoca los métodos.

---

## Conclusión

El polimorfismo en Dart se articula a través de varios mecanismos complementarios:

- La **sobrescritura de métodos** permite que diferentes clases respondan de manera distinta a la misma operación,
  habilitando el polimorfismo en tiempo de ejecución.
- Las **interfaces implícitas** convierten cualquier clase en un contrato reutilizable, eliminando la necesidad de un
  constructo separado como en Java.
- Las **clases abstractas** combinan la fuerza de los contratos con la posibilidad de compartir implementaciones
  comunes.
- El **subtipado** asegura que cualquier objeto de una clase concreta pueda ser tratado como una instancia de un tipo
  más general, facilitando la sustitución y la extensibilidad.

En conjunto, estos elementos hacen de Dart un lenguaje con un modelo polimórfico flexible y consistente, que mantiene la
simplicidad frente a lenguajes como Java al reducir el número de constructos formales, pero que al mismo tiempo ofrece
el rigor necesario para construir sistemas orientados a objetos robustos.