# Capítulo 1. Fundamentos de la Programación Orientada a Objetos en Dart

La Programación Orientada a Objetos (POO) constituye el núcleo de la mayoría de lenguajes modernos, y Dart no es una
excepción. Comprender sus fundamentos resulta esencial para construir aplicaciones robustas, modulares y mantenibles,
especialmente en el ecosistema de Flutter, donde la POO es el paradigma predominante.

En este capítulo se abordan los conceptos esenciales de la POO en Dart, desde la definición de clases y objetos hasta el
funcionamiento del tipado estático con null safety, introducido como característica central en las versiones más
recientes del lenguaje.

---

## 1.1 Conceptos básicos: clases, objetos, atributos y métodos

Una **clase** puede entenderse como un molde o plantilla que describe un conjunto de entidades con características
comunes. Define la estructura y el comportamiento que tendrán los objetos que se creen a partir de ella.  
En términos más concretos:

- **Atributos**: también denominados *campos* o *propiedades*, representan el estado de un objeto. Son variables que se
  almacenan dentro de la clase y pueden ser de cualquier tipo.
- **Métodos**: son funciones asociadas a la clase que describen el comportamiento de los objetos. A través de ellos se
  implementa la lógica que manipula los atributos o define interacciones.
- **Objetos**: son instancias concretas de una clase. Cada objeto tiene su propio estado, determinado por los valores de
  sus atributos, y comparte el mismo conjunto de métodos definido en la clase.

La relación entre estos elementos se puede resumir en la siguiente idea:
> Una **clase** define un tipo abstracto; un **objeto** es una concreción de ese tipo.

---

## 1.2 Diferencia entre tipos primitivos y objetos

Dart adopta una visión homogénea del mundo de los datos: *todo en Dart es un objeto*. Incluso los valores que en otros
lenguajes se consideran primitivos, como los enteros, los decimales o los valores booleanos, se representan internamente
como instancias de clases predefinidas (`int`, `double`, `bool`, entre otras).

Esto significa que operaciones habituales, como sumar números o aplicar transformaciones a cadenas, se implementan como
métodos de objetos. No obstante, el compilador optimiza el tratamiento de estos tipos básicos para ofrecer un
rendimiento comparable al de los lenguajes que sí distinguen entre primitivos y objetos.

Este diseño confiere a Dart una gran coherencia conceptual: todo valor se manipula bajo un mismo modelo de objetos, lo
cual simplifica el aprendizaje y la aplicación de la POO.

---

## 1.3 Tipado estático y null safety

El **tipado estático** de Dart implica que el compilador verifica, en tiempo de compilación, que las operaciones
realizadas sobre un valor son compatibles con su tipo declarado. Esto reduce significativamente los errores que en otros
lenguajes solo se detectan en ejecución.

Desde la versión 2.12, Dart introdujo el sistema de **null safety**, reforzado y perfeccionado en versiones posteriores
hasta la actual 3.9. El objetivo principal es evitar las excepciones derivadas del uso de referencias nulas (*null
reference exceptions*), conocidas coloquialmente como "la pesadilla del puntero nulo".

Las reglas esenciales del null safety en Dart son:

- Por defecto, **ninguna variable puede contener `null`** a menos que se indique explícitamente.
- Para permitir que una variable acepte `null`, se debe marcar su tipo con un signo de interrogación. Por ejemplo:
  `String?` indica que la variable puede almacenar tanto una cadena como un valor nulo.
- El lenguaje proporciona operadores especiales para tratar con valores potencialmente nulos (`!`, `?.`, `??`, `??=`),
  lo que garantiza un tratamiento seguro y explícito de estas situaciones.

Este enfoque conduce a programas más fiables, pues el compilador obliga al programador a ser consciente de los posibles
valores nulos y a gestionarlos de forma controlada.

---

## 1.4 Instanciación y referencias

La **instanciación** es el proceso mediante el cual se crea un nuevo objeto a partir de una clase. Al instanciar, se
reserva memoria para el estado del objeto y se inicializan sus atributos.

En Dart, como en muchos otros lenguajes orientados a objetos, los objetos no se manipulan directamente, sino a través de
**referencias**. Una referencia es un identificador que apunta al lugar de la memoria donde reside el objeto. Dicho de
otro modo, cuando se asigna un objeto a una variable, lo que realmente se guarda en esa variable es una referencia al
objeto, no el objeto en sí.

Este detalle es crucial para comprender fenómenos como la **mutabilidad compartida**: si dos variables apuntan al mismo
objeto, cualquier modificación realizada a través de una de ellas será visible también desde la otra, puesto que ambas
comparten la misma referencia.

---

## Conclusión

Los fundamentos de la POO en Dart se apoyan en una visión unificada del mundo de los datos: todo es un objeto, desde los
enteros hasta las estructuras más complejas. Las clases definen el molde, los atributos y métodos caracterizan el estado
y el comportamiento, y la instanciación convierte la abstracción en un objeto concreto manipulable mediante referencias.

A esto se suma el tipado estático con null safety, que dota al lenguaje de herramientas para detectar errores en tiempo
de compilación y garantizar mayor fiabilidad en la ejecución.

Este primer acercamiento establece la base sobre la cual se construyen las características más avanzadas de la POO en
Dart, que se explorarán en los capítulos posteriores.