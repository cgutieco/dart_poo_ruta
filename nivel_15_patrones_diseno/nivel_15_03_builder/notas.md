# Capítulo 15.3 — Builder en Dart

El patrón **Builder** (o *Constructor*) es un patrón **creacional** cuyo propósito es **separar la construcción compleja
de un objeto de su representación final**. A diferencia de *Factory* —que se centra en **qué tipo de objeto se construye
**— el Builder se enfoca en **cómo se construye paso a paso**.

Este patrón es particularmente útil cuando un objeto requiere múltiples pasos de configuración, validaciones, o puede
tener múltiples representaciones con los mismos pasos de construcción.

---

## 1. Propósito del Builder

1. **Separar construcción y representación**: el mismo proceso de construcción puede producir diferentes
   representaciones.
2. **Facilitar la creación de objetos complejos**: evita constructores con demasiados parámetros.
3. **Promover la inmutabilidad**: se construye un objeto “temporal” que al final se convierte en uno inmutable.
4. **Mejorar la legibilidad**: la creación del objeto se vuelve más declarativa y semántica.

---

## 2. Teoría en POO

El patrón Builder responde a la necesidad de **controlar la complejidad en el proceso de instanciación**. En vez de
crear un objeto de golpe con un gran constructor lleno de parámetros, el Builder permite dividir ese proceso en pasos
claros, independientes y encadenables.

En términos académicos, se considera que el Builder implementa:

- **SRP (Principio de Responsabilidad Única)**: la clase producto no se preocupa por cómo se construye.
- **OCP (Principio Abierto/Cerrado)**: se pueden añadir nuevos builders sin modificar el cliente.
- **Fluidez en la API**: mediante encadenamiento de métodos (*method chaining*).

---

## 3. Builder en Dart

Dart no tiene soporte nativo especial para Builder (como sí ocurre con Kotlin y su DSL), pero ofrece:

- **Constructores nombrados con parámetros opcionales** para configuraciones básicas.
- **Clases dedicadas tipo Builder** para construir objetos complejos.
- **Uso de `copyWith`** en combinación con inmutabilidad.

### Ejemplo básico: objeto complejo sin Builder

```dart
class User {
  final String name;
  final int age;
  final String email;
  final String address;
  final bool isAdmin;

  User(this.name, this.age, this.email, this.address, this.isAdmin);
}

void main() {
  final user = User("Alice", 30, "alice@mail.com", "Calle 123", false);
}
```

Este constructor es difícil de leer y propenso a errores (¿cuál es el quinto parámetro?). Aquí el Builder es una
alternativa elegante.

---

Ejemplo con Builder en Dart

```dart
class User {
  final String name;
  final int age;
  final String email;
  final String address;
  final bool isAdmin;

  User._builder(UserBuilder builder)
      : name = builder.name,
        age = builder.age,
        email = builder.email,
        address = builder.address,
        isAdmin = builder.isAdmin;
}

class UserBuilder {
  String name = "";
  int age = 0;
  String email = "";
  String address = "";
  bool isAdmin = false;

  UserBuilder setName(String name) {
    this.name = name;
    return this;
  }

  UserBuilder setAge(int age) {
    this.age = age;
    return this;
  }

  UserBuilder setEmail(String email) {
    this.email = email;
    return this;
  }

  UserBuilder setAddress(String address) {
    this.address = address;
    return this;
  }

  UserBuilder setAdmin(bool isAdmin) {
    this.isAdmin = isAdmin;
    return this;
  }

  User build() => User._builder(this);
}

void main() {
  final user = UserBuilder()
      .setName("Alice")
      .setAge(30)
      .setEmail("alice@mail.com")
      .setAddress("Calle 123")
      .setAdmin(true)
      .build();

  print(user.name); // Alice
}
```

---

#### 4. Variantes de uso en Dart

| Variante                       | Descripción                                                                           | Ejemplo                                                            |
|--------------------------------|---------------------------------------------------------------------------------------|--------------------------------------------------------------------|
| Fluent Builder                 | Encadenamiento de métodos para mayor legibilidad                                      | `UserBuilder().setName("X").setAge(25).build()`                    |
| Director                       | Clase adicional que orquesta pasos del Builder                                        | Un `UserDirector` que define cómo se construye un usuario estándar |
| copyWith                       | Combinado con inmutabilidad: permite crear nuevas instancias basadas en una existente | `user.copyWith(email: "nuevo@mail.com")`                           |
| DSL (Domain Specific Language) | Se aprovechan lambdas o funciones anónimas para un estilo declarativo                 | `createUser((b) => b..name="X"..age=30)`                           |

---

#### 5. Diferencia entre Factory y Builder

| Aspecto         | Factory                                      | Builder                                                               |
|-----------------|----------------------------------------------|-----------------------------------------------------------------------|
| Enfoque         | Decide qué tipo de objeto crear              | Decide cómo construir el objeto paso a paso                           |
| Complejidad     | Apropiado para objetos relativamente simples | Ideal para objetos complejos con muchos parámetros                    |
| Resultado       | Generalmente entrega una instancia lista     | Puede entregar diferentes representaciones a partir del mismo proceso |
| Extensibilidad  | Facilita añadir nuevos productos             | Facilita añadir nuevas formas de construcción                         |
| Ejemplo en Dart | `factory Shape(String type)`                 | `UserBuilder().setName("X").setAge(20).build()`                       |

---

#### 6. Ventajas y desventajas

**Ventajas**

- Claridad en la construcción de objetos complejos.
- Fomenta inmutabilidad.
- Flexibilidad para añadir pasos opcionales.
- Facilita la legibilidad del código cliente.

**Desventajas**

- Añade clases adicionales (mayor verbosidad).
- Puede parecer innecesario para objetos simples.
- Puede derivar en una API sobrecargada si no se diseña cuidadosamente.

---

#### 7. Builder y otros patrones

- **Factory + Builder**: un Factory puede delegar la creación de instancias complejas a un Builder.
- **Prototype + Builder**: se pueden combinar para clonar un objeto y luego modificarlo paso a paso.
- **Director**: separa la lógica de construcción estándar (ejemplo: “usuario administrador por defecto”) en una capa
  superior.

---

### Conclusión

El Builder en Dart es un patrón valioso cuando los objetos poseen múltiples parámetros o requieren configuraciones
graduales.  
Permite construir instancias de manera legible, fluida y mantenible, evitando los problemas de los constructores largos
y facilitando la inmutabilidad.  
En sistemas complejos, su combinación con otros patrones creacionales (como Factory o Prototype) refuerza la
flexibilidad y la claridad del diseño.