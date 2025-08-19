# Capítulo 10. Modificadores de Clases en Dart (3.x)

La evolución de Dart hacia su versión 3.x introdujo un sistema de **modificadores de clase** que enriquece el modelo de
la Programación Orientada a Objetos.  
Estos modificadores permiten expresar **intenciones semánticas más precisas** sobre cómo debe usarse una clase en
jerarquías de herencia o composición.

En esencia, cada modificador impone **restricciones y contratos de uso** entre las clases, garantizando que el código
sea más seguro y expresivo.  
Este capítulo describe los distintos modificadores de clase en Dart 3.x: `abstract`, `base`, `interface`, `final`,
`sealed` y `mixin`. Además, se exploran sus combinaciones posibles.

---

## 10.1 `abstract`

El modificador `abstract` indica que una clase **no puede ser instanciada directamente**.  
Su objetivo es servir como **molde conceptual**: define atributos y métodos que las subclases deberán completar o
sobrescribir.

Características:

- Puede contener métodos abstractos (sin cuerpo).
- Puede contener métodos concretos (con implementación).
- Sirve como punto común para jerarquías.

Comparación con Java: en ambos lenguajes, `abstract` cumple la misma función. La diferencia es que en Dart puede
combinarse con otros modificadores (`abstract base`, `abstract interface`, etc.).

---

## 10.2 `base`

El modificador `base` indica que una clase **puede ser extendida, pero no implementada**.  
Es decir, las subclases pueden heredar de ella, pero no tomarla como contrato de interfaz.

Esto asegura que la relación de herencia se mantenga **estructural** y no se desvirtúe en simples implementaciones.

Ventajas:

- Evita implementaciones incorrectas o parciales de una clase.
- Conserva la jerarquía cerrada.

Ejemplo conceptual: una clase `Vehículo` marcada como `base` garantiza que solo se herede su estructura y no se trate
como interfaz.

---

## 10.3 `interface`

Una clase declarada como `interface` puede ser **implementada por otras clases**, pero no necesariamente extendida.  
En este caso, la clase funciona como un **contrato de comportamiento**, semejante a las interfaces de Java, pero con la
flexibilidad de que puede contener también implementación concreta.

Características:

- Puede ser implementada por múltiples clases.
- No está pensada para herencia estructural, sino para definición de contratos.
- Si se extiende directamente, sigue siendo válido (pero no es la intención primaria).

---

## 10.4 `final`

El modificador `final` en una clase indica que **no puede ser ni extendida ni implementada**.  
De este modo, la clase se convierte en un **bloque cerrado** de comportamiento, útil cuando se quiere garantizar que la
jerarquía no será alterada.

Usos típicos:

- Clases utilitarias.
- Tipos que no deben ser sobrescritos por razones de consistencia o seguridad.

En Java se logra algo similar con `final class`, pero en Dart su semántica está mejor integrada al sistema de subtipado.

---

## 10.5 `sealed`

Una clase `sealed` especifica que **solo puede ser extendida dentro del mismo archivo donde fue declarada**.  
Este modificador ofrece un control de jerarquía más preciso, permitiendo que el autor del archivo defina todas las
variantes posibles de una jerarquía.

Beneficios:

- Garantiza exhaustividad: el compilador puede advertir si un `switch` sobre esa jerarquía no es completo.
- Limita el alcance de extensión, asegurando consistencia en el diseño.

Comparación con Java: Java 17 introdujo `sealed classes` con un propósito casi idéntico. Dart adopta esta idea de forma
natural y la combina con su tipado flexible.

---

## 10.6 `mixin`

Aunque `mixin` es técnicamente un tipo especial, Dart 3.x permite declararlos con un modificador explícito.  
Un `mixin` no es instanciable, no define constructores propios y su función es **inyectar comportamiento común** en
diversas clases (véase capítulo anterior).

Su inclusión en esta lista tiene sentido porque, a nivel de gramática, los mixins comparten la misma estructura que las
clases y pueden combinarse con otros modificadores.

---

## 10.7 Combinaciones posibles

Una de las características más poderosas de Dart 3.x es la **composición de modificadores**.  
El lenguaje permite expresar matices como `abstract base` o `abstract interface`.  
Cada combinación implica un contrato diferente de uso.

### Ejemplos de combinaciones válidas:

- `abstract base` → clase abstracta que solo puede ser extendida, no implementada.
- `abstract interface` → interfaz abstracta pura, similar a Java.
- `base mixin` → un mixin que también puede comportarse como clase base.
- `abstract mixin` → un mixin que contiene métodos abstractos, delegando su implementación a las clases que lo utilicen.

---

## 10.8 Tabla de resumen

| Modificador | Instanciable | Extensible | Implementable          | Restricciones clave                 |
|-------------|--------------|------------|------------------------|-------------------------------------|
| `abstract`  | No           | Sí         | Sí                     | No puede instanciarse directamente  |
| `base`      | Sí           | Sí         | No                     | Solo se hereda, no se implementa    |
| `interface` | Sí           | Opcional   | Sí                     | Pensada para contratos              |
| `final`     | Sí           | No         | No                     | Bloquea la jerarquía                |
| `sealed`    | Sí           | Sí (local) | No                     | Solo extensible en el mismo archivo |
| `mixin`     | No           | No         | No (se usa con `with`) | Reutilización de comportamiento     |

---

## 10.9 Esquema visual

| Modificador | Objetivo principal         | Combinable | Herencia | Contratos | Cerrada | Local | Reuso |
|-------------|----------------------------|:----------:|:--------:|:---------:|:-------:|:-----:|:-----:|
| `abstract`  | Abstracción                |     ✔️     |    ✔️    |    ✔️     |         |       |       |
| `base`      | Herencia estructural       |     ✔️     |    ✔️    |           |         |       |       |
| `interface` | Contrato de comportamiento |     ✔️     | Opcional |    ✔️     |         |       |       |
| `final`     | Jerarquía cerrada          |     ✔️     |          |           |   ✔️    |       |       |
| `sealed`    | Extensión local            |     ✔️     |    ✔️    |           |         |  ✔️   |       |
| `mixin`     | Reutilización              |     ✔️     |          |           |         |       |  ✔️   |

Este esquema muestra cómo los modificadores orientan la semántica de la clase hacia distintos objetivos: abstracción,
herencia, contratos, cierre, limitación o reutilización.

---

## Conclusión

El sistema de modificadores de clases en Dart 3.x ofrece una **gramática precisa y flexible** para expresar la intención
de diseño.  
Mientras que en Java los modificadores son pocos (`abstract`, `final`, `sealed` en versiones modernas), Dart avanza
hacia un sistema **rico en combinaciones**, permitiendo a los desarrolladores modelar jerarquías claras y seguras.

La comprensión de estos modificadores es fundamental para escribir código **robusto, mantenible y expresivo**, ya que
cada palabra clave actúa como un contrato explícito entre el autor de la clase y los futuros desarrolladores que la
extiendan o implementen.
