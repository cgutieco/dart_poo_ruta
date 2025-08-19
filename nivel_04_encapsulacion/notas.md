# Capítulo 4. Encapsulación en Dart

La **encapsulación** constituye uno de los principios fundamentales de la Programación Orientada a Objetos. Consiste en
ocultar los detalles internos de una clase y exponer solo aquello que resulta esencial para que otros componentes puedan
interactuar con ella de manera controlada y segura.

En términos prácticos, la encapsulación se materializa a través de **modificadores de acceso**, los cuales delimitan qué
partes del código son visibles desde fuera de la clase, del archivo o incluso del paquete. Aunque Dart ofrece un enfoque
más simple que otros lenguajes tradicionales como Java o C++, su modelo resulta coherente con la filosofía de
minimalismo y claridad del lenguaje.

---

## 4.1 Modificadores de acceso en Dart

A diferencia de lenguajes como Java, Dart no cuenta con un abanico extenso de modificadores (`public`, `protected`,
`private`, `internal`). En su lugar, adopta un sistema más directo y minimalista: **todo miembro de una clase es público
por defecto**, salvo que se declare como **privado** mediante un guion bajo (`_`) como prefijo en su nombre.

### 4.1.1 Público (por defecto)

Cuando un atributo, método o clase no lleva un guion bajo al inicio de su nombre, se considera **público**.  
Esto significa que puede ser accedido desde cualquier otro archivo o paquete dentro del mismo proyecto.

Ejemplos de miembros públicos incluyen:

- Atributos que se desea exponer como parte de la API de la clase.
- Métodos que constituyen las operaciones principales de la entidad modelada.

El hecho de que lo público sea la opción por defecto refleja la filosofía pragmática de Dart: se asume apertura salvo
que el programador decida lo contrario.

### 4.1.2 Privado (prefijo `_`)

Cuando un miembro comienza con `_`, se vuelve **privado a nivel de librería**. Esto significa que:

- Solo puede ser accedido desde el mismo archivo o librería en la que fue definido.
- No está disponible para otros archivos que importen dicha librería.

Este mecanismo de privacidad es menos granular que en otros lenguajes (donde existen distinciones como "protegido" o "
amigo"), pero se ajusta adecuadamente a las necesidades del desarrollo en Dart.

La privacidad mediante `_` resulta útil para:

- Proteger la implementación interna de una clase.
- Evitar dependencias innecesarias entre módulos.
- Garantizar que otros desarrolladores utilicen solo la interfaz pública prevista.

Conviene subrayar que la privacidad en Dart **no opera a nivel de clase**, sino de **librería**. Esto significa que,
dentro de un mismo archivo, cualquier clase puede acceder a los miembros privados de otra.

---

## 4.2 Convenciones de paquetes y librerías

La encapsulación en Dart no se limita al ámbito de una clase, sino que se extiende a la **organización modular** del
código a través de librerías y paquetes.

### 4.2.1 Librerías

En Dart, cada archivo `.dart` constituye una **librería** independiente.

- Los miembros públicos de un archivo son accesibles desde cualquier otro que lo importe.
- Los miembros privados (prefijados con `_`) permanecen invisibles fuera de la librería.

Para proyectos más complejos, es común dividir el código en múltiples archivos y luego unirlos utilizando las directivas
`part` y `part of`. Esto permite que varios archivos formen una única librería lógica, compartiendo entre sí incluso los
miembros privados.

De este modo, se puede mantener una separación física del código (varios archivos) sin renunciar a la encapsulación
común de una librería unificada.

### 4.2.2 Paquetes

Un **paquete** en Dart es un conjunto organizado de librerías, recursos y metadatos (descritos en el archivo
`pubspec.yaml`).  
Los paquetes son la unidad básica de distribución y reutilización en el ecosistema de Dart y Flutter.

En el contexto de la encapsulación:

- Cada paquete expone una **API pública** a través de un archivo principal, normalmente ubicado en la carpeta `lib/`.
- Se recomienda que el archivo principal reexporte únicamente aquellas librerías que deben ser accesibles para los
  usuarios del paquete, ocultando las internas.
- Los archivos que residen en subcarpetas como `lib/src/` suelen considerarse **internos**: aunque técnicamente
  accesibles si se importan directamente, la convención indica que no deben utilizarse fuera del paquete.

Este modelo de organización se basa en la confianza y las convenciones de la comunidad: lo que se expone desde `lib/` es
la interfaz pública estable, y lo que queda en `lib/src/` está sujeto a cambios sin previo aviso.

### 4.2.3 Encapsulación mediante diseño de API

La verdadera fuerza de la encapsulación en Dart se logra combinando el uso de `_` con una adecuada organización en
librerías y paquetes. Algunas recomendaciones prácticas son:

- Exponer únicamente lo necesario para que otros módulos o desarrolladores interactúen con tu código.
- Mantener las implementaciones auxiliares y las clases de soporte como privadas.
- Documentar claramente qué parte de la API está diseñada para uso externo y cuál pertenece a la lógica interna.

En definitiva, la encapsulación no es solo un recurso técnico, sino también un ejercicio de diseño cuidadoso de
interfaces públicas y contratos de uso.

---

## Conclusión

La encapsulación en Dart se apoya en un modelo simple pero eficaz:

- **Por defecto, todo miembro es público.**
- **Un guion bajo (`_`) convierte un miembro en privado a nivel de librería.**
- Los archivos `.dart` constituyen librerías, que pueden agruparse en paquetes.
- Las convenciones de organización (`lib/` para lo público, `lib/src/` para lo interno) refuerzan las buenas prácticas
  de encapsulación.

Este enfoque minimalista evita la complejidad de múltiples modificadores de acceso y, sin embargo, ofrece el grado de
protección suficiente para construir sistemas modulares, comprensibles y mantenibles.

La encapsulación, combinada con los mecanismos de clases y constructores, permite controlar de manera precisa qué se
revela y qué se oculta, sentando las bases para jerarquías robustas y para una clara separación entre interfaz pública e
implementación interna.