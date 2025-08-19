# Capítulo 19. Tipos Especiales en Dart

Dart es un lenguaje de tipado estático y seguro, pero también ofrece **tipos especiales** que cumplen roles
fundamentales en su sistema de tipos. Estos tipos no son simples utilidades: representan *contratos semánticos* que
afectan cómo se escriben, leen y verifican los programas.

En este capítulo profundizamos en los tipos más particulares de Dart:

- `Object`
- `Object?`
- `dynamic`
- `Never`
- `void`

Asimismo, analizaremos las diferencias entre `dynamic` y `Object?`, y el rol de `Never` en la definición de contratos.

---

## 19.1 `Object`: la raíz de la jerarquía

En Dart, **todas las clases heredan de `Object`**, explícita o implícitamente.  
Esto significa que cualquier valor que no sea nulo tiene al menos la interfaz de `Object`, que incluye métodos como:

- `toString()`
- `hashCode`
- `==` (operador de igualdad)

Características clave:

- **Supertipo universal no nulo**: cualquier valor no nulo es un `Object`.
- **Seguridad de tipo**: si algo es `Object`, solo puede usarse a través de los métodos definidos en `Object`.
- **Uso común**: en colecciones heterogéneas que aceptan cualquier tipo no nulo.

Ejemplo:

```dart
void procesar(Object valor) {
  print(valor.toString());
}
```

Aquí, `procesar` acepta cualquier valor no nulo, pero no podrá invocar métodos específicos de un subtipo (por ejemplo,
`valor.length`) sin un *cast*.

---

## 19.2 `Object?`: supertipo universal incluyendo `null`

`Object?` es la versión **anulable** de `Object`. Representa el conjunto de todos los valores posibles en Dart,
incluyendo `null`.

Características:

- Es el **tipo más general de todos**.
- Puede almacenar cualquier valor, incluyendo valores nulos.
- Requiere comprobación de nulidad antes de llamar métodos.

Ejemplo:

```dart
void mostrar(Object? valor) {
  if (valor != null) {
    print(valor.toString());
  } else {
    print('Es null');
  }
}
```

---

## 19.3 `dynamic`: el tipo dinámico

`dynamic` representa la **desactivación del sistema de tipos en tiempo de compilación**.  
Con `dynamic`, el compilador permite cualquier operación sobre el valor, difiriendo la verificación al tiempo de
ejecución.

Características:

- **Sin comprobación estática**: cualquier llamada a métodos o propiedades se considera válida.
- **Mayor riesgo**: si el método no existe en el valor en tiempo de ejecución, ocurre un error.
- **Uso común**: interoperabilidad con código flexible (ej. datos JSON, APIs externas).

Ejemplo:

```dart
void imprimir(dynamic valor) {
  print(valor.algoInexistente()); // Compila, pero puede fallar en runtime
}
```

---

## 19.4 Diferencias entre `dynamic` y `Object?`

Aunque `dynamic` y `Object?` pueden parecer similares (pues ambos aceptan cualquier valor), hay diferencias *
*fundamentales**:

| Aspecto                  | `Object?`                               | `dynamic`                                  |
|--------------------------|-----------------------------------------|--------------------------------------------|
| Seguridad en compilación | Verifica métodos definidos en `Object`. | No hay verificación: todo se permite.      |
| Acceso a miembros        | Solo miembros de `Object` sin *cast*.   | Se pueden invocar métodos inexistentes.    |
| Uso recomendado          | Contenedor seguro y genérico.           | Situaciones de tipado flexible o dinámico. |
| Errores                  | Detectados en compilación.              | Detectados en ejecución (runtime error).   |

Ejemplo ilustrativo:

```dart
void main() {
  Object? a = 'texto';
  // a.length; // Error en compilación: Object? no define length.

  dynamic b = 'texto';
  print(b.length); // Compila, pero puede fallar si en runtime no hay length.
}
```

**Conclusión**:

- Usa `Object?` cuando quieras **generalidad segura**.
- Usa `dynamic` solo cuando la flexibilidad sea necesaria y aceptes el riesgo.

---

## 19.5 `Never`: el tipo imposible

`Never` es un tipo especial que representa un valor que **nunca ocurre**.  
Se usa en situaciones donde una función **no puede devolver nada porque nunca termina normalmente**.

Características:

- **Subtipo de todos los tipos**: `Never` puede ser asignado a cualquier variable.
- **Ningún valor puede ser de tipo `Never`**.
- Se emplea en funciones que lanzan excepciones o que no retornan (loops infinitos).

Ejemplo:

```dart
Never lanzarError(String msg) {
  throw Exception(msg);
}
```

Aquí, la función promete que nunca retornará un valor válido. Esto ayuda al compilador a razonar sobre el flujo de
control.

**Contratos con `Never`**:

- Señala al compilador y al lector humano que esa función no debe tener un retorno normal.
- Mejora la *exhaustividad* en `switch` exhaustivos: si un `case` devuelve `Never`, el compilador entiende que esa rama
  no continúa.

---

## 19.6 `void`: ausencia de valor útil

`void` indica que una función **no devuelve un valor significativo**. A diferencia de `Never`, la función con `void` sí
termina, pero su resultado debe ser ignorado.

Ejemplo:

```dart
void saludar(String nombre) {
  print('Hola $nombre');
}
```

Diferencias respecto a `Never`:

- `void`: la función completa su ejecución y retorna implícitamente `null` (aunque no debe usarse).
- `Never`: la función nunca retorna, su ejecución es *inaccesible*.

---

## 19.7 Buenas prácticas con tipos especiales

- Prefiere **`Object` o `Object?`** para colecciones genéricas seguras.
- Usa **`dynamic`** solo como último recurso (interoperabilidad, datos dinámicos).
- Aplica **`Never`** para contratos en funciones que no retornan, mejorando la claridad.
- Emplea **`void`** para procedimientos, no para funciones que deban producir valores.

---

## Conclusión

Los **tipos especiales en Dart** son piezas clave para comprender el sistema de tipos y sus garantías:

- `Object` → supertipo universal no nulo.
- `Object?` → supertipo universal que incluye `null`.
- `dynamic` → desactiva el chequeo de tipos, útil pero riesgoso.
- `Never` → indica imposibilidad de retorno, clave en contratos de control.
- `void` → expresa la ausencia de valor útil en funciones.

Dominar estas sutilezas permite escribir programas más robustos, seguros y expresivos en Dart 3.x.
