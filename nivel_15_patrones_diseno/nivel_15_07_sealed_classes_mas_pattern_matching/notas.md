# Sealed classes + Pattern Matching en Dart 3.x

## 0. Propósito y panorama general

Este capítulo explica cómo **modelar dominios cerrados** con *sealed classes* y cómo **operar sobre esas jerarquías**
mediante *pattern matching* (patrones) y *switch* exhaustivos. La combinación proporciona tres beneficios clave:

1. **Modelado expresivo**: define un conjunto **finito** y **conocido** de subtipos para una abstracción (p. ej., un
   resultado con éxito o error).
2. **Exhaustividad verificada por el compilador**: todo *switch* sobre una jerarquía *sealed* debe cubrir **todos** los
   casos; si falta uno, el compilador lo detecta.
3. **Código más declarativo**: los patrones permiten **desestructurar** y **filtrar** valores directamente en la rama
   del control de flujo, con menos *boilerplate*.

---

## 1. Sealed classes: definición, propiedades y diseño

**Definición**. Una clase marcada como `sealed` **no puede** ser `extended`, `implemented` ni *mixined* **fuera** de su
propia librería. Dentro de la **misma librería** (el mismo *library unit*), sí puedes declarar los subtipos concretos.
El conjunto de subtipos es, por diseño, **cerrado** y **enumerable** por el compilador.  
Además, una clase `sealed` es **implícitamente `abstract`**: no se puede instanciar directamente; puede, sin embargo, *
*definir constructores** para uso de subclases y **declara `factory`** si procede. No puede combinarse con `abstract` (
sería redundante/contradictorio).

**Objetivo de diseño**. Usar `sealed` cuando quieras expresar una **unión algebraica** (suma de tipos) con variantes que
**no cambiarán** arbitrariamente desde otras bibliotecas. Esta clausura habilita **análisis estático** como el
*exhaustive checking* en `switch`.

**Implicaciones de mantenimiento**. Evolucionar una jerarquía `sealed` suele implicar añadir una nueva variante **dentro
de la misma librería**, lo que provocará **errores de compilación** en todos los `switch` no exhaustivos —un mecanismo
saludable para forzar la actualización consciente del manejo de casos.

### 1.1. Comparativa de modificadores (visión rápida)

| Modificador | ¿Se puede `extend` fuera de la librería? | ¿Se puede `implement` fuera? | ¿Se puede `with`/`on` fuera? | ¿Instanciable? | Propósito                                                         |
|-------------|-----------------------------------------:|-----------------------------:|-----------------------------:|---------------:|-------------------------------------------------------------------|
| *(sin)*     |                                       Sí |                           Sí |                           Sí |             Sí | Sin restricciones                                                 |
| `abstract`  |                                        — |                            — |                            — |         **No** | Tipo no instanciable; puede tener miembros abstractos             |
| `interface` |                                   **No** |                       **Sí** |                            — |          Sí/No | Enfatiza el rol de **interfaz** (no heredadable fuera)            |
| `base`      |                                   **Sí** |                       **No** |                           Sí |          Sí/No | Garantiza **herencia de implementación** (no implementable fuera) |
| `final`     |                                   **No** |                       **No** |                       **No** |          Sí/No | **Hoja**: prohíbe toda subtipificación fuera                      |
| `sealed`    |                                   **No** |                       **No** |                       **No** |         **No** | **Conjunto cerrado** de subtipos **dentro** de la librería        |

> Nota: Subclases de una `final` (dentro de la librería) deben marcarse `base`/`final`/`sealed` para mantener las
> garantías; `sealed` **no** puede combinarse con `abstract` porque ya es abstracta por definición.

---

## 2. Dónde encaja Pattern Matching

Los **patrones** (patterns) son una extensión del lenguaje que permite **hacer coincidir** y **desestructurar** valores
en lugares donde hoy declaras variables, asignas, o seleccionas ramas de control. Se usan en:

