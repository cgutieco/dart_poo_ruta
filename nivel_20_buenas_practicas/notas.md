# Capítulo 20. Buenas Prácticas y Estilo — Introducción a cada tema

Este capítulo actúa como **mapa introductorio** de buenas prácticas y convenciones para proyectos Dart (y Flutter).  
Cada subtema se presenta aquí como una **introducción académica** —suficiente para entender la intención, costes y
reglas básicas— y servirá como punto de partida para capítulos posteriores donde profundizarás con ejemplos, ejercicios
y casos reales.

---

## 20.1 Nomenclatura en Dart — Principios y convenciones

La **nomenclatura** es la primera herramienta de comunicación en código: nombres claros reducen la fricción cognitiva y
evitan ambigüedades. En Dart hay convenciones bien establecidas (ver *Effective Dart*) que conviene adoptar por
coherencia con la comunidad y las herramientas.

Principios clave:

- **Consistencia**: aplica la misma convención en todo el proyecto (nombres de archivos, clases, métodos, constantes).
- **Legibilidad**: el nombre debe expresar intención; un método es un verbo, una clase es un sustantivo.
- **Convenciones del lenguaje**:
    - **Tipos** (clases, enums, typedefs, mixins): `UpperCamelCase` (`UserRepository`, `HttpClient`).
    - **Funciones, variables, parámetros, campos no constantes**: `lowerCamelCase` (`fetchUser`, `maxRetries`).
    - **Nombres de paquetes, librerías y rutas**: `snake_case` o `lowercase_with_underscores` (`my_package`,
      `src/utils.dart`).
    - **Constantes** (const/final inmutables): `lowerCamelCase` en Dart (no SCREAMING_SNAKE_CASE).
    - **Privacidad**: prefija con `_` para miembros privados de librería (`_internalCounter`).
    - **Acrónimos**: no uses mayúsculas completas en acrónimos —prefiere `HttpRequest` en lugar de `HTTPRequest`.
    - **Mixins**: normalmente terminan con `Mixin` para clarificar intención (`JsonSerializableMixin`).

Consecuencias prácticas:

- Herramientas (formatters, linters) funcionan mejor si sigues las convenciones.
- Nuevos colaboradores entienden el proyecto más rápido.
- Facilita la búsqueda y categorización del código.

---

## 20.2 Organización en paquetes y librerías — Estructura y fronteras

La correcta **organización de un paquete** define la mantenibilidad, el alcance de la API pública y la facilidad para
publicar/consumir código.

Reglas y recomendaciones (introducción):

- **Estructura típica de un paquete Dart**:
    - `pubspec.yaml` — metadatos, versiones, dependencias.
    - `lib/` — API pública; archivos exportados desde aquí son la interfaz del paquete.
    - `lib/src/` — implementación privada; **no exportar directamente** los archivos de `src`.
    - `bin/` — ejecutables, si aplica.
    - `example/` — ejemplos de uso.
    - `test/` — pruebas unitarias e integración.
    - `tool/`, `benchmark/`, `docs/` — según necesidades.
- **Exponer API pública explícitamente**: crea `lib/my_package.dart` que `export`e los símbolos que quieras publicar;
  deja el resto en `lib/src/` para ocultarlo.
- **Imports**:
    - Dentro de `lib/` usa `package:my_package/...` para evitar rutas relativas frágiles.
    - Evita mezclar imports relativos y `package:` en el mismo archivo para prevenir duplicación de tipos.
- **Separación por responsabilidades**: cuando un paquete crece, considera dividirlo en varios paquetes (micro-paquetes)
  con límites claros entre responsabilidades.
- **Versionado semántico**: modifica la API pública siguiendo SemVer (mayor/minor/patch) y documenta breaking changes en
  el CHANGELOG.

Efectos a medio y largo plazo:

- Facilita pruebas y CI/CD.
- Mejora reusabilidad por otros proyectos.
- Controla el alcance del breaking change y la compatibilidad.

---

## 20.3 Uso de `part` y `part of` — cuándo y por qué

`part`/`part of` permiten **dividir una sola librería** en varios archivos que comparten el mismo espacio de nombres y,
crucialmente, acceso a miembros privados entre sí. Es una herramienta poderosa pero con costes semánticos.

Introducción práctica:

- **Qué hacen**:
    - `library` (o archivo principal) declara `part 'src/fragment.dart';`.
    - El archivo `fragment.dart` declara `part of 'nombre_de_libreria.dart';`.
    - Todas las `part`s forman una **única unidad de compilación**: privadas (`_miembro`) son compartidas.
- **Cuándo usar**:
    - Dividir un archivo muy largo que conceptualmente pertenece a una misma librería y necesita acceder a miembros
      privados.
    - Generación de código (ej.: `freezed` o `built_value`) donde el archivo generado es `part` del archivo de
      definición.
- **Cuándo evitar**:
    - Para construir APIs públicas separadas: prefieres múltiples librerías/ficheros con `export` en `lib/`.
    - Para ocultar implementación: mejor usar `lib/src/` y mantener interfaces limpias en `lib/`.

Ventajas:

- Permite compartir privados sin necesidad de exposiciones forzadas.
- Útil cuando el diseño conceptual es una sola librería grande (ej.: AST con muchos nodos relacionados).

Riesgos y costes:

