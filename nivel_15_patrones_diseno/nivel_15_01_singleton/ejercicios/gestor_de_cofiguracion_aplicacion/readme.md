### Ejercicio: Gestor de Configuración de la Aplicación (`AppSettings`)

#### Contexto del Problema

Casi cualquier aplicación necesita gestionar configuraciones que son compartidas globalmente: el tema (claro u oscuro),
el idioma, si las notificaciones están activadas, etc. Estas configuraciones deben ser consistentes en toda la
aplicación. Si un usuario cambia el tema en la pantalla de "Ajustes", la pantalla "Principal" debe reflejar ese cambio
inmediatamente.

#### ¿Por qué un Singleton es necesario aquí?

Si cada pantalla creara su propio objeto de configuración, los cambios realizados en un lugar no se reflejarían en otro.
Esto llevaría a una experiencia de usuario rota y frustrante. Un **Singleton** es la solución ideal porque garantiza que
**existe una única fuente de verdad** para toda la configuración de la aplicación. Cualquier parte del código que
modifique o lea un ajuste lo hará sobre el mismo y único objeto, asegurando la coherencia global.

### Pasos para Resolver el Ejercicio

1. **Define el Contrato (`IAppSettings`)**:
    * Crea una `abstract interface class` llamada `IAppSettings`.
    * Define los métodos y *getters* que cualquier gestor de configuración debería tener. Por ejemplo:
        * Un getter `String get theme`.
        * Un método `void setTheme(String newTheme)`.
        * Un getter `String get language`.

2. **Crea la Implementación Singleton (`AppSettings`)**:
    * Crea una `final class` llamada `AppSettings` que implemente la interfaz `IAppSettings`.
    * Implementa el patrón Singleton clásico con un constructor `factory` (constructor privado, instancia estática
      privada y el `factory` que la devuelve).
    * Añade las propiedades privadas para guardar los valores (ej. `_theme`, `_language`) y dale valores por defecto.
    * Implementa (`@override`) los métodos y *getters* de la interfaz para que lean y modifiquen estas propiedades
      privadas.

3. **Crea una Clase Consumidora con DI (`SettingsDisplay`)**:
    * Crea una clase simple llamada `SettingsDisplay`.
    * En su constructor, exige que se le pase una instancia de `IAppSettings`. Almacénala en una propiedad final.
    * Crea un método `void displayCurrentSettings()` que use la dependencia inyectada para imprimir los ajustes
      actuales (ej. "Tema actual: [tema], Idioma: [idioma]").

4. **Conecta Todo en `main`**:
    * En tu función `main`, obtén la instancia del Singleton: `final appSettings = AppSettings();`.
    * Crea una instancia de `SettingsDisplay`, **inyectándole** la instancia del Singleton que acabas de obtener.
    * Llama al método `displayCurrentSettings()` para ver los valores iniciales.
    * Ahora, usa la instancia `appSettings` para cambiar un ajuste, por ejemplo: `appSettings.setTheme('dark');`.
    * Vuelve a llamar a `displayCurrentSettings()` en tu objeto `SettingsDisplay`. Verás que, sin hacerle nada más, ya
      refleja el cambio, demostrando que ambos (la variable `appSettings` y la dependencia dentro de `SettingsDisplay`)
      apuntan al mismo objeto.
