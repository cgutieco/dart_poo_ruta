### Ejercicio: Gestor de Usuarios con Constructores `factory`

**Objetivo:** Practicar el uso de constructores `factory` para controlar la creación de instancias según condiciones
externas y reutilizar objetos.

**Requisitos:**

1. **Clase Base `Usuario`:**
    * Crea una clase `Usuario` con los campos `nombre` (String) y `rol` (String).
    * El constructor principal debe ser privado (`Usuario._()`).

2. **Constructor `factory`:**
    * Implementa un constructor `factory Usuario(String nombre, String rol)` que:
        * Si el `rol` es `'admin'`, siempre devuelva la misma instancia de usuario administrador (singleton).
        * Si el `rol` es `'invitado'`, devuelva una nueva instancia cada vez.
        * Para cualquier otro `rol`, lanza una excepción `Exception('Rol no soportado')`.

3. **Método:**
    * Añade un método `void saludar()` que imprima un saludo personalizado según el rol.

**Tarea final:**

En tu función `main`, crea usuarios de tipo `'admin'` y `'invitado'` usando el constructor `factory` y verifica:

* Que los usuarios `'admin'` son la misma instancia.
* Que los usuarios `'invitado'` son instancias diferentes.
* Que el método `saludar()` funciona correctamente.

Este ejercicio te ayudará a entender cómo los constructores `factory` pueden controlar la lógica de creación y
reutilización de objetos en Dart.