# Ejercicio: Creando un Repositorio Genérico

## Objetivo

Aplicar los conceptos de **clases genéricas** y **restricciones de tipo** (`extends`) para construir
un `Repositorio`
reutilizable y seguro, capaz de gestionar diferentes tipos de datos (modelos) de forma
estandarizada.

---

### Paso 1: Definir una Interfaz de Entidad

1. Crea una clase abstracta llamada `Entidad`.
2. Esta clase servirá como un "contrato" que cualquier modelo gestionado por nuestro repositorio
   deberá cumplir.
3. Añádele un único atributo final: `id` de tipo `int`.
4. Define un constructor `const` para inicializar el `id`.

---

### Paso 2: Crear Clases de Modelo Concretas

1. Define una clase `Producto` que **extienda** de `Entidad`.
2. Añádele atributos propios, como `nombre` (String) y `precio` (double).
3. Crea su constructor, asegurándote de llamar al constructor de la clase padre (`super`) para
   asignar el `id`.
4. Define una segunda clase, por ejemplo, `Usuario`, que también **extienda** de `Entidad`.
5. Añádele atributos propios, como `nombre` (String) y `email` (String).
6. Crea su constructor de la misma manera que hiciste con `Producto`.

---

### Paso 3: Definir la Clase Genérica `Repositorio<T>`

1. Define una clase llamada `Repositorio`.
2. Conviértela en una clase genérica usando un parámetro de tipo `<T>`.
3. Añade una **restricción de tipo** para que `T` solo pueda ser un tipo que **extienda** de
   `Entidad`. Esto garantiza
   que cualquier objeto en el repositorio tendrá una propiedad `id`.
4. Dentro de la clase, declara una propiedad privada: una lista (`List<T>`) para almacenar los
   ítems. Inicialízala como
   una lista vacía.

---

### Paso 4: Implementar los Métodos del Repositorio

Añade los siguientes métodos a la clase `Repositorio<T>`:

1. **`agregar(T item)`**:
    * **Acción**: Añade un ítem de tipo `T` a la lista interna.

2. **`obtenerTodos()`**:
    * **Retorno**: `List<T>`.
    * **Acción**: Devuelve la lista completa de ítems.

3. **`buscarPorId(int id)`**:
    * **Parámetro**: Un `int` con el `id` del ítem a buscar.
    * **Retorno**: El ítem de tipo `T?` (anulable), que será el objeto encontrado o `null` si no
      existe.
    * **Acción**: Itera sobre la lista y devuelve el primer ítem cuyo `id` coincida con el
      parámetro. Gracias a la
      restricción `T extends Entidad`, tienes la garantía de que cada `item` en la lista tiene una
      propiedad `id`
      accesible.

---

### Paso 5: Probar la Implementación

En la función `main`, realiza las siguientes acciones para verificar que tu código funciona:

1. Crea dos repositorios distintos usando tu clase genérica:
    * Un `Repositorio<Producto>` para gestionar productos.
    * Un `Repositorio<Usuario>` para gestionar usuarios.
2. Crea varias instancias de `Producto` y `Usuario` y añádelas a sus respectivos repositorios usando
   el método
   `agregar`.
3. Utiliza el método `buscarPorId` en el repositorio de productos para encontrar un producto
   específico e imprime su
   nombre.
4. Haz lo mismo con el repositorio de usuarios: busca un usuario por su `id` e imprime su email.
5. **(Opcional)** Intenta crear una instancia `Repositorio<String>`. Observa y comprende por qué el
   analizador de Dart
   muestra un error. Esto te ayudará a consolidar el concepto de las restricciones de tipo.