### Ejercicio: Gestor de Sesión de Usuario (`SessionManager`)

#### Contexto del Problema

Imagina que estás desarrollando una aplicación que requiere que los usuarios inicien sesión. Una vez que un usuario
inicia sesión, su información (como su nombre de usuario, ID y la hora de inicio de sesión) debe ser accesible desde
muchas partes diferentes de la aplicación (la pantalla de perfil, la barra de navegación, la página de configuración,
etc.).

Es **crítico** que toda la aplicación comparta **una única fuente de verdad** para la información de la sesión. Si
diferentes partes del código crearan sus propias instancias de un gestor de sesión, tendríamos un caos: una parte de la
app podría pensar que el usuario es "Ana", mientras que otra podría tener datos de "Juan" o, peor aún, pensar que nadie
ha iniciado sesión.

#### ¿Por qué un Singleton es necesario aquí?

El patrón Singleton resuelve este problema garantizando que solo exista **una y solo una** instancia de la clase
`SessionManager` durante todo el ciclo de vida de la aplicación. Cualquier parte del código que necesite acceder a la
sesión del usuario obtendrá una referencia al mismo objeto, asegurando la consistencia de los datos.

Aquí, el Singleton no es un capricho académico, sino una necesidad arquitectónica para mantener un estado global y
coherente (el estado de la sesión del usuario).

### Pasos para Resolver el Ejercicio

A continuación, te doy los pasos para que construyas la clase `SessionManager` siguiendo el patrón "Singleton con
`factory` + almacenamiento estático".

#### Parte 1: Creación de la Clase Singleton `SessionManager`

1. **Declara la clase `SessionManager`**. Por buenas prácticas y para seguir las recomendaciones de la documentación que
   leíste, declárala como `final class` para evitar que pueda ser extendida o implementada.

2. **Crea un constructor privado**. Dentro de la clase, define un constructor con un guion bajo (ej.
   `SessionManager._();`). Esto impedirá que se puedan crear nuevas instancias de `SessionManager` desde fuera del
   archivo usando la sintaxis `new SessionManager()` o `SessionManager()`.

3. **Crea la instancia estática y privada**. Declara una variable estática, final y privada que guarde la única
   instancia de tu clase. Esta instancia debe ser creada usando el constructor privado que definiste en el paso
   anterior.

    ```dart
    // Pista: static final SessionManager _instance = SessionManager._();
    ```

4. **Implementa el constructor `factory` público**. Este será el punto de acceso global para obtener la instancia. Este
   constructor no crea un objeto nuevo, sino que debe devolver siempre la instancia estática que creaste en el paso 3.

    ```dart
    // Pista: factory SessionManager() { ... }
    ```

5. **Añade el estado y los métodos de la sesión**.
    * Dentro de la clase, añade propiedades privadas para almacenar los datos del usuario: `String? _username;`,
      `String? _userId;`, `DateTime? _loginTime;`. Usa tipos que puedan ser nulos (`?`) para representar que no hay
      sesión activa.
    * Crea *getters* públicos para cada una de estas propiedades (ej. `String? get username => _username;`).
    * Crea un método público `void login(String username, String userId)` que asigne los valores recibidos a las
      propiedades internas y establezca `_loginTime` a la hora actual (`DateTime.now()`).
    * Crea un método público `void logout()` que reinicie todas las propiedades a `null`.
    * Crea un getter booleano `bool get isLoggedIn => _username != null;`.

#### Parte 2: Verificación del Funcionamiento

Crea una función `main` para comprobar que tu Singleton funciona como se espera.

1. **Obtén dos "instancias"** del `SessionManager` en dos variables diferentes.

    ```dart
    // final session1 = SessionManager();
    // final session2 = SessionManager();
    ```

2. **Verifica la identidad de las instancias**. Usa la función `identical(session1, session2)` para comprobar si ambas
   variables apuntan exactamente al mismo objeto en memoria. Imprime el resultado. Deberías ver `true` en la consola.
   Este es el corazón del patrón: ¡solo hay un objeto!

3. **Simula un inicio de sesión**. Usando la primera variable (`session1`), llama al método `login` con datos de
   ejemplo (ej. `session1.login('testuser', '12345');`).

4. **Comprueba el estado desde la segunda variable**. Imprime el nombre de usuario accediendo a él a través de la
   segunda variable (`session2.username`). Deberías ver `'testuser'`, demostrando que el estado modificado a través de
   `session1` es visible desde `session2`, porque ambas son referencias al mismo objeto.

5. **Simula un cierre de sesión**. Llama al método `logout` usando la segunda variable (`session2.logout();`).

6. **Verifica el estado final desde la primera variable**. Imprime de nuevo el nombre de usuario usando
   `session1.username`. Ahora deberías ver `null`, confirmando una vez más que el estado es compartido.
