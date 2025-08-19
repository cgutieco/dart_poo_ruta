# Capítulo 18. Genéricos en Dart

Los **genéricos** constituyen uno de los pilares del diseño moderno en lenguajes tipados como Dart. Su propósito
fundamental es **parametrizar tipos**, lo que permite definir clases, métodos y funciones que trabajan sobre una familia
de tipos sin necesidad de reescribir el código para cada caso concreto.

En este capítulo estudiaremos en detalle el sistema de genéricos de Dart 3.x, desde la definición de clases y métodos
genéricos, pasando por las restricciones con `extends`, hasta llegar a su interacción con **mixins**.

---

## 18.1 Motivación y fundamento teórico

El problema que los genéricos resuelven se conoce como **reutilización tipada**. Supongamos que se desea una clase que
actúe como contenedor de valores. Si no existieran genéricos, tendríamos dos opciones:

1. Definir clases duplicadas para cada tipo (`CajaDeEntero`, `CajaDeString`, etc.), lo que genera redundancia.
2. Usar un tipo universal como `Object` o `dynamic`, perdiendo seguridad en tiempo de compilación (se podrían insertar
   tipos erróneos).

Los **genéricos** ofrecen una solución: parametrizar la clase con un símbolo de tipo `T` (o cualquier identificador),
que luego se sustituye por un tipo concreto al instanciar.

---

## 18.2 Clases genéricas

Una **clase genérica** declara parámetros de tipo entre `<>`. Por convención, se usan letras mayúsculas (`T`, `E`, `K`,
`V`) pero también pueden usarse nombres descriptivos.

```dart
class Caja<T> {
  final T valor;

  Caja(this.valor);

  T obtener() => valor;
}
```

En este ejemplo:

- `Caja<T>` es una plantilla de clase donde `T` es un parámetro de tipo.
- `Caja<int>` sería una caja que solo puede contener enteros.
- `Caja<String>` sería una caja que solo puede contener cadenas.

**Ventajas**:

- Seguridad en tiempo de compilación: el compilador impide insertar un valor de tipo distinto.
- Reutilización de código: una sola definición de clase sirve para cualquier tipo.

---

## 18.3 Métodos genéricos

Los genéricos no se limitan a las clases. Los **métodos genéricos** permiten definir funciones o métodos parametrizados
por tipo.

```dart
T elegirPrimero<T>(List<T> lista) {
  return lista.first;
}
```

Aquí:

- El método recibe una lista de elementos de tipo `T`.
- Retorna el primer elemento de esa lista, garantizando que el tipo de retorno es exactamente el mismo que el de los
  elementos de entrada.

Este mecanismo es útil en algoritmos genéricos (ordenación, filtrado, utilidades de colección).

---

## 18.4 Restricciones con `extends`

En ocasiones, se necesita limitar los tipos que pueden usarse como argumento genérico. Esto se logra con **restricciones
de tipo** mediante `extends`.

```dart
abstract class Animal {
  void hacerSonido();
}

class Jaula<T extends Animal> {
  final T animal;

  Jaula(this.animal);

  void sonar() => animal.hacerSonido();
}
```

Explicación:

- `T extends Animal` significa que `T` debe ser `Animal` o un subtipo de este.
- De este modo, dentro de la clase `Jaula` es seguro invocar métodos definidos en `Animal`, como `hacerSonido()`.
- Intentar instanciar `Jaula<int>` provocaría un error en tiempo de compilación, pues `int` no es un `Animal`.

**Notas conceptuales**:

- Dart no admite restricciones múltiples con comas (`T extends A, B`).
- Para simular múltiples restricciones, se emplean **mixin constraints** o jerarquías de tipos adecuadas.

---

## 18.5 Genéricos con mixins

Los **mixins** también pueden ser genéricos, lo que amplía notablemente su flexibilidad. Un mixin genérico permite
inyectar comportamiento parametrizado en múltiples clases.

```dart
mixin Registrable<T> {
  void registrar(T valor) {
    print('Registrando: $valor');
  }
}

class Usuario {
  final String nombre;

  Usuario(this.nombre);
}

class GestorUsuarios with Registrable<Usuario> {}
```

En este caso:

- El mixin `Registrable<T>` define un comportamiento genérico para registrar valores de tipo `T`.
- `GestorUsuarios` aplica el mixin con `Usuario` como tipo concreto.
- De esta forma, el mixin queda adaptado al dominio específico sin duplicar lógica.

---

## 18.6 Consideraciones avanzadas

- **Invariancia**: en Dart, los genéricos son **invariantes**. Es decir, `List<Animal>` **no** es subtipo de
  `List<Gato>`, incluso si `Gato` extiende `Animal`. Esto evita errores en tiempo de compilación.
- **Type inference**: el compilador puede inferir los parámetros genéricos en muchos contextos, reduciendo la necesidad
  de especificarlos explícitamente.
- **Covarianza controlada**: algunas clases de la librería estándar están anotadas como covariantes (`covariant`), lo
  que flexibiliza las relaciones de subtipo pero requiere precaución.
- **Bounds chaining**: un tipo genérico puede encadenar restricciones (por ejemplo, `T extends Comparable<T>`), lo que
  es común en estructuras ordenadas.

---

## 18.7 Aplicaciones típicas en POO con Dart

- **Colecciones tipadas**: listas, mapas y sets genéricos evitan errores de tipo.
- **Repositorios y servicios**: clases genéricas que gestionan entidades (`Repositorio<T>`).
- **Mixins utilitarios**: como `Registrable<T>`, permiten compartir comportamiento genérico en distintas clases.
- **Patrones de diseño**: muchos patrones (Factory, Repository, Adapter) se benefician de la parametrización por tipo.

---

## Conclusión

Los **genéricos en Dart** proporcionan una abstracción poderosa para escribir código reutilizable y seguro en términos
de tipos.

- Las **clases genéricas** evitan duplicación y permiten colecciones y contenedores robustos.
- Los **métodos genéricos** facilitan algoritmos que trabajan con familias de tipos.
- Las **restricciones con `extends`** aseguran correctitud al limitar qué tipos son válidos.
- Los **mixins genéricos** amplían la expresividad, permitiendo inyectar comportamiento tipado en múltiples clases.

Dominar los genéricos no solo evita errores, sino que conduce a un estilo de programación más expresivo, flexible y
mantenible en Dart 3.x.
