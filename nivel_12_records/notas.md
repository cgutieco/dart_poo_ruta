# Capítulo 12. Records y Tipos de Valor

Con la llegada de **Dart 3**, el lenguaje incorporó los **records** como una nueva forma de agrupar valores relacionados
sin necesidad de definir explícitamente una clase.  
Se trata de una característica especialmente útil cuando se desea **retornar múltiples valores de una función**, *
*transportar datos sin comportamiento** o **trabajar con tipos de valor ligeros**, que ofrecen ventajas en legibilidad y
eficiencia.

Los records se consideran parte de la categoría de **tipos de valor**, en contraste con los objetos tradicionales, que
son **tipos de referencia**.  
Este cambio de paradigma amplía el modelo de programación de Dart, ofreciendo más flexibilidad y expresividad.

---

## 12.1 Sintaxis de Records

La sintaxis de un record se basa en **paréntesis** que agrupan un conjunto de valores, los cuales pueden ser:

- **Posicionales**: definidos por su orden.
- **Nombrados**: definidos por su nombre explícito.
- **Mixtos**: combinación de ambos en un mismo record.

Ejemplos conceptuales:

- Record posicional: `(1, "texto", true)`
- Record nombrado: `(:x: 10, y: 20)`
- Record mixto: `(1, 2, z: 3)`

En esencia, un record es una **estructura inmutable** y **ligera**, capaz de representar un conjunto fijo de valores con
un **tipo estático inflexible**.

---

## 12.2 Uso como Parámetros y Retornos

Una de las motivaciones principales de los records es simplificar la **transmisión de múltiples valores** entre
funciones sin tener que crear clases auxiliares.

### Como retorno de funciones

Tradicionalmente, para devolver más de un valor en Dart era necesario:

1. Retornar un objeto contenedor (una clase específica).
2. Retornar una lista o mapa (con pérdida de tipado fuerte).

Con records, se puede devolver directamente un conjunto tipado de valores:

```dart
(int, int) coordenadas() => (10, 20);
```

El resultado puede desestructurarse en variables individuales, lo que mejora la legibilidad y elimina código accesorio.

Como parámetros de funciones

De igual manera, records pueden ser utilizados como parámetros.
Esto es especialmente útil para agrupaciones lógicas de datos que no justifican la creación de una clase propia.

```dart
void imprimir((String, int) persona) {
  print("Nombre: ${persona.$1}, Edad: ${persona.$2}");
}
```

La notación $1, $2, etc. se utiliza para acceder a los campos posicionales.
En records nombrados, se accede por nombre directamente.

---

## 12.3 Comparación Estructural

Una de las características más notables de los records es que su igualdad se define por comparación estructural, no por
referencia.
Esto significa que dos records con los mismos valores se consideran iguales, aunque hayan sido creados en momentos
distintos.

Ejemplo conceptual:

```dart

var r1 = (x: 1, y: 2);
var r2 = (x: 1, y: 2);
print
(
r1
==
r2
); // true
```

Este comportamiento contrasta con las clases, donde la igualdad depende de la implementación de ==.
En records, la igualdad es automática y garantizada por el compilador.

---

## 12.4 Diferencias con Tuplas

Los records de Dart suelen compararse con las tuplas de otros lenguajes, pero existen diferencias notables que los hacen
más robustos y expresivos.

**Tabla 1. Diferencias entre records en Dart y tuplas tradicionales**

| Característica      | Records en Dart                                    | Tuplas (ej. en C#, Python)                  |
|---------------------|----------------------------------------------------|---------------------------------------------|
| Tipado              | Fuerte, estático, inmutable                        | Fuerte (C#) o dinámico (Python)             |
| Acceso a campos     | Por posición (`$1`, `$2`) o nombre (`x`, `y`)      | Generalmente por posición                   |
| Igualdad            | Comparación estructural por defecto                | Depende del lenguaje, no siempre automática |
| Nombrado            | Permiten campos con nombre                         | En muchos lenguajes, solo posicional        |
| Integración con POO | Tipos de valor nativos dentro del sistema de tipos | Estructuras externas, menos integradas      |

En resumen, los records en Dart son más que simples tuplas: constituyen un tipo de valor de primera clase, con igualdad
estructural, posibilidad de nombres explícitos y total integración con el sistema de tipos estático y la null safety.

---

## 12.5 Consideraciones Académicas

1. **Economía de código**: los records permiten reducir la necesidad de clases triviales usadas únicamente como
   contenedores de datos.
2. **Limitaciones**: al ser tipos de valor, no admiten herencia ni métodos; su propósito es representar datos, no
   comportamiento.
3. **Compatibilidad con null safety**: los records respetan la obligatoriedad de especificar nulabilidad en sus campos.
4. **Buena práctica**: usar records en operaciones locales o funciones utilitarias. Para modelos de dominio con reglas
   de negocio, se recomienda seguir empleando clases.

---

## Conclusión

Los records en Dart constituyen una poderosa herramienta para trabajar con datos agrupados de forma ligera, tipada e
inmutable.  
Al ofrecer comparación estructural y la posibilidad de nombres explícitos, superan a las tuplas tradicionales y se
integran plenamente con el modelo de tipos de valor que complementa al de objetos.

En definitiva, los records simplifican la escritura de código más conciso, seguro y expresivo, ampliando las capacidades
de Dart en el terreno de la programación funcional y orientada a datos.