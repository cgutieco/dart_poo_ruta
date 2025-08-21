### Ejercicio Práctico: Sistema de Gestión de Vehículos

#### Contexto

Una empresa de gestión de flotas necesita un sistema en Dart para catalogar los diferentes tipos de vehículos que posee.
Cada vehículo comparte características comunes, pero también tiene atributos y comportamientos específicos según su
tipo. Tu tarea es diseñar una jerarquía de clases que modele esta realidad, aplicando los principios de la Programación
Orientada a Objetos, con un enfoque especial en la herencia.

#### Requisitos y Reglas

**1. Clase Base: `Vehiculo`**

Esta será la superclase y debe contener los atributos y métodos comunes a todos los vehículos.

* **Atributos (Capítulos 2 y 4):**
    * `marca`: `String` público.
    * `modelo`: `String` público.
    * `anioFabricacion`: `int` público.
    * `_numeroSerie`: `String` privado y `final`. Debe ser inmutable una vez asignado en la creación del objeto para
      simular un identificador único.
    * `kilometraje`: `double` público.
    * `precioBase`: `double` público.
    * `TARIFA_IMPUESTO`: Atributo estático y `const` con un valor de `0.15`, que representa un impuesto fijo para todos
      los vehículos.

* **Constructor (Capítulo 3):**
    * Un constructor principal con parámetros **nombrados y requeridos** para `marca`, `modelo`, `anioFabricacion`,
      `_numeroSerie` y `precioBase`.
    * Un constructor nombrado `Vehiculo.deSegundaMano()` que, además de los parámetros anteriores, requiera el
      `kilometraje`.

* **Métodos (Capítulos 2 y 4):**
    * Un getter para `_numeroSerie` que permita el acceso de solo lectura desde fuera de la librería.
    * Un setter para `kilometraje` que impida asignar un valor inferior al actual.
    * Un método `calcularAntiguedad()` que devuelva los años del vehículo (considerando el año actual como 2025).
    * Un método `describir()` que devuelva una cadena con la información básica: "Marca Modelo (Año) - Kilometraje km".
    * Un método `calcularPrecioFinal()` que devuelva el `precioBase` más el impuesto calculado con `TARIFA_IMPUESTO`.

**2. Subclase: `Coche` (hereda de `Vehiculo`)**

Esta clase representa un coche y debe especializar a `Vehiculo`.

* **Atributos (Capítulo 5):**
    * `numeroPuertas`: `int`.
    * `tipoCombustible`: `String` (ej. "Gasolina", "Eléctrico", "Híbrido").

* **Constructor (Capítulo 5):**
    * Debe recibir todos los parámetros necesarios para un `Coche` (incluidos los de `Vehiculo`) y utilizar `super()`
      para invocar al constructor de la superclase y pasarle los valores correspondientes.

* **Métodos (Capítulo 5):**
    * Sobrescribir (`@override`) el método `describir()`. Debe invocar la implementación de la superclase con
      `super.describir()` y añadir la información específica del coche: " - X puertas, Combustible: Y".
    * Sobrescribir (`@override`) el método `calcularPrecioFinal()`. Debe invocar `super.calcularPrecioFinal()` y añadir
      un coste fijo de 500 por ser un coche.

**3. Subclase: `Camion` (hereda de `Vehiculo`)**

Esta clase representa un camión y también especializa a `Vehiculo`.

* **Atributos (Capítulo 5):**
    * `capacidadCarga`: `double` que representa las toneladas.
    * `numeroEjes`: `int`.

* **Constructor (Capítulo 5):**
    * Al igual que `Coche`, debe recibir sus parámetros y los de `Vehiculo`, usando `super()` para la inicialización de
      la parte heredada.

* **Métodos (Capítulo 5):**
    * Sobrescribir (`@override`) el método `describir()`. Debe llamar a `super.describir()` y añadir los detalles del
      camión: " - Carga: X Toneladas, Y ejes".
    * Un método propio llamado `realizarInspeccionTacografo()` que imprima un mensaje indicando que la inspección se ha
      realizado.

**4. Jerarquía Multinivel: `CocheElectrico` (hereda de `Coche`)**

Para demostrar una jerarquía más profunda, esta clase especializa a `Coche`.

* **Atributos (Capítulo 5):**
    * `autonomiaBateria`: `int` en kilómetros.

* **Constructor (Capítulo 5):**
    * Debe recibir todos los parámetros de un coche eléctrico y usar `super()` para invocar al constructor de `Coche`,
      que a su vez llamará al de `Vehiculo`.

* **Métodos (Capítulo 5):**
    * Sobrescribir (`@override`) el método `describir()`. Debe invocar la versión de `Coche` con `super.describir()` y
      añadir la autonomía: ", Autonomía: X km".
    * Un método propio llamado `cargarBateria()` que imprima "Cargando batería...".

#### Casuística a implementar

1. Crea una lista de tipo `List<Vehiculo>`.
2. Crea instancias de `Coche`, `Camion` y `CocheElectrico` utilizando sus respectivos constructores.
3. Añade todos los objetos a la lista.
4. Recorre la lista con un bucle y, para cada elemento, imprime el resultado de llamar a su método `describir()` y
   `calcularPrecioFinal()`. Observa cómo el polimorfismo (aunque el foco sea la herencia) permite ejecutar la versión
   correcta del método según el tipo real del objeto.
5. Finalmente, realiza una llamada a los métodos específicos de cada subclase (como `realizarInspeccionTacografo()` en
   el camión y `cargarBateria()` en el coche eléctrico) para demostrar que, aunque no están en la clase base, forman
   parte del contrato de las clases derivadas.