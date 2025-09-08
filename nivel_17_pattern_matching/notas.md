# Capítulo 17. Pattern Matching (Dart 3.x)

El **pattern matching** (coincidencia de patrones) introducido y consolidado en Dart 3.x constituye una de las mejoras
más potentes del lenguaje en materia de expresividad y seguridad de tipos.  
A nivel conceptual, pattern matching permite **examinar la forma** de un valor —su estructura, tipo y contenido— y 
**extraer** partes de ese valor de manera declarativa y segura. Cuando se combina con otras características de Dart 3.x (
records, sealed classes, `switch` expresiones) se obtiene un conjunto de herramientas que transforman estructuras de
control rutinarias en expresiones concisas, declarativas y verificables por el compilador.

Este capítulo desarrolla, con profundidad académica, los aspectos esenciales del pattern matching en Dart 3.x: *
*desestructuración**, **switch exhaustivo**, **patrones aplicados a jerarquías `sealed`** y el uso de **guard clauses
** (`when`). A lo largo del capítulo se presentarán consideraciones de diseño, reglas semánticas y ejemplos
representativos.

---

## 17.1 Desestructuración

### 17.1.1 Idea general

La **desestructuración** es la capacidad de tomar un valor compuesto (record, lista, objeto, mapa) y extraer sus
componentes en variables locales con una sintaxis directa y declarativa. En lugar de pedir el valor y después indexar o
llamar getters, la desestructuración permite declarar y asignar en una sola operación.

### 17.1.2 Formas de desestructuración en Dart

- **Records**: los records se pueden descomponer por posición o por nombre.
- **Listas**: patrones de lista permiten capturar elementos por posición y usar rest (`...`).
- **Mapas**: extraer por claves.
- **Objetos / patrones de objeto**: desestructurar por nombres de getters (o campos) usando patrones de objeto.
- **Combinaciones anidadas**: se pueden entrelazar patrones (registro dentro de objeto, lista dentro de registro, etc.).

### 17.1.3 Ejemplo — records y desestructuración

```dart
(int, int) coordenadas() => (10, 20);

void main() {
  // Desestructuración posicional directa
  var (x, y) = coordenadas();
  print('x=$x, y=$y'); // x=10, y=20

  // También es posible usar final/var con tipado explícito
  final (int a, int b) = coordenadas();
  print(a + b); // 30
}
```

**Notas**:

- La desestructuración con `var` o `final` vincula nombres locales (`x`, `y`) al contenido del record.
- Es una forma muy útil cuando una función retorna múltiples valores sin necesidad de definir una clase contenedora.

### 17.1.4 Ejemplo — lista y mapa

```dart
void main() {
  // Lista
  var lista = [1, 2, 3, 4];
  if (lista case [var primero, var segundo, ...var resto]) {
    print('primero=$primero, segundo=$segundo, resto=$resto');
  }

  // Mapa
  var mapa = {'id': 42, 'name': 'Alice'};
  if (mapa case {'id': var id, 'name': var nombre}) {
    print('id=$id, nombre=$nombre');
  }
}
```

**Precauciones**: los patrones de lista y mapa son poderosos pero pueden ser más frágiles que los patterns de objeto si
la estructura no está garantizada: diseña el uso de estas formas cuando el dominio las asegure.

---

## 17.2 `switch` exhaustivo

### 17.2.1 Concepto y ventaja

Un `switch` es *exhaustivo* cuando cubre **todas** las variantes posibles de un dominio finito (por ejemplo, un `enum` o
una jerarquía `sealed`). La exhaustividad permite que el compilador **verifique** en tiempo de compilación que no falta
un caso, evitando errores en tiempo de ejecución por ramas no manejadas.

Dart 3.x potencia esto mediante:

- `switch` expresiones (devuelven un valor).
- Comprobación de exhaustividad para dominios cerrados.
- Patrones en los `case` que permiten desestructurar y filtrar a la vez.

### 17.2.2 `switch` expresión y sentencia

- **Switch expresión**: conciso, ideal para mapeos puros: `=>` o `,` finales.
- **Switch sentencia**: útil cuando hay efectos secundarios.

### 17.2.3 Ejemplo — `enum` con `switch` expresión

```dart
enum Estado { inicial, cargando, listo, error }

String etiqueta(Estado e) =>
    switch (e) {
      Estado.inicial => 'Esperando',
      Estado.cargando => 'Cargando...',
      Estado.listo => 'Listo',
      Estado.error => 'Error',
    };
```

**Recomendación**: evita usar `_` o `default` sobre enums si quieres que el compilador te obligue a actualizar todos los
`switch` cuando el enum cambie.

---

## 17.3 Patrones con `sealed` (jerarquías cerradas)

### 17.3.1 Por qué `sealed` + pattern matching es potente

Al declarar una jerarquía como `sealed`, el autor establece que **todas** las subclases válidas están definidas en la
misma librería. El compilador tiene esta información y **puede**:

- Verificar exhaustividad en `switch`.
- Permitir patrones de objeto que desestructuren subtipos con seguridad.
- Indicar en compilación si se ha olvidado manejar algún subtipo.

Esta combinación hace de Dart 3.x un lenguaje apto para modelar **árboles de sintaxis**, **resultados algebraicos** (
`Either`, `Result`), **estados** y otros ADTs (algebraic data types) con garantías estáticas.

### 17.3.2 Ejemplo — AST simple con `sealed` y `switch`

```dart
sealed class Expr {
  const Expr();
}

final class Const extends Expr {
  final int value;

  const Const(this.value);
}

final class Add extends Expr {
  final Expr left;
  final Expr right;

  const Add(this.left, this.right);
}

final class Mul extends Expr {
  final Expr left;
  final Expr right;

  const Mul(this.left, this.right);
}

int eval(Expr e) =>
    switch (e) {
      Const(value: var v) => v,
      Add(left: var l, right: var r) => eval(l) + eval(r),
      Mul(left: var l, right: var r) => eval(l) * eval(r),
    };
```

**Comentarios de diseño**:

- Cada `case` usa **patrones de objeto** (`Tipo(prop: var x)`) para extraer campos y operar localmente.
- Si mañana añadimos `Div` a la jerarquía `Expr`, el compilador marcará como no exhaustivos todos los `switch` sobre
  `Expr` que no contemplen `Div` — una ayuda valiosa en mantenimiento.

### 17.3.3 Desestructuración nominal

Los patrones de objeto desestructuran empleando los **nombres de getters** o parámetros nombrados del tipo. No hacen
*reflection*, sino que el compilador valida que esos getters existan y sean accesibles.

---

## 17.4 Guard clauses (`when`) y refinamiento de coincidencias

### 17.4.1 Propósito de las guardas

Una **guarda** (guard clause) permite añadir una condición booleana adicional a una rama de patrón. Se usa cuando,
además de la estructura del valor, interesa restringir la coincidencia por alguna propiedad dinámica.

Sintaxis: `case Patrón when condición => ...`

### 17.4.2 Ejemplo — guardas sobre `sealed`

```dart
sealed class Resultado {
  const Resultado();
}

final class Exito extends Resultado {
  final String id;

  const Exito(this.id);
}

final class ErrorTemporal extends Resultado {
  final Duration reintentarEn;

  const ErrorTemporal(this.reintentarEn);
}

final class ErrorFatal extends Resultado {
  final String mensaje;

  const ErrorFatal(this.mensaje);
}

String mensajeUsuario(Resultado r) =>
    switch (r) {
      Exito(id: var id) => 'Confirmado #$id',
      ErrorTemporal(reintentarEn: var d) when d.inSeconds <= 30 =>
      'Intenta en ${d.inSeconds}s (reintento rápido)',
      ErrorTemporal() => 'Intenta más tarde',
      ErrorFatal(mensaje: var m) when m.contains('fraude') =>
      'Atención: posible fraude - $m',
      ErrorFatal(mensaje: var m) => 'Error crítico: $m',
    };
```

**Notas**:

- La guarda (`when d.inSeconds <= 30`) refina el patrón `ErrorTemporal`.
- Si la guarda falla, se prueba la siguiente rama; las guardas no rompen la verificación de exhaustividad (el `switch`
  sigue requiriendo cubrir todos los subtipos).

### 17.4.3 Buenas prácticas con guardas

- Mantén las guardas **simples** y con propósito claro (rango, bandera, condición ligera).
- Si la guarda encierra lógica compleja, delega a una función con nombre para mejorar legibilidad y testabilidad.
- No uses guardas para replicar lógica que debería residir en la propia clase (considera mover la condición a un método
  de la clase).

---

## 17.5 Patrones compuestos y combinadores lógicos

### 17.5.1 Alternativas y conjunciones

Los patrones pueden combinarse:

- **OR** (alternativa): `pat1 || pat2` — coincide si uno de los dos patrones lo hace.
- **AND** (conjunción): `pat1 && pat2` — requiere que ambos patrones coincidan.
- **Negación** no existe como patrón primario (evítala); en su lugar usa guardas.

### 17.5.2 Uso prudente

Los combinadores amplían poder expresivo pero pueden complicar el razonamiento local. Prefiere patrones sencillos y
explícitos o fragmenta en ramas separadas cuando sea necesario.

---

## 17.6 `if-case` y patrones refutables

### 17.6.1 `if (x case pattern)`

Dart permite usar patrones en expresiones condicionales:

```dart
void main() {
  var maybe = (1, 2);
  if (maybe case (var a, var b)) {
    print('a=$a, b=$b');
  }
}
```

---

### 17.6.2 Refutable vs irrefutable

- **Irrefutables:** patrones que siempre coinciden (por ejemplo, `var x`). Se usan en declaraciones/desestructuración.
- **Refutables:** patrones que pueden fallar (por ejemplo, `Const(value: var v)`) y que se emplean en if-case, switch,
  case y en guard contexts.

---

### 17.7 Alcance de variables ligadas por patrones

- Las variables introducidas por un patrón (p. ej., `var v` en `Const(value: var v)`) solo existen dentro del alcance de
  la rama donde el patrón coincide.
- No hay leak de bindings: cada rama tiene su propio espacio de nombres para las variables introducidas por el patrón.

---

### 17.8 Errores comunes y trampas conceptuales

- Confiar en `default`/_ y perder exhaustividad: usar `_` evita la verificación del compilador — úsalo solo cuando sea
  deliberado.
- Patrones frágiles sobre estructuras no garantizadas: no uses patrones de lista/mapa cuando la entrada pueda tener
  forma arbitraria sin comprobaciones previas.
- Guardas complejas en el switch: si la condición es compleja, mueve a función nombrada para testearla.
- Confundir `case` con `is`: `case` intenta desestructurar además de testar tipo; `is` solo prueba el tipo.

---

### 17.9 Diseño y ergonomía: cuándo usar pattern matching

- Transformaciones puras (mapeos de dominio a presentación): switch expresiones + records devuelven pipelines limpias.
- Evaluación de árboles (AST, expresiones): sealed + patterns ofrecen implementación tersa y segura.
- Parsing y deserialización: patrones de mapa y lista permiten escribir parsers legibles.
- Control de errores: Result/Either modelado con sealed y pattern matching facilita manejo claro de casos.

> Si el dominio es abierto o las variantes son heterogéneas y evolucionarán externamente, reconsidera sealed y patrones
> exhaustivos; la seguridad está en cerrar el dominio donde sea apropiado.

---

### 17.10 Checklist práctico

- ¿El dominio es finito y conocido? → considera sealed o enum.
- ¿Necesitas extraer componentes de estructuras complejas? → usa desestructuración.
- ¿Esperas que el compilador te ayude a mantener casos al añadir variantes? → evita `_` en switch.
- ¿Necesitas filtrar por condiciones dinámicas? → usa `when` con guardas simples y delega lógica compleja a funciones
  auxiliares.
- ¿Quieres código declarativo y fácil de testear? → prefiere switch expresiones + records como resultado.

---

### Conclusión

El pattern matching en Dart 3.x aporta a la POO una capa declarativa y tipada que mejora la expresividad, reduce el
error humano y facilita el mantenimiento.  
Al combinar desestructuración, switch exhaustivo, sealed classes y guard clauses se pueden modelar dominios complejos
con código conciso, seguro y fácilmente verificable por el compilador.

En la práctica:

- Usa desestructuración cuando necesites extraer valores compuestos.
- Confía en sealed para dominios cerrados y en switch expresiones para mapeos puros.
- Emplea guardas para condiciones simples; si se complican, extrae lógica a funciones.

Dominar estas herramientas te permitirá escribir en Dart código que sea a la vez expresivo y robusto, reduciendo
considerablemente errores y boilerplate en tus proyectos.