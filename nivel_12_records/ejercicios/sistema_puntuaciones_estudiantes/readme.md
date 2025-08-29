# Ejercicio: Sistema de Puntuaciones de Estudiantes

## Objetivo

Crear un sistema simple para gestionar las puntuaciones de estudiantes usando **Records** para representar la
información del estudiante y sus notas.

---

### Paso 1: Definir el Tipo de Dato del Estudiante

1. Usa `typedef` para crear un alias llamado `Estudiante`.
2. Este debe ser un **record nombrado** con:
    * `nombre` (String)
    * `edad` (int)
    * `nota1` (double)
    * `nota2` (double)
    * `nota3` (double)

---

### Paso 2: Crear la Clase de Gestión

1. Define una clase `GestorNotas`.
2. Debe tener una lista privada de estudiantes.

---

### Paso 3: Implementar los Métodos

1. **`agregarEstudiante`**: Recibe un `Estudiante` y lo añade a la lista.

2. **`calcularPromedio`**:
    * Parámetro: nombre del estudiante (String)
    * Retorno: `(String nombre, double? promedio)`
    * Calcula el promedio de las 3 notas o retorna null si no existe

3. **`estudianteConMejorPromedio`**:
    * Sin parámetros
    * Retorno: `(Estudiante? estudiante, double? promedio)`
    * Encuentra al estudiante con el mejor promedio

---

### Paso 4: Probar

En `main`:

1. Crea 3-4 estudiantes con diferentes notas
2. Añádelos al gestor
3. Calcula el promedio de un estudiante específico
4. Encuentra al estudiante con mejor promedio
5. Imprime los resultados