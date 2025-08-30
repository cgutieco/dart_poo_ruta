# Ejercicio: Sistema de Gestión de Cursos Online con Null Safety

## Objetivo

Crear un sistema para gestionar cursos y estudiantes, aplicando todos los conceptos de **null safety** vistos en el
capítulo: tipos anulables, operadores de seguridad e inicialización tardía.

---

### Paso 1: Definir la Clase `Curso`

1. Crea una clase `Curso` con los siguientes atributos:
    * `nombre` (String no anulable)
    * `descripcion` (String no anulable)
    * `instructor` (String anulable) - Un curso puede crearse sin un instructor asignado.
    * `calificacionPromedio` (double anulable) - Un curso nuevo no tiene calificaciones.

2. Implementa un constructor que reciba `nombre` y `descripcion`. Los otros campos deben ser opcionales o inicializarse
   como `null`.

3. Añade un método `obtenerInstructor()` que retorne el nombre del instructor. Usa el operador de coalescencia (`??`)
   para devolver "Instructor no asignado" si `instructor` es `null`.

4. Crea un método `asignarInstructor(String nuevoInstructor)` que asigne un instructor solo si no tiene uno. Usa el
   operador de asignación por coalescencia (`??=`).

---

### Paso 2: Definir la Clase `Estudiante`

1. Define una clase `Estudiante` con las siguientes propiedades:
    * `nombre` (String no anulable)
    * `email` (String no anulable)
    * `cursoInscrito` (Curso anulable) - Un estudiante puede no estar inscrito en ningún curso.
    * `ultimoLogin` (marcado como `late DateTime`) - Se asignará la primera vez que el estudiante inicie sesión.

2. El constructor debe recibir `nombre` y `email`. El `cursoInscrito` debe inicializarse como `null`.

3. Crea un método `registrarLogin()` que asigne la fecha y hora actuales a `ultimoLogin`.

4. Implementa un método `obtenerNombreCurso()` que devuelva el nombre del curso al que está inscrito el estudiante. Usa
   el operador de acceso condicional (`?.`) para acceder al nombre del curso de forma segura y el operador `??` para
   devolver "No inscrito" si `cursoInscrito` es `null`.

---

### Paso 3: Crear la Clase `PlataformaCursos`

1. Define una clase `PlataformaCursos` con:
    * Una lista privada de `Curso`.
    * Una lista privada de `Estudiante`.
    * Un atributo `nombrePlataforma` marcado como `late String`.

2. Implementa un constructor vacío que inicialice las listas.

3. Crea un método `inicializar(String nombre)` que asigne el `nombrePlataforma`. Este método debe ser llamado antes de
   cualquier otra operación.

4. Añade un método `inscribirEstudianteEnCurso(String emailEstudiante, String nombreCurso)`:
    * Busca al estudiante y al curso por sus respectivos identificadores.
    * Si ambos existen, usa el operador de aserción (`!`) para asegurar al compilador que no son nulos y asigna el curso
      encontrado al `cursoInscrito` del estudiante. Lanza una excepción si alguno no se encuentra.

---

### Paso 4: Probar la Implementación

En la función `main`, realiza las siguientes pruebas para verificar el correcto funcionamiento de la `null safety`:

1. **Creación de instancias**:
    * Crea un `Curso` sin instructor.
    * Crea un `Estudiante` que aún no está inscrito en ningún curso.

2. **Uso de `late`**:
    * Crea una instancia de `PlataformaCursos`.
    * Intenta usar un método de la plataforma antes de llamar a `inicializar()` para provocar el error de `late`.
    * Llama a `inicializar()` y comprueba que ahora funciona.

3. **Operadores de Null Safety**:
    * Llama a `obtenerInstructor()` en el curso sin instructor.
    * Usa `asignarInstructor()` para darle uno y vuelve a llamar al método anterior.
    * Llama a `obtenerNombreCurso()` en el estudiante no inscrito.
    * Inscribe al estudiante en un curso usando `inscribirEstudianteEnCurso()` y vuelve a llamar a
      `obtenerNombreCurso()` para ver el cambio.
    * Llama a `registrarLogin()` en el estudiante y luego imprime el valor de `ultimoLogin`.