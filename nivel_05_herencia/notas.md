# Capítulo 5. Herencia en Dart

La **herencia** es uno de los pilares de la Programación Orientada a Objetos y se fundamenta en la posibilidad de
definir nuevas clases a partir de clases existentes, reutilizando su estructura y comportamiento.  
En Dart, la herencia constituye un mecanismo central para expresar relaciones jerárquicas entre tipos, favoreciendo la
reutilización del código y la creación de abstracciones más generales.

El objetivo de este capítulo es explorar cómo se implementa la herencia en Dart 3.9, qué papel desempeñan las palabras
clave `extends`, `super` y la anotación `@override`, y cómo diseñar jerarquías de clases efectivas y mantenibles.

---

## 5.1 La palabra clave `extends`

La herencia en Dart se establece mediante la palabra clave **`extends`**.  
Cuando una clase se declara con `extends`, se convierte en una **subclase** de otra clase, conocida como **superclase**
o clase base.

- **Superclase**: la clase que proporciona atributos y métodos que pueden ser heredados.
- **Subclase**: la clase que hereda de otra, obteniendo automáticamente los miembros públicos y protegidos de la
  superclase.

La relación se suele describir con la frase “una subclase **es un(a)** superclase”. Por ejemplo, si `Perro` hereda de
`Animal`, se interpreta que *un perro es un animal*.

En Dart, solo se permite **herencia simple**, es decir, una clase puede extender únicamente de una superclase. Esto
contrasta con lenguajes como C++ que permiten herencia múltiple, pero evita la complejidad de los problemas clásicos de
ambigüedad (*diamond problem*).

---

## 5.2 Sobrescritura con `@override`

Una subclase no solo hereda las características de su superclase, sino que también puede **sobrescribir** métodos o
getters/setters para modificar o especializar su comportamiento.

En Dart, esta sobrescritura debe señalarse con la anotación **`@override`**, la cual cumple dos propósitos:

1. Hace explícita la intención del programador de redefinir un método heredado.
2. Permite al compilador verificar que efectivamente el método sobrescrito existe en la superclase, evitando errores por
   simples coincidencias de nombre.

La sobrescritura es fundamental en el polimorfismo: permite que un mismo mensaje (invocación de un método) produzca
diferentes respuestas según el tipo real del objeto.

Ejemplo conceptual:

- La clase `Animal` define un método `emitirSonido()`.
- La clase `Perro` sobrescribe este método para devolver “ladrar”.
- La clase `Gato` lo sobrescribe para devolver “maullar”.

Así, desde el punto de vista del usuario, basta con invocar `emitirSonido()` en cualquier `Animal`, sin importar su
subtipo concreto.

---

## 5.3 El uso de `super`

La palabra clave **`super`** permite que una subclase invoque miembros de su superclase. Su utilidad principal radica en
dos escenarios:

### 5.3.1 Llamada a constructores

Cuando una subclase define su propio constructor, puede (y en muchos casos debe) invocar explícitamente al constructor
de la superclase utilizando `super(...)`. Esto asegura que la parte de la instancia correspondiente a la superclase
quede correctamente inicializada.

Si no se invoca de manera explícita, Dart inserta una llamada implícita al constructor sin parámetros de la superclase.

### 5.3.2 Acceso a métodos y atributos

`super` también permite acceder directamente a métodos o atributos definidos en la superclase, incluso si han sido
sobrescritos. Esto es útil cuando se quiere extender el comportamiento de un método heredado sin perder la
implementación original.

Por ejemplo, una subclase puede sobrescribir un método para añadir funcionalidad extra y, dentro de él, invocar al
método original de la superclase mediante `super.metodo()`.

---

## 5.4 Jerarquías de clases

Una **jerarquía de clases** es la organización de clases en forma de árbol, donde:

- Las clases más generales se sitúan en los niveles superiores.
- Las clases más específicas heredan de las anteriores y aparecen en los niveles inferiores.

### 5.4.1 Diseño de jerarquías

El diseño de jerarquías eficaces requiere balancear dos objetivos:

- **Reutilización de código**: evitar repetir atributos y métodos comunes mediante su extracción a una superclase.
- **Especialización**: permitir que las subclases definan o modifiquen el comportamiento para adaptarlo a casos
  concretos.

Un error común es caer en **jerarquías excesivamente profundas**, que resultan difíciles de comprender y mantener. En la
práctica, se recomienda favorecer jerarquías poco profundas y, cuando sea posible, delegar responsabilidades mediante
composición en lugar de herencia.

### 5.4.2 Herencia y el objeto raíz en Dart

En Dart, todas las clases heredan implícitamente de la clase **`Object`**, salvo que se indique lo contrario.  
La clase `Object` define métodos básicos como:

- `toString()`
- `==` (operador de igualdad)
- `hashCode`
- `runtimeType`

Esto significa que cualquier clase en Dart, incluso aquellas definidas por el usuario, heredan y pueden sobrescribir
estos métodos fundamentales.

---

## Conclusión

La herencia en Dart se construye sobre una base clara y minimalista:

- Se utiliza **`extends`** para indicar la relación entre superclase y subclase.
- La sobrescritura explícita con **`@override`** permite especializar el comportamiento heredado de manera segura.
- La palabra clave **`super`** conecta la subclase con su superclase, tanto en la inicialización de constructores como
  en la reutilización de métodos.
- Todas las clases descienden, en última instancia, de **`Object`**, lo que garantiza un conjunto común de
  comportamientos básicos.

Las jerarquías de clases deben diseñarse con moderación: lo suficientemente generales para favorecer la reutilización,
pero sin caer en estructuras rígidas y difíciles de extender. Este equilibrio es la clave para que la herencia en Dart
sea un recurso poderoso al servicio de la claridad y la mantenibilidad del código.