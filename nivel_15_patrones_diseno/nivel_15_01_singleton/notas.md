# Capítulo 15.1 — *Singleton* en Dart

El patrón **Singleton** persigue garantizar que **exista una única instancia** de una clase durante el ciclo de vida de
la aplicación y que ésta sea **fácilmente accesible** desde cualquier punto del código.  
En los lenguajes orientados a objetos tradicionales su implementación exige cuidar la **creación controlada**, la 
**identidad canónica** y la **gestión de visibilidad**. Dart aporta mecanismos específicos (constructores `factory`,
inicialización *lazy* con `late`, modificadores de clase como `final` y el modelo de 
**librerías/privacidad por archivo**) que simplifican y refuerzan el patrón.

> **Advertencia académica**: el Singleton es útil, pero abusarlo puede degradar la arquitectura hacia estados globales
> difíciles de testar. La recomendación moderna es **preferir inyección de dependencias** y reservar el Singleton para
> recursos intrínsecamente únicos (configuración del proceso, *loggers*, *pools* de conexión, *caches* compartidas).

---

## 1. Propósito, garantías y contexto en Dart

### 1.1 Propósito

- **Unicidad:** exactamente una instancia “viva” por ámbito de ejecución.
- **Acceso global controlado:** un punto canónico para obtener la instancia.
- **Inicialización controlada:** determinística (temprana o *lazy*).

### 1.2 Matices en Dart

- **Modelo de librerías:** lo “privado” se define por prefijo `_` y se **limita a la librería** (archivo o conjunto
  `part of`). Facilita ocultar constructores.
- **`factory` constructor:** permite **devolver una instancia ya existente** en lugar de crear un nuevo objeto, lo cual
  encaja con la unicidad.
- **`late final` estático:** habilita inicialización *lazy* segura con *null safety*.
- **Isolates:** Dart no comparte memoria entre *isolates*; por tanto, el Singleton es **por isolate**, no global a todo
  el proceso.

---

## 2. Requisitos formales del patrón

| Requisito                    | Descripción                                        | Mecanismo idiomático en Dart                                 |
|------------------------------|----------------------------------------------------|--------------------------------------------------------------|
| **Control de creación**      | Nadie debe poder instanciar libremente             | Constructor privado `Nombre._()` dentro de la misma librería |
| **Identidad canónica**       | Todas las solicitudes retornan el **mismo** objeto | `factory` que retorna una **estática**                       |
| **Acceso global**            | Punto único de acceso                              | `factory` o `static getter` (`instance`)                     |
| **Inicialización**           | Temprana o *lazy* según coste/uso                  | Estática inmediata o `late final`                            |
| **No extensible (opcional)** | Evitar subclasificación/implementación             | `final class` (Dart 3.x)                                     |

---

## 3. Implementaciones idiomáticas en Dart

> Los fragmentos son **ilustrativos** y mínimos: muestran la idea sin añadir detalles superfluos.

### 3.1 Singleton con `factory` + almacenamiento estático (clásico, recomendado)

- Constructor **privado** impide `new`.
- `factory` devuelve la instancia estática ya creada (o la crea si procede).
- `final class` evita extensiones e implementaciones (mejora encapsulación).

```dart
final class ConfigService {
  ConfigService._(); // privado a la librería

  static final ConfigService _instance = ConfigService._();

  factory ConfigService() => _instance;

// API pública...
}
```

**Características académicas**

- Unicidad garantizada por clase dentro del isolate.
- Creación temprana (al cargar la clase). Buena para objetos ligeros y muy usados.
- No apto si la construcción es costosa pero rara vez utilizada (ver 3.2).

---

### 3.2 Singleton lazy con `late final` + `instance` (acceso explícito)

- Inicializa bajo demanda la primera vez que se solicita.

```dart
final class Logger {
  Logger._();

  static late final Logger _instance = Logger._();

  static Logger get instance => _instance;

// API pública...
}
```