- Aumenta el acoplamiento entre archivos; cambios en uno afectan a todo el conjunto.
- Dificulta la reutilización parcial y la navegación del código por nuevos desarrolladores.
- Lenguaje y herramientas asumen que `part`s son una sola unidad —menos modularidad.

Ejemplo mínimo de `part`/`part of`:

```dart
// lib/my_lib.dart
library my_lib;

part 'src/_helpers.dart';

void publicApi() {
  _helper(); // accede a función privada en el part
}
```

```dart
// lib/src/_helpers.dart
part of my_lib;

void _helper() {
  print('ayuda privada');
}
```

---

## 20.4 Principios SOLID aplicados a Dart — Guía introductoria

Los principios SOLID son un conjunto de reglas de diseño que aumentan la modularidad y la mantenibilidad. Aquí los vemos
aplicados a las idiomáticas de Dart:

1. **S — Single Responsibility Principle (SRP)**
    - Cada clase debe tener una única responsabilidad o razón para cambiar.
    - En Dart: pequeñas clases inmutables, servicios concretos, separar lógica de presentación en Flutter (widgets y
      controllers).
2. **O — Open/Closed Principle (OCP)**
    - El código debe ser **abierto para extensión** pero cerrado para modificación.
    - En Dart: usar abstracciones (`abstract class`, interfaces implícitas) y `factory`/`strategy` para añadir
      comportamientos sin modificar la clase original.
3. **L — Liskov Substitution Principle (LSP)**
    - Subtipos deben poder sustituir a su supertipo sin romper la lógica.
    - En Dart: cuida nulabilidad y contratos; evita romper expectativas de firmas y comportamiento al implementar
      `implements` o `extends`.
4. **I — Interface Segregation Principle (ISP)**
    - Prefiere interfaces pequeñas y cohesivas sobre grandes "mega-interfaces".
    - En Dart: aprovecha interfaces implícitas y classes abstractas para definir contratos específicos (no obligues a
      implementar métodos irrelevantes).
5. **D — Dependency Inversion Principle (DIP)**
    - Depender de abstracciones, no de concreciones.
    - En Dart: inyecta dependencias por constructor, define `abstract` interfaces para servicios, usa contenedores de
      dependencia en entornos grandes (sin introducir acoplamientos globales innecesarios).

Observaciones idiomáticas:

- **Interfaces implícitas** (cualquier clase puede actuar como interfaz) facilita aplicar ISP y DIP.
- **Mixins** y composición son frecuentes en Dart: permiten reutilizar comportamiento sin herencia múltiple.
- **Sealed classes** ayudan a mantener contratos exhaustivos (útil para OCP y LSP en dominios cerrados).

---

## 20.5 Testing de clases y objetos — Principios introductorios

Las pruebas son la primera línea de defensa frente a regresiones. En Dart, el ecosistema de testing es maduro; la *
*estrategia** de pruebas debe alinearse con la arquitectura y el uso de dependencias.

Pilares básicos:

- **Tipos de pruebas**:
    - **Unitarias**: prueban unidades pequeñas (métodos, clases aisladas).
    - **De integración**: prueban la colaboración entre componentes (repositorios + DB en memoria).
    - **End-to-end / UI (Flutter)**: pruebas completas que simulan la aplicación.
- **Herramientas principales**:
    - `package:test` para pruebas Dart puras.
    - `mockito` / `mocktail` para mocks y dobles de prueba.
    - `flutter_test` y `golden tests` para Flutter.
- **Buenas prácticas de diseño para testabilidad**:
    - **Inyección de dependencias**: facilita sustituir implementaciones por mocks.
    - **Evitar Singletons globales** o proveer mecanismos para reemplazarlos en tests.
    - **Clases pequeñas y puras**: funciones sin efectos secundarios son fáciles de probar.
    - **Arrange–Act–Assert**: patrón para estructurar cada test.
    - **Uso de setUp/tearDown** para preparar y limpiar contextos repetitivos.
- **Asíncrono**: testa `Future`/`Stream` con `async`/`await` y `expectLater` cuando sea necesario.
- **Cobertura y CI**:
    - Ejecuta pruebas en integración continua.
    - Mide cobertura (LCOV) y prioriza tests significativos sobre métricas absolutas.

Ejemplo mínimo de test unitario (estructura):

```dart
// test/calculadora_test.dart
import 'package:test/test.dart';
import 'package:mi_paquete/calculadora.dart';

void main() {
  group('Calculadora', () {
    test('suma dos números', () {
      final c = Calculadora();
      expect(c.sum(2, 3), equals(5));
    });
  });
}
```

---

## Conclusión — por qué es importante empezar por estas bases

Estas introducciones marcan las **decisiones arquitectónicas** que condicionarán el resto del proyecto: desde cómo
nombrar cosas hasta cómo exponer APIs, dividir código y asegurar calidad mediante pruebas. Adoptar convenciones de
nomenclatura y organización, entender cuándo usar `part/part of`, aplicar SOLID y diseñar para testabilidad reduce la
fricción del crecimiento del código y facilita el trabajo en equipo.

En las próximas secciones profundizarás en cada tema (nomenclatura detallada con ejemplos, estructuras de paquetes
reales, patrones alternativos a `part`, guías avanzadas SOLID en Dart y baterías de tests con buenas prácticas y
anti-patrones).  