# Ejercicio: Análisis de Datos de Transacciones con Records

## Objetivo

Utilizar **Records** para procesar y analizar una lista de transacciones financieras. Este ejercicio se centrará en la
transformación, filtrado y agregación de datos, destacando cómo los records pueden simplificar estas tareas.

---

### Paso 1: Definir el Tipo de Dato de la Transacción

1. Usa `typedef` para crear un alias de tipo llamado `Transaccion`.
2. Este alias debe representar un **record nombrado** con los siguientes campos:
    * `id` (de tipo `int`)
    * `descripcion` (de tipo `String`)
    * `monto` (de tipo `double`)
    * `categoria` (de tipo `String`)

---

### Paso 2: Crear la Clase de Análisis

1. Define una clase llamada `AnalizadorTransacciones`.
2. La clase debe tener un constructor que acepte una lista de transacciones (`List<Transaccion>`) y la almacene en una
   propiedad privada.

---

### Paso 3: Implementar la Lógica de Análisis

Añade los siguientes métodos a la clase `AnalizadorTransacciones`:

1. **`calcularTotalPorCategoria`**:
    * **Parámetro**: Un `String` con el nombre de la categoría.
    * **Retorno**: Un `double` que representa la suma total de los montos para esa categoría.
    * **Acción**: Filtra las transacciones por la categoría proporcionada y suma sus montos.

2. **`encontrarTransaccionMasAlta`**:
    * **Parámetros**: Ninguno.
    * **Retorno**: Un **record nombrado** `(Transaccion? transaccion, double? montoMaximo)`.
        * `transaccion` será la `Transaccion` con el monto más alto.
        * `montoMaximo` será el valor de ese monto.
        * Ambos serán `null` si la lista de transacciones está vacía.
    * **Acción**: Itera sobre la lista para encontrar la transacción con el mayor `monto`.

3. **`resumenDeCategorias`**:
    * **Parámetros**: Ninguno.
    * **Retorno**: Un `Map<String, (int cantidad, double total)>`.
        * La clave del mapa será el nombre de la categoría (`String`).
        * El valor será un **record nombrado** que contiene:
            * `cantidad`: el número de transacciones en esa categoría.
            * `total`: la suma de los montos para esa categoría.
    * **Acción**: Agrupa todas las transacciones por categoría y, para cada una, calcula cuántas transacciones hay y
      cuál es su monto total.

---

### Paso 4: Probar la Implementación

En la función `main`, realiza las siguientes acciones para verificar tu código:

1. Crea una lista con al menos cinco `Transaccion` de diferentes categorías (ej: "Comida", "Transporte", "Ocio").
2. Crea una instancia de `AnalizadorTransacciones` pasándole la lista.
3. Calcula e imprime el gasto total en la categoría "Comida".
4. Encuentra la transacción más cara. Desestructura el record retornado para imprimir sus detalles y maneja el caso de
   que la lista esté vacía.
5. Genera el resumen de categorías. Itera sobre el mapa resultante e imprime un informe claro para cada categoría,
   mostrando su nombre, la cantidad de transacciones y el monto total.