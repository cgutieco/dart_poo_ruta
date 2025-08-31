# Capítulo 15. Patrones de Diseño

Los **patrones de diseño** son soluciones probadas y reutilizables a problemas comunes que aparecen durante el
desarrollo de software.  
No son fragmentos de código listos para copiar y pegar, sino **esquemas conceptuales** que guían al programador en la
creación de arquitecturas más claras, flexibles y mantenibles.

En el contexto de Dart —y de la Programación Orientada a Objetos en general— los patrones de diseño se entienden como 
**formas estandarizadas de organizar clases, objetos e interacciones** para resolver necesidades que aparecen una y otra
vez: cómo crear objetos, cómo estructurar jerarquías o cómo comunicar diferentes componentes.

---

## 15.1 Origen y propósito

El término *patrón de diseño* se popularizó con la publicación de *Design Patterns: Elements of Reusable Object-Oriented
Software* (1994), obra de Erich Gamma, Richard Helm, Ralph Johnson y John Vlissides, conocidos como la **Banda de los
Cuatro (GoF)**.  
En este libro se recopilaron 23 patrones fundamentales que han sido adoptados como referencia obligada en el diseño de
sistemas orientados a objetos.

El propósito principal de los patrones es:

- **Estandarizar el lenguaje de diseño** entre programadores.
- **Reducir la complejidad** al ofrecer soluciones ya conocidas y validadas.
- **Favorecer la reutilización** de conceptos y estructuras.
- **Mejorar la comunicación** en equipos, ya que hablar de un “Singleton” o un “Observer” transmite una idea precisa sin
  necesidad de explicaciones largas.

---

## 15.2 Clasificación general de los patrones

Aunque en esta introducción no profundizaremos en cada patrón, es útil conocer la clasificación clásica:

| Categoría                      | Propósito general                                                                                                               |
|--------------------------------|---------------------------------------------------------------------------------------------------------------------------------|
| **Patrones creacionales**      | Se enfocan en la **forma de crear objetos**, asegurando flexibilidad y control (ejemplo: *Singleton*).                          |
| **Patrones estructurales**     | Tratan sobre la **composición de clases y objetos**, facilitando la reutilización y extensibilidad (ejemplo: *Adapter*).        |
| **Patrones de comportamiento** | Describen la **interacción y comunicación entre objetos**, definiendo responsabilidades y colaboraciones (ejemplo: *Observer*). |

---

## 15.3 Patrones de diseño en Dart

Dart, como lenguaje moderno, ofrece características que influyen en cómo se aplican los patrones:

- Su **sistema de clases flexible** (con `extends`, `implements`, `mixin`) permite expresar patrones con mayor
  naturalidad que en lenguajes más rígidos.
- Los **constructores `factory`** aportan mecanismos muy adecuados para patrones creacionales como *Singleton* o
  *Factory Method*.
- La **inmutabilidad (`const`, `final`)** apoya la implementación de patrones que requieren consistencia de estado.
- El ecosistema de **Flutter** hace que algunos patrones sean especialmente relevantes, como *Builder*, *State* o
  *Observer*, en la gestión de interfaces reactivas.

---

## 15.4 Beneficios y críticas

### Beneficios:

- Aportan un **lenguaje común** que agiliza el trabajo en equipo.
- Facilitan la **transferencia de conocimiento**: un desarrollador puede reconocer un patrón sin importar el lenguaje.
- Proveen **soluciones probadas**, reduciendo el riesgo de errores.
- Fomentan la **mantenibilidad** del código.

### Críticas:

- Si se aplican sin necesidad real, pueden añadir **complejidad innecesaria**.
- Algunos patrones son **menos relevantes en lenguajes modernos** que ya ofrecen mecanismos equivalentes (por ejemplo,
  en Dart el *Singleton* se implementa de forma más simple gracias a los `factory constructors`).
- Su uso mecánico puede convertirse en una **sobrecarga conceptual** para principiantes.

---

## 15.5 Conclusión

Los patrones de diseño constituyen una **herramienta conceptual esencial** en la práctica profesional de la programación
orientada a objetos.  
En Dart, su aplicación se ve enriquecida por las características modernas del lenguaje, que permiten implementar muchos
de ellos de manera más sencilla que en lenguajes tradicionales como Java o C++.

Este capítulo sirve de **introducción general**; en las siguientes secciones, cada patrón será tratado de forma
independiente, mostrando cómo se adapta su estructura al ecosistema de Dart y qué ventajas ofrece en la construcción de
sistemas robustos y escalables.