**Características académicas**

- Inicialización diferida: útil si la creación es costosa.
- El punto de acceso explícito (`Logger.instance`) documenta la intención.

---

### 3.3 Instancia top-level inmutable (simple y directa)

- Se evita el `factory`; se expone una variable global `final`.

```dart

final db = Database._(); // ‘_’ constructor privado, visibilidad de librería

final class Database {
  Database._();
// API pública...
}
```

**Características académicas**

- Ultra simple.
- Orden de inicialización: se crea al cargar la librería.
- Útil en módulos estáticos o adapters que no se burlan en tests.

---

### 3.4 “Singleton const” (caso especial, inmutable y canónico)

- Solo viable si todos los campos son inmutables y el objeto no tiene efectos.

```dart
final class Units {
  const Units._(); // constructor const privado
  static const Units instance = Units._();
}
```

**Características académicas**

- Instancia canónica de compilación.
- No apta para servicios con estado mutable o recursos (E/S, sockets).

---

## 4. Null safety, lazy y semántica de inicialización

| Aspecto                  | Recomendación                                                                                                             |
|--------------------------|---------------------------------------------------------------------------------------------------------------------------|
| `late final`             | Segura y thread-safe bajo el modelo de un solo hilo por isolate. Simplifica lazy initialization.                          |
| Aserciones `!`           | Evitarlas en Singletons; preferir inicialización determinística (`late final`, estáticos) para no depender de aserciones. |
| Ciclos de inicialización | Evitar referencias circulares entre Singletons (A depende de B y B de A). Desacoplar con interfaces o fábricas.           |

---

## 5. Isolates y alcance real del Singleton

- Dart aísla memoria por isolate; cada isolate tiene su propia instancia.
- Si la aplicación crea isolates secundarios (por concurrencia o compute), no comparte el Singleton.
- Para coordinar, usar mensajería entre isolates (puertos) o diseñar un servicio por isolate.

---

## 6. Modificadores de clase (Dart 3.x) y su papel

| Modificador        | Uso en Singleton | Motivo                                                                                           |
|--------------------|------------------|--------------------------------------------------------------------------------------------------|
| `final class`      | ✅ Recomendado    | Impide `extends` e `implements`, preserva el contrato de unicidad y evita subtipos clandestinos. |
| `sealed`           | ⚠️ Situacional   | Restringe extensiones al archivo; menos útil que `final` para Singletons.                        |
| `abstract`         | ❌ No aplica      | Un Singleton no debe ser abstracto.                                                              |
| `interface`/`base` | ➕ Combinables    | Útiles si defines una interfaz y una implementación `final class`.                               |

**Patrón sugerido (testabilidad):**

- Declarar una interfaz (`abstract interface`) y una implementación `final class` singleton.
- Consumidores dependen de la interfaz; la implementación se inyecta (evita acoplamiento y facilita mocks).

---

## 7. Ventajas, riesgos y señales de abuso

### 7.1 Ventajas objetivas

- Compartición de recursos (cachés, pools, configuración).
- Punto único de coordinación (log centralizado).
- Evita duplicados de objetos pesados.

### 7.2 Riesgos y costes

- Estado global oculto: dificulta razonamiento y pruebas.
- Acoplamiento fuerte: los consumidores dependen de un tipo concreto.
- Orden de inicialización: puede introducir fallas sutiles si hay dependencias cruzadas.
- Reuso inter-isolates: no existe; cada isolate replica el Singleton.

### 7.3 Señales de abuso (red flags)

| Señal                                  | Consecuencia                                           |
|----------------------------------------|--------------------------------------------------------|
| Singleton con muchas responsabilidades | God object, violación de SRP, cambios frecuentes.      |
| Acceso global en capas bajas           | Dependencias implícitas, difícil de simular en tests.  |
| Uso para pasar datos temporales        | Anti-patrón; preferir parámetros o contexto explícito. |

---

## 8. Singleton y pruebas (testabilidad)

