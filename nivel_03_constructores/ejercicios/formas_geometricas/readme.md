### Ejercicio Final: Creador de Formas Geométricas

**Objetivo:** Integrar múltiples conceptos de constructores de Dart (`factory`, `const`, nombrados, `super`, parámetros) para crear un sistema flexible y optimizado de creación de objetos.

**Requisitos:**

1.  **Clase Base Abstracta `Figura`:**
    *   Crea una clase `abstract const` llamada `Figura`.
    *   Debe tener un campo `final String color`.
    *   Define un constructor `const` que use un parámetro nombrado y requerido para inicializar el `color`.
    *   Define un método abstracto `double calcularArea()`.

2.  **Clases Derivadas `Circulo` y `Cuadrado`:**
    *   Crea dos clases, `Circulo` y `Cuadrado`, que hereden de `Figura`.
    *   `Circulo` debe tener un campo `final double radio`.
    *   `Cuadrado` debe tener un campo `final double lado`.
    *   Ambas clases deben tener un constructor `const` que inicialice sus propios campos y llame al constructor de la superclase (`super`) para inicializar el `color`.
    *   Implementa el método `calcularArea()` en cada clase.

3.  **Constructor Nombrado de Redirección (en `Cuadrado`):**
    *   Añade un constructor nombrado `const Cuadrado.desdeArea({required double area, required String color})` que calcule el `lado` a partir del `area` y redirija al constructor principal.

4.  **Constructor `factory` en `Figura`:**
    *   Añade un constructor `factory` a la clase `Figura` llamado `Figura.crear`.
    *   Este constructor debe aceptar dos parámetros nombrados y requeridos: `String tipo` y `double medida`. Un tercer parámetro nombrado opcional `String color` debe tener el valor por defecto `'negro'`.
    *   Según el `tipo` (`'circulo'` o `'cuadrado'`), debe devolver una instancia `const` de la subclase correspondiente, usando la `medida` como radio o lado.
    *   Si el `tipo` no es válido, debe lanzar una `Exception`.

**Tarea final:**

En tu función `main`, utiliza el constructor `factory` `Figura.crear` para:

1.  Crear un círculo de radio 10 y color 'rojo'.
2.  Crear un cuadrado de lado 5.
3.  Crear dos círculos idénticos (mismo radio y color) y verificar con `identical()` que son la misma instancia gracias a la canonicalización de `const`.
4.  Crear un cuadrado usando el constructor nombrado `Cuadrado.desdeArea`.
5.  Verificar que el cálculo del área funciona para todas las figuras creadas.