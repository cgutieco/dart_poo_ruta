# Ejercicio Avanzado: Pipeline de Procesamiento de Entidades Genérico

## Objetivo

Diseñar un sistema reutilizable que toma un tipo de dato de entrada (ej: un DTO), lo convierte a un
tipo de dato de
dominio y lo valida. Este pipeline debe ser completamente genérico, permitiendo que funcione con
cualquier tipo de
entidad, convertidor y conjunto de reglas de validación.

---

### Paso 1: Definir una Jerarquía de Modelos

1. Crea una clase abstracta `Modelo` que servirá como base para todas nuestras entidades. Debe tener
   una propiedad `id`
   de tipo `String`.
2. Define una clase `ArticuloDTO` que extienda de `Modelo`. Este será nuestro "Data Transfer
   Object".
    * Añádele las propiedades: `tituloCompleto` (String) y `autorEmail` (String).
3. Define otra clase `ArticuloDominio` que también extienda de `Modelo`. Este será nuestro objeto de
   dominio interno.
    * Añádele las propiedades: `titulo` (String), `subtitulo` (String) y `emailDeAutor` (String).

---

### Paso 2: Crear una Interfaz de `Convertidor` Genérica

1. Define una clase abstracta (que funcionará como una interfaz) llamada `Convertidor<E, S>`.
    * `E` representará el tipo de **E**ntrada.
    * `S` representará el tipo de **S**alida.
2. Esta interfaz debe tener un único método abstracto: `S convertir(E entrada);`.

---

### Paso 3: Implementar un Convertidor Concreto

1. Crea una clase `ConvertidorArticulo` que implemente `Convertidor<ArticuloDTO, ArticuloDominio>`.
2. Implementa el método `convertir`. Su lógica debe tomar un `ArticuloDTO`, separar el
   `tituloCompleto` en `titulo` y
   `subtitulo` (puedes asumir que están separados por un guion "-"), y devolver una nueva instancia
   de
   `ArticuloDominio`.

---

### Paso 4: Crear un `Validador` Genérico y Flexible

1. Define una clase genérica `Validador<T>`.
2. Dentro de ella, declara una lista privada para almacenar las reglas:
   `final List<bool Function(T)> _reglas = [];`.
    * Como ves, estamos usando un tipo de función genérico. Cada función en la lista tomará un
      objeto de tipo `T` y
      devolverá `true` si es válido.
3. Crea un método público `void agregarRegla(bool Function(T) regla)` para añadir funciones a la
   lista `_reglas`.
4. Crea un método `bool esValido(T objeto)` que itere sobre todas las `_reglas`. Debe devolver
   `false` tan pronto como
   una regla falle. Si todas se cumplen, debe devolver `true`.

---

### Paso 5: Construir el `PipelineProcesador` (El Núcleo Genérico)

1. Define la clase principal: `PipelineProcesador<E extends Modelo, S extends Modelo>`.
    * Como puedes ver, utiliza dos parámetros de tipo (`E` y `S`) con restricciones.
2. El constructor debe recibir e inicializar dos dependencias:
    * Un `Convertidor<E, S>`.
    * Un `Validador<S>` (fíjate que la validación se realiza sobre el tipo de **S**alida).
3. Crea un **método genérico** dentro de esta clase, que a su vez retorna un **record**:
   ```dart
   (S? resultado, List<String> errores) procesar(E entidad)
   ```
    * **Lógica del método**:
        1. Usa el `convertidor` para transformar la `entidad` de entrada (tipo `E`) en un objeto de
           salida (tipo `S`).
        2. Usa el `validador` para comprobar si el objeto de salida recién convertido es válido.
        3. Si la validación es exitosa, retorna un record con el `resultado` (el objeto de tipo `S`)
           y una lista de
           `errores` vacía.
        4. Si la validación falla, retorna un record con un `resultado` nulo y una lista de
           `errores` que contenga un
           mensaje descriptivo (ej: `"La validación falló para la entidad con ID: ${entidad.id}"`).

---

### Paso 6: Probar la Implementación Completa

En tu función `main`:

1. Crea una instancia de `ConvertidorArticulo`.
2. Crea una instancia de `Validador<ArticuloDominio>`. Añádele al menos dos reglas de validación
   usando el método
   `agregarRegla`. Por ejemplo:
    * Una regla que verifique que el `emailDeAutor` contenga un símbolo `@`.
    * Una regla que verifique que el `subtitulo` no esté vacío.
3. Crea la instancia del `PipelineProcesador<ArticuloDTO, ArticuloDominio>`, inyectándole el
   convertidor y el validador
   que acabas de crear.
4. Crea dos instancias de `ArticuloDTO`:
    * Una con datos que **cumplan** las reglas tras la conversión (ej:
      `tituloCompleto: "Genéricos en Dart - Una guía", autorEmail: "autor@correo.com"`).
    * Una con datos que **fallen** alguna de las reglas (ej:
      `tituloCompleto: "Título sin subtítulo", autorEmail: "email-invalido"`).
5. Llama al método `procesar` para cada uno de los `ArticuloDTO`.
6. Desestructura los records que recibas como resultado y muestra por consola si el procesamiento
   fue exitoso (
   imprimiendo los datos del `ArticuloDominio` resultante) o si falló (imprimiendo el mensaje de
   error).