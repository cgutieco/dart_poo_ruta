# Capítulo 11. Sobrecarga de Operadores

La **sobrecarga de operadores** es una característica de Dart que permite a las clases **definir o personalizar el
comportamiento de ciertos operadores** cuando se aplican a sus instancias.  
De este modo, los objetos pueden interactuar entre sí mediante expresiones más legibles y expresivas, como si fueran
tipos primitivos.

Por ejemplo, dos objetos que representan números complejos pueden "sumarse" con el operador `+`, en lugar de llamar a un
método `sumar()`.  
Aunque en esencia el resultado es el mismo, la **sobrecarga** mejora la naturalidad del código y su cercanía al dominio
que modela.

---

## 11.1 Operadores sobrecargables

En Dart no todos los operadores pueden sobrecargarse. El lenguaje ofrece un **conjunto específico** que puede
redefinirse mediante métodos especiales dentro de la clase.  
Estos operadores abarcan operaciones aritméticas, relacionales, lógicas y de acceso.

### Tabla 1. Operadores sobrecargables en Dart

| Categoría              | Operadores disponibles                  | Observaciones                                                                  |
|------------------------|-----------------------------------------|--------------------------------------------------------------------------------|
| Aritméticos            | `+`, `-`, `*`, `/`, `~/`, `%`, `unary-` | Incluye suma, resta, multiplicación, división entera, módulo y negación unaria |
| Comparación e igualdad | `==`, `<`, `>`, `<=`, `>=`              | El operador `==` requiere especial atención junto con `hashCode`               |
| Indexación             | `[]`, `[]=`                             | Permite tratar un objeto como si fuera una colección indexada                  |
| Bit a bit              | `&`, `                                  | `, `^`, `~`, `<<`, `>>`, `>>>`                                                 | Relevante en clases que representan estructuras binarias o de bajo nivel |

> **Nota académica**: operadores como `=` (asignación) o `?:` (ternario) **no pueden sobrecargarse**, ya que su
> semántica forma parte del núcleo inmutable del lenguaje.

---

## 11.2 Método especial `operator`

La sobrecarga se implementa definiendo métodos con la palabra clave `operator`.  
Cada operador corresponde a un nombre de método reservado que el compilador traduce automáticamente.

Ejemplo conceptual:

```dart
class Complejo {
  final double real;
  final double imaginario;

  Complejo(this.real, this.imaginario);

  // Sobrecarga del operador +
  Complejo operator +(Complejo otro) =>
      Complejo(real + otro.real, imaginario + otro.imaginario);
}
```

Gracias a esta definición, expresiones como:

```dart

var c = Complejo(1, 2) + Complejo(3, 4);
```

Tienen un sentido directo, legible y matemáticamente natural.

---

## 11.3 Métodos especiales fundamentales

Más allá de la sobrecarga explícita de operadores aritméticos o de acceso, Dart define tres métodos fundamentales que
toda clase debería considerar redefinir en algún momento: `==`, `hashCode` y `toString`.

Estos métodos son tan centrales que merecen un tratamiento separado.

---

### 11.3.1 El operador `==`

En Dart, el operador `==` no compara identidades por defecto, sino que es un método especial que puede sobreescribirse.
Esto significa que el programador puede decidir si dos objetos se consideran iguales en función de su estado interno, no
solo de su referencia en memoria.

- Implementación por defecto: compara identidad (similar a `===` en otros lenguajes).
- Implementación personalizada: compara campos significativos de la clase.

Ejemplo: en una clase `Persona`, redefinir `==` para comparar por `dni` en lugar de por instancia.

Relación con Java: en Java se sobreescribe `equals()`, mientras que `==` es inmutable y compara referencias. Dart
unifica ambos conceptos en un solo operador redefinible.

---

### 11.3.2 El método `hashCode`

El método `hashCode` está directamente ligado a `==`. En Dart (y en casi todos los lenguajes que implementan colecciones
hash), se cumple el siguiente contrato:

1. Si dos objetos son iguales según `==`, deben tener el mismo `hashCode`.
2. Si dos objetos tienen distinto `hashCode`, se garantiza que no son iguales.
3. El valor de `hashCode` debe ser inmutable mientras el objeto no cambie de estado.

Este método es esencial cuando se usan instancias como claves en estructuras como `Map` o `Set`.

Comparación con Java: la idea es idéntica; en Java se sobreescriben `equals()` y `hashCode()`, en Dart se redefinen `==`
y `hashCode`.

---

### 11.3.3 El método `toString`

El método `toString` permite personalizar la representación textual de un objeto. Es fundamental en procesos de
depuración, impresión de logs o en salidas orientadas al usuario.

- Implementación por defecto: devuelve `Instance of NombreClase`.
- Implementación personalizada: muestra atributos clave o una descripción más legible.

Aunque no afecta directamente al comportamiento de los operadores, `toString` se considera parte del “kit básico” de
métodos especiales en Dart.

---

## 11.4 Ejemplo académico de conjunto

Para apreciar la interacción de estos métodos, pensemos en una clase Fracción. Ella podría redefinir:

- `+`, `-`, `*`, `/` para operaciones aritméticas.
- `==` y `hashCode` para permitir comparar fracciones y usarlas en conjuntos.
- `toString` para mostrar su forma numerador/denominador.

Con esto, el tipo Fracción se comportaría casi como un tipo primitivo numérico, pero con toda la expresividad de un
objeto.

---

## 11.5 Tabla comparativa de métodos especiales

| Método / Operador            | Finalidad principal            | Relación con otros                 | Equivalente en Java                       |
|------------------------------|--------------------------------|------------------------------------|-------------------------------------------|
| `operator +`, `-`, `*`, etc. | Sobrecarga aritmética y lógica | Expresividad matemática            | Operator overloading (Java no lo soporta) |
| `operator []` / `[]=`        | Acceso indexado                | Permite colecciones personalizadas | `get()`/`set()` en colecciones            |
| `==`                         | Comparación de igualdad lógica | Debe ir acompañado de `hashCode`   | `equals()`                                |
| `hashCode`                   | Identificador hash             | Obligatorio junto a `==`           | `hashCode()`                              |
| `toString`                   | Representación textual         | Usado en depuración                | `toString()`                              |

---

## 11.6 Consideraciones y buenas prácticas

1. Coherencia semántica: nunca sobrecargar operadores de forma que confunda al lector.
    - Ejemplo negativo: redefinir `+` para restar.
2. Relación entre `==` y `hashCode`: siempre redefinir ambos en conjunto.
3. Evitar abusos: la sobrecarga está pensada para casos donde aporta claridad (números complejos, vectores, colecciones
   personalizadas). No es recomendable en dominios donde los operadores pierdan su significado natural.
4. Legibilidad primero: la sobrecarga debe ser una herramienta para acercar el código al lenguaje del problema, no para
   complicarlo.

---

## Conclusión

La sobrecarga de operadores en Dart dota al lenguaje de una expresividad poderosa, difícil de encontrar en muchos
lenguajes modernos (Java, por ejemplo, carece de ella). Mediante `operator`, junto con los métodos especiales `==`,
`hashCode` y `toString`, es posible construir tipos de datos personalizados que se comportan de forma natural,
integrándose de manera transparente con el resto del ecosistema de Dart.

De este modo, la POO en Dart trasciende la simple encapsulación de estado y comportamiento, acercándose a un modelo
matemático de objetos donde el código expresa las operaciones de forma tan natural como las escribiríamos en papel.
