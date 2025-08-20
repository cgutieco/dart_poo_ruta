### Ejercicio: Modelado de una Biblioteca de Libros

**Objetivo:** Crear un sistema de clases para representar libros y préstamos en una biblioteca, aplicando constructores
por defecto, parámetros posicionales, nombrados, requeridos y opcionales, constructores `const`, inicializadores,
constructores nombrados y de redirección, y herencia.

**Requisitos:**

1. **Clase Base `Libro`:**
    * Debe ser una clase inmutable. Todos sus campos serán `final`.
    * Propiedades: `titulo` (String), `autor` (String).
    * Define un constructor `const` con parámetros **nombrados y requeridos**.

2. **Clase Derivada `LibroPrestado`:**
    * Hereda de `Libro`.
    * Propiedades adicionales: `fechaPrestamo` (String), `nombreUsuario` (String).
    * Constructor principal con parámetros **posicionales** para `titulo`, `autor` y `fechaPrestamo`.
      El parámetro `nombreUsuario` debe ser **nombrado y opcional**, con valor por defecto `'Invitado'`.
    * Usa `super` para inicializar los campos heredados.

3. **Constructor Nombrado y de Redirección:**
    * En `LibroPrestado`, crea un constructor nombrado `LibroPrestado.rapido` que recibe solo `titulo` y `autor`.
    * Debe redirigir al constructor principal, asignando `fechaPrestamo` como `'Hoy'` y `nombreUsuario` como
      `'Express'`.

4. **Uso de Inicializadores:**
    * Añade una propiedad `final String codigoPrestamo` a `LibroPrestado`.
    * En el constructor principal, usa una **lista de inicializadores** para asignar a `codigoPrestamo` el valor
      generado por la concatenación de `titulo`, `autor` y `fechaPrestamo` (ej: `'DonQuijote-Cervantes-2024-06-01'`).

**Tarea final:**

En tu función `main`, crea instancias de `LibroPrestado` usando todos los constructores definidos para verificar la
implementación:

* Un libro prestado con usuario personalizado.
* Un libro prestado con usuario por defecto.
* Un libro prestado rápido usando el constructor nombrado.

---

Este ejercicio cubre todos los temas del capítulo 3, excepto los constructores `factory`.