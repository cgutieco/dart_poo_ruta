# Capítulo 15.2 — Factory en Dart

El patrón **Factory** (o *Fábrica*) se ubica dentro de los **patrones creacionales** de la Programación Orientada a
Objetos. Su objetivo central es **abstraer la creación de objetos** y delegar la responsabilidad a una entidad
especializada (*la fábrica*), separando así el **qué se crea** del **cómo se crea**.  
En Dart, la idea de fábrica puede expresarse de varias formas: desde un **método estático** que decide qué instancia
retornar, hasta el uso del **constructor `factory`** que redefine el comportamiento de creación. Esta flexibilidad
permite diseñar sistemas con **bajo acoplamiento** y **alta extensibilidad**, cualidades valoradas en la ingeniería de
software.

---

## 1. Propósito general del Factory

1. **Encapsular la lógica de instanciación** para no exponer detalles internos.
2. **Desacoplar el cliente** de las implementaciones concretas, permitiendo trabajar sobre **interfaces o clases
   abstractas**.
3. **Simplificar la reutilización** y reducir la duplicación de código al centralizar la creación.
4. **Promover la extensibilidad**: se pueden añadir nuevas variantes de productos sin alterar el código cliente.
5. **Asegurar consistencia** en la creación de objetos complejos o con configuraciones estándar.

---

## 2. Concepto en términos de teoría de POO

En teoría, el patrón Factory pertenece a la familia de mecanismos que gestionan el **ciclo de vida de los objetos**. Su
papel es comparable al de un **constructor inteligente**, en el sentido de que la *fábrica decide* qué objeto entregar
en función del contexto, parámetros o políticas de negocio.

El Factory ayuda a **separar la intención de creación** (qué quiere el cliente) de la **implementación de la creación
** (cómo se construye realmente). Desde un punto de vista académico, esta separación fomenta los principios de:

- **Abierto/Cerrado (OCP)**: la fábrica puede extenderse para producir nuevos tipos sin modificar el cliente.
- **Inversión de Dependencia (DIP)**: los clientes dependen de **abstracciones** (interfaces) y no de implementaciones
  concretas.
- **Principio de Responsabilidad Única (SRP)**: el cliente no carga con el deber de saber cómo construir los objetos.

---

## 3. Factory en Dart: rasgos distintivos

Dart ofrece varios mecanismos para implementar fábricas. Entre los más relevantes:

### 3.1 Constructores `factory`

Un **constructor `factory`** no siempre crea una nueva instancia; puede retornar una existente o incluso una subclase de
la clase en la que está definido.  
Esto abre la puerta a:

- **Single-instance factories** (variación del Singleton).
- **Delegación de instancias** a subtipos según parámetros.
- **Instanciación controlada** con cachés internas.

Ejemplo básico:

```dart
class Shape {
  Shape._();

  factory Shape(String type) {
    switch (type) {
      case 'circle':
        return Circle();
      case 'square':
        return Square();
      default:
        throw ArgumentError('Tipo no soportado: $type');
    }
  }
}

class Circle extends Shape {
  Circle() : super._();
}

class Square extends Shape {
  Square() : super._();
}
```

Aquí, el cliente no necesita saber cómo se construye un Circle o un Square; basta con pedir un Shape.

---

### 3.2 Métodos estáticos de fábrica

Otra forma frecuente es definir métodos estáticos que devuelven instancias. Esta variante es más explícita y flexible
cuando existen múltiples maneras de construir un mismo objeto.

```dart
class HttpClient {
  HttpClient._();

  static HttpClient createSecure() {
    // configuración con SSL
    return HttpClient._();
  }

  static HttpClient createInsecure() {
    // configuración sin SSL
    return HttpClient._();
  }
}
```

El cliente elige entre `HttpClient.createSecure()` o `HttpClient.createInsecure()` según sus necesidades.

---

### 3.3 Clases fábrica

Una tercera modalidad es diseñar una clase independiente cuya única responsabilidad es generar instancias de cierto
tipo.  
Esto refuerza la cohesión: el producto no sabe nada de cómo fue construido.

```dart
abstract class Button {
  void render();
}

class AndroidButton implements Button {
  @override
  void render() => print('Botón estilo Android');
}

class IOSButton implements Button {
  @override
  void render() => print('Botón estilo iOS');
}

class ButtonFactory {
  static Button create(String platform) {
    if (platform == 'android') return AndroidButton();
    if (platform == 'ios') return IOSButton();
    throw ArgumentError('Plataforma no soportada');
  }
}
```

Uso:

```dart
final button = ButtonFactory.create('ios');
button.render(); // → "Botón estilo iOS"
```

---

#### 4. Clasificación académica de fábricas

Desde la perspectiva de la literatura en POO y patrones de diseño, podemos clasificar las fábricas en varios niveles:

| Nivel               | Característica                                                                          | Ejemplo en Dart                                                      |
|---------------------|-----------------------------------------------------------------------------------------|----------------------------------------------------------------------|
| Factory Method      | Una clase define un método abstracto para crear objetos, que las subclases implementan. | Clase abstracta `UIFactory` con método `createButton()`.             |
| Simple Factory      | Centraliza en una clase la lógica de creación según parámetros.                         | Ejemplo `ButtonFactory` anterior.                                    |
| Factory Constructor | El constructor controla la instancia devuelta.                                          | `factory Shape(...)`.                                                |
| Abstract Factory    | Provee familias de objetos relacionados sin exponer la implementación.                  | Una interfaz `WidgetFactory` que produce `Button`, `TextField`, etc. |

En Dart, los constructores factory y las clases fábricas son los enfoques más idiomáticos y directos.

---

#### 5. Ventajas del Factory

1. **Desacoplamiento**: los clientes no dependen de clases concretas.
2. **Centralización**: lógica de construcción en un único lugar.
3. **Extensibilidad**: se pueden añadir variantes sin modificar el cliente.
4. **Reutilización de instancias**: permite aplicar caché o pooling.
5. **Claridad semántica**: el cliente expresa qué desea, no cómo se logra.

---

#### 6. Desventajas y riesgos

1. **Complejidad añadida**: puede parecer redundante en sistemas pequeños.
2. **Proliferación de fábricas**: un exceso puede generar estructuras innecesarias.
3. **Rastreo indirecto**: más difícil saber qué implementación se está usando si no se documenta bien.
4. **Posible abuso**: usar fábricas para todo puede desviar el diseño de principios más simples (por ejemplo,
   constructores claros).

---

#### 7. Factory y relación con otros patrones

- **Singleton**: una fábrica puede implementar el Singleton retornando siempre la misma instancia.
- **Builder**: si la construcción es muy compleja y progresiva, la fábrica puede delegar en un Builder.
- **Prototype**: una fábrica puede producir objetos clonando prototipos existentes.
- **Abstract Factory**: una generalización que devuelve familias enteras de productos.

---

#### 8. Particularidades de Dart frente a otros lenguajes

| Aspecto             | Dart                                                                      | Java                                       | C#                                          |
|---------------------|---------------------------------------------------------------------------|--------------------------------------------|---------------------------------------------|
| Constructor factory | Integrado en el lenguaje, puede devolver subtipos o instancias existentes | No existe; se simula con métodos estáticos | No existe; se usa con métodos estáticos     |
| Null Safety         | `factory` puede retornar tipos anulables (`Shape?`)                       | Necesita anotaciones (Java 8+)             | Soporte por nullable reference types (C# 8) |
| Privacidad          | Privacidad por archivo/librería (`_`)                                     | `private` por clase                        | `private`/`internal` por ensamblado         |
| Top-level variables | Posible usar instancias `final` como fábricas                             | No soportado                               | No soportado                                |

---

#### 9. Buenas prácticas

1. Usar factory cuando:
    - El constructor necesita retornar un subtipo.
    - La construcción puede reutilizar instancias existentes.
    - Se requiere lógica condicional o validación antes de crear el objeto.
2. Usar fábricas externas (clases) cuando:
    - Se gestionan familias de objetos.
    - La construcción involucra políticas complejas (ejemplo: elegir clase según entorno, configuración, metadatos).
3. Documentar siempre la fábrica: el cliente debe comprender qué retorna.
4. Evitar mezclar roles: la fábrica debe encargarse solo de crear, no de usar el objeto.

---

#### 10. Ejemplo completo: Abstract Factory en Dart

```dart
// Abstracciones
abstract interface class Button {
  void render();
}

abstract interface class TextField {
  void render();
}

abstract interface class WidgetFactory {
  Button createButton();

  TextField createTextField();
}

// Implementaciones concretas
class AndroidButton implements Button {
  @override
  void render() => print('Render Android Button');
}

class AndroidTextField implements TextField {
  @override
  void render() => print('Render Android TextField');
}

class IOSButton implements Button {
  @override
  void render() => print('Render iOS Button');
}

class IOSTextField implements TextField {
  @override
  void render() => print('Render iOS TextField');
}

// Fábricas concretas
class AndroidFactory implements WidgetFactory {
  @override
  Button createButton() => AndroidButton();

  @override
  TextField createTextField() => AndroidTextField();
}

class IOSFactory implements WidgetFactory {
  @override
  Button createButton() => IOSButton();

  @override
  TextField createTextField() => IOSTextField();
}

// Cliente
void main() {
  WidgetFactory factory = AndroidFactory();
  final button = factory.createButton();
  final textField = factory.createTextField();

  button.render(); // "Render Android Button"
  textField.render(); // "Render Android TextField"
}
```

Este ejemplo ilustra la abstracción total de la creación: el cliente no conoce ni depende de implementaciones concretas,
solo de la fábrica abstracta.

---

### Conclusión

El Factory en Dart es una herramienta poderosa para la construcción controlada de objetos.  
Su utilidad se multiplica en sistemas de mediana y gran escala, donde la creación de instancias se vuelve más compleja y
donde la extensibilidad y el bajo acoplamiento son requisitos fundamentales.  
Ya sea mediante constructores factory, métodos estáticos o clases fábrica, Dart ofrece un soporte natural y expresivo
que lo distingue de otros lenguajes.  
El valor académico del patrón radica en cómo separa la intención de creación del mecanismo de construcción, promoviendo
un diseño flexible, mantenible y alineado con los principios SOLID.
