### Ejercicio: Sistema de Gestión de Tipos de Contenido Digital

**Contexto:**
Estás desarrollando una aplicación que gestiona diferentes tipos de archivos multimedia. Necesitas modelar los tipos de
contenido de una manera segura, robusta y que encapsule la lógica relacionada con cada tipo. Los tipos de contenido
soportados son `articulo`, `video`, y `podcast`.

**Requisitos:**
Cada tipo de contenido tiene asociado:

1. Un **nombre legible** para mostrar en la interfaz (ej. "Artículo de Blog").
2. Un **ícono** representado por un emoji (ej. "📄" para artículo).
3. Una **duración estimada de consumo** en minutos. Para `articulo` se asume una duración fija de 5 minutos, para
   `video` 20 minutos y para `podcast` 30 minutos.
4. Un método para **verificar si el contenido requiere una suscripción premium**. Los `video` y `podcast` son premium,
   mientras que los `articulo` son gratuitos.

**Objetivo:**
Crear un `enum` llamado `TipoContenido` que modele esta información y comportamiento, y luego utilizarlo para procesar
una lista de contenidos.

---

### Pasos a Seguir (Guía sin código)

A continuación, se detallan los pasos que debes seguir para resolver el ejercicio aplicando los principios de la
Programación Orientada a Objetos y las características avanzadas de los enums en Dart.

**Paso 1: Definir el Enum `TipoContenido`**

* Crea el `enum` `TipoContenido` con las tres variantes: `articulo`, `video` y `podcast`.

**Paso 2: Añadir Propiedades con Datos Asociados**

* Dentro del `enum`, declara tres campos `final`:
    * `nombreLegible` (de tipo `String`)
    * `icono` (de tipo `String`)
    * `duracionEstimada` (de tipo `int`)
* Estos campos almacenarán los datos específicos de cada variante del enum.

**Paso 3: Implementar el Constructor `const`**

* Añade un constructor `const` al `enum` que permita inicializar los tres campos que definiste en el paso anterior.
* Asigna los valores correspondientes a cada una de las variantes del enum (`articulo`, `video`, `podcast`) utilizando
  el constructor.

**Paso 4: Añadir un Comportamiento (Método)**

* Define un método dentro del `enum` llamado `esPremium()`.
* Este método debe devolver `true` si el tipo de contenido es `video` o `podcast`, y `false` en caso contrario. Puedes
  usar una sentencia `switch` o una expresión booleana para lograrlo.

**Paso 5: Crear una Función Externa para Procesar Contenido**

* Fuera del `enum`, crea una función llamada `mostrarResumenContenido`.
* Esta función debe recibir una lista de `TipoContenido` como parámetro (`List<TipoContenido>`).
* Dentro de la función, itera sobre la lista y, para cada elemento, imprime un resumen que incluya su ícono, su nombre
  legible y si requiere suscripción premium o no.

**Paso 6: Probar la Solución**

* En tu función `main`, crea una lista que contenga varias instancias de `TipoContenido`, por ejemplo:
  `[TipoContenido.articulo, TipoContenido.video, TipoContenido.video, TipoContenido.podcast]`.
* Llama a la función `mostrarResumenContenido` con esta lista para verificar que la salida en consola sea la esperada.