- **Declaraciones**: `var (x, y) = punto;`
- **Asignaciones**: `(a, b) = otraPar;`
- **Ramas**: `if (obj case Tipo(:propiedad)) { ... }`
- **`switch` (sentencia y expresión)**: con soporte de **exhaustividad** en tipos sellados, `enum`, `bool` y otros
  dominios finitos.
- **Bucles**: variables de bucle pueden declararse con patrón para desestructurar elementos en iteraciones.

### 2.1. Clases de patrones (catálogo conceptual)

| Categoría                    | Forma conceptual                           | Utilidad principal                                   |
|------------------------------|--------------------------------------------|------------------------------------------------------|
| **Constante**                | `case 0`, `case null`, `case const [1, 2]` | Coincidencia exacta con un literal/constante         |
| **Variable / Identificador** | `case var x`, `case int n`                 | Vincular valores y filtrar por tipo                  |
| **Lógico**                   | `p1                                        |                                                      | p2`, `p1 && p2` | Unir o combinar patrones |
| **Relacional**               | `< 10`, `>= 0`                             | Rangos y comparaciones numéricas                     |
| **`as` (cast)**              | `x as T`                                   | Forzar conversión tipada en medio de la coincidencia |
| **Nulidad**                  | `p?` (null-check), `p!` (null-assert)      | Gestionar anulabilidad durante la coincidencia       |
| **Lista**                    | `[a, b, ...rest]`                          | Desestructurar secuencias por posición               |
| **Mapa**                     | `{'k': v}`                                 | Extraer valores por clave                            |
| **Record**                   | `(x, y)` o `(:lat, :lng)`                  | Trabajo con **records** (tuplas con/sin nombres)     |
| **Objeto**                   | `Tipo(prop: p, otra: q)`                   | Desestructurar por **getters** nombrados             |
| **Comodín**                  | `_`                                        | Ignorar valores (match siempre, descarta)            |

---

## 3. Sinergia: jerarquías `sealed` + `switch` exhaustivo

La capacidad de marcar una jerarquía como `sealed` hace que **el compilador conozca todas las variantes** posibles.
Cuando escribes un `switch` (sentencia o **expresión**), el compilador exige cubrir **cada subtipo** o proporcionar una
rama comodín (`_`). Esto elimina clases enteras de **errores en tiempo de ejecución** (ramas faltantes) y permite
expresiones más **declarativas**.

### 3.1. Ejemplo mínimo (jerarquía cerrada y evaluación)

```dart
// Librería: pago.dart
sealed class ResultadoPago {
  const ResultadoPago();
}

class Exito extends ResultadoPago {
  final String id;

  const Exito(this.id);
}

class ErrorTemporal extends ResultadoPago {
  final Duration reintentarEn;

  const ErrorTemporal(this.reintentarEn);
}

class ErrorFatal implements ResultadoPago {
  final String mensaje;

  const ErrorFatal(this.mensaje);
}

// Uso en otra unidad de la misma librería:
String mensajeUsuario(ResultadoPago r) =>
    switch (r) {
      Exito(id: var id) => 'Confirmado #$id',
      ErrorTemporal(reintentarEn: var d) => 'Intenta en ${d.inSeconds}s',
      ErrorFatal(mensaje: var m) => 'No procesable: $m',
    // Si faltase una rama, el compilador marca error de exhaustividad.
    };
```

**Observa**:

- `ResultadoPago` es `sealed`. Los subtipos (`Exito`, `ErrorTemporal`, `ErrorFatal`) deben declararse **en la misma
  librería**.
- El `switch` es una **expresión** que retorna `String`; cada caso **desestructura** parámetros con **patrones de objeto
  **.
- Si agregas una nueva variante, por ejemplo `RequiereAutenticacion`, todos los `switch` no exhaustivos **fallarán** al
  compilar hasta que agregues su manejo.

---

## 4. Patrones de objeto: desestructuración nominal

Los **patrones de objeto** permiten desestructurar valores por nombre de **getters** (o parámetros con promoción). La
forma general es:

- `Tipo(prop1: subpatrón1, prop2: subpatrón2, ...)`
- Los identificadores de propiedad corresponden a **getters** accesibles en el tipo.

**Ventajas**:

- Evita *casts* y *promotions* manuales.
- Produce código auto-documentado (nombres en el patrón).
- Combinable con patrones de nulidad, relacionales y lógicos.

### 4.1. Guardas (`when`) y composición

Los casos pueden tener **guardas**: `case Patrón when condición:`. Útil para afinar coincidencias sin romper
exhaustividad.

```dart
String clasifica(ResultadoPago r) =>
    switch (r) {
      Exito() => 'ok',
      ErrorTemporal(reintentarEn: var d) when d.inSeconds <= 30 => 'reintento rápido',
      ErrorTemporal() => 'reintento diferido',
      ErrorFatal(mensaje: var m) when m.contains('fraude') => 'bloquear cuenta',
      ErrorFatal() => 'error',
    };
```

La **guarda** no altera el conjunto de variantes requeridas; solo subdivide una rama por condición. Si ninguna guarda se
cumple, la coincidencia sigue fallando y el análisis de exhaustividad continúa aplicándose.

---

## 5. `switch` como **expresión** y como **sentencia**

- **`switch` expresión**: devuelve un **valor**; todas las ramas deben producir el mismo tipo. Sintaxis concisa:
  `=> resultado,` y `,` entre casos.
- **`switch` sentencia**: ejecuta **bloques**; es útil para efectos laterales.
- En ambos, sobre dominios finitos (por ejemplo, jerarquías `sealed`, `enum`, `bool`), el compilador **exige
  exhaustividad** salvo que incluyas `_`.

**Consejos**:

- **Prefiere** `switch` expresión para *mapeos puros* de valores a resultados.
- **Evita** `default` si puedes: perderías la verificación de exhaustividad; usa `_` solo si conscientemente decides
  agrupar casos residuales.

---

## 6. Patrones y nulidad: `?` y `!` dentro de `switch`

Los patrones incorporan operadores de nulidad:

- **Null-check** `p?` — coincide si el valor **no es nulo** y continúa evaluando `p`.
- **Null-assert** `p!` — asume no nulo; si el valor es `null` **lanza**.

Esto sirve para **promover tipos** no anulables *in situ* y mantener `switch` declarativos.

```dart
String formateaNombre((String?, String?) nombre) =>
    switch (nombre) {
    // Promueve a no anulables si no son null:
      (var nombre!, var apellido!) => '$nombre $apellido',
    // Cubre combinaciones con null:
      (var nombre?, _) => nombre,
      (_, var apellido?) => apellido,
      _ => 'Anónimo',
    };
```

---

## 7. Patrón `record` y jerarquías `sealed`: parejas potentes

Cuando una rama produce **múltiples valores** conceptuales, los **records** encajan naturalmente. Puedes devolver un
record desde un `switch` exhaustivo sobre la jerarquía sellada y **desestructurarlo** donde lo consumas.

```dart
// Devuelve datos para la UI a partir del resultado:
({String titulo, String detalle}) vista(ResultadoPago r) =>
    switch (r) {
      Exito(id: var id) => (titulo: 'Pago ok', detalle: '#$id'),
      ErrorTemporal(reintentarEn: var d) => (titulo: 'Espera', detalle: '${d.inSeconds}s'),
      ErrorFatal(mensaje: var m) => (titulo: 'Error', detalle: m),
    };
```

---

## 8. Diseño de librerías selladas (guía práctica)

1. **Una jerarquía por librería**: agrupa tipo `sealed` y variantes en el mismo *library*; puedes dividir en **múltiples
   archivos** con `part`/`part of`, manteniendo un **único** punto de exportación.
2. **Nombres semánticos**: el nombre del tipo `sealed` debe expresar el **concepto** (p. ej., `ResultadoPago`, `Expr`,
   `AuthState`).
3. **Ramas finas, datos claros**: que cada subtipo tenga solo **datos necesarios**; favorece **inmutabilidad** (`final`)
   para simplificar igualdad y patrones.
4. **`switch` sin `_`**: si quieres **alertas** al añadir ramas nuevas, evita `_`; deja que el compilador te fuerce a
   actualizarlas.
5. **API estable**: si prevés ampliar variantes **fuera** de la librería, entonces no uses `sealed`; considera `final`
   en su lugar para cerrar subtipificación externa pero permitiendo extensiones internas controladas.

---

## 9. Errores frecuentes y cómo evitarlos

| Error                                                    | Consecuencia                      | Prevención                                                     |
|----------------------------------------------------------|-----------------------------------|----------------------------------------------------------------|
| Marcar `sealed` y **definir subclases en otra librería** | Error de compilación              | Mantén todas las variantes **en la misma** librería            |
| Añadir `default` en `switch` sobre `sealed`              | Pierdes **exhaustividad**         | Usa ramas explícitas; `_` solo si es una elección consciente   |
| Mezclar `sealed` con `abstract`                          | Invalida el contrato (redundante) | Solo `sealed` (ya es abstracta implícitamente)                 |
| Olvidar **guardas** para subdividir casos                | Lógica duplicada                  | Añade `when` para condiciones refinadas                        |
| Desestructurar getters inexistentes                      | Error de patrón                   | Asegura nombres de **getters** correctos en patrones de objeto |

---

## 10. Comparación concisa con Java

- Java (>=17) tiene **`sealed classes`**, pero **no** posee *pattern matching* tan amplio en **objetos** con
  desestructuración nominal; su *pattern matching* se centra en `instanceof` con *binding*, `switch` sobre tipos/
  `record` (si se usan `record` de Java) y aún evoluciona.
- Dart proporciona **patrones declarativos** en muchas ubicaciones (declaración, asignación, `if-case`, `switch`
  expresión/sentencia) y **exhaustividad** integrada sobre `sealed`, `enum` y dominios finitos, lo que facilita
  construir **ADTs** al estilo de lenguajes funcionales con una sintaxis concisa.

---

## 11. Checklist de dominio (aplícalo en tus proyectos)

1. ¿La abstracción tiene **variantes finitas**? → Declara una **clase `sealed`**.
2. ¿Las variantes contienen **datos propios**? → Define **campos `final`** en cada subtipo.
3. ¿Necesitas mapear variantes a salidas? → Usa **`switch` expresión** con **patrones de objeto**.
4. ¿Casos condicionales dentro de una variante? → Emplea **`when`** y patrones **relacionales**/lógicos.
5. ¿Devuelves múltiples valores? → **Records** en el resultado del `switch`.
6. ¿Planeas añadir variantes en el futuro? → Evita `_` para detectar faltantes al compilar.
7. ¿La jerarquía debe expandirse desde fuera? → No uses `sealed`; valora `final` o `interface` según el caso.

---

## 12. Preguntas de reflexión (para consolidar)

1. ¿Qué criterios te llevan a preferir `sealed` frente a `final` en una API pública?
2. ¿Cuándo una guarda `when` mejora la claridad frente a mover lógica al cuerpo del caso?
3. ¿Qué ventajas ofrece un `switch` **expresión** en presencia de records frente a una sentencia?
4. ¿Cómo equilibras granularidad de variantes y simplicidad del *matching*?

---

## 13. Mini-glosario

- **Jerarquía cerrada**: conjunto finito de subtipos que el compilador conoce.
- **Exhaustividad**: propiedad por la cual un `switch` cubre **todas** las posibilidades del dominio.
- **Patrón de objeto**: coincidencia por **getters** con desestructuración nominal.
- **Guarda (`when`)**: condición adicional que debe cumplirse para que un caso de patrón sea válido.
- **Record**: tipo de valor de Dart con campos por posición y/o nombre, apto para desestructuración.