| Estrategia             | Descripción                                      | Impacto en tests                                    |
|------------------------|--------------------------------------------------|-----------------------------------------------------|
| Interfaz + inyección   | Consumidor recibe `ILog`/`IConfig`               | Permite mocks, aislando la implementación Singleton |
| Proveedor configurable | Top-level `var provider = () => Impl.instance;`  | En tests se sustituye provider por stub             |
| Reseteo controlado     | Método `resetForTest()` solo en entornos de test | Evitar en producción; documentar explícitamente     |

> Nota: hacer `instance` reconfigurable en producción rompe la garantía del patrón; limítalo a fixtures de prueba o al
> contenedor de dependencias.

---

## 9. Comparación breve con Java (enfoque académico)

| Aspecto                   | Dart                                            | Java                                                    |
|---------------------------|-------------------------------------------------|---------------------------------------------------------|
| Privacidad                | Por librería (`_`)                              | Por clase/paquete (`private`, `package`)                |
| Construcción controlada   | `factory` que retorna la estática               | Constructor privado + método `getInstance()`            |
| Inmutabilidad de la clase | `final class` evita `extends`/`implements`      | `final` impide `extends` (Java 17: `sealed` disponible) |
| Lazy seguro               | `late final` inicializa bajo demanda            | Holder idiom o enum singleton                           |
| Concurrencia              | Un isolate por hilo; no hay data races internas | Necesita sincronización (`synchronized`, `volatile`)    |

---

## 10. Criterios de elección (cuándo conviene)

| Situación                | ¿Singleton? | Comentario                                   |
|--------------------------|-------------|----------------------------------------------|
| Logger compartido        | ✅ Sí        | Estado estable, beneficio claro              |
| Configuración de proceso | ✅ Sí        | Lectura frecuente, escritura rara            |
| Cliente HTTP compartido  | ✅ Sí        | Reutiliza conexiones, evita fugas            |
| Repositorio de dominio   | ⚠️ Depende  | Mejor interfaz + DI; Singleton puede acoplar |
| Estado de UI             | ❌ No        | Preferir state management (scoped)           |

---

## 11. Recomendaciones finales (checklist)

1. Privatiza el constructor (`_`) y expón `factory` o `instance`.
2. Usa `final class` para evitar subtipos no deseados.
3. Elige inicialización temprana (estática) o tardía (`late final`) según coste.
4. No mezcles responsabilidades: mantén la API pequeña y cohesiva.
5. Para testabilidad, depende de una interfaz e inyecta la implementación.
6. Documenta que la unicidad es por isolate.
7. Evita side effects en el inicializador estático; maneja errores de construcción explícitamente.

---

## 12. Micro‐ejemplos comparativos (solo lo esencial)

### 12.1 factory clásico

```dart
final class Cache {
  Cache._();

  static final Cache _inst = Cache._();

  factory Cache() => _inst;
}
```

### 12.2 Lazy con late final

```dart
final class Metrics {
  Metrics._();

  static late final Metrics _inst = Metrics._();

  static Metrics get instance => _inst;
}
```

### 12.3 Interfaz + implementación singleton (para DI)

```dart
abstract interface class Clock {
  DateTime now();
}

final class SystemClock implements Clock {
  SystemClock._();

  static final SystemClock _inst = SystemClock._();

  factory SystemClock() => _inst;

  @override
  DateTime now() => DateTime.now();
}
```

---

**Conclusión**

- El patrón Singleton en Dart se implementa de forma natural gracias a los constructores `factory`, la inicialización
  `late final` y el modelo de librerías.
- Usado con moderación y junto a interfaces e inyección de dependencias, aporta claridad, eficiencia y control sobre
  recursos únicos.
- Es clave distinguir cuándo el estado global es realmente necesario (justifica Singleton) y cuándo es solo comodidad
  arquitectónica (mejor resolver con diseño explícito y dependencias declaradas).
