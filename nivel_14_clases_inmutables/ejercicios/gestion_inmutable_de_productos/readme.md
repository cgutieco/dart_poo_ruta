### Ejercicio: Gestión Inmutable de Productos

**Objetivo:**
Practicar la creación de clases inmutables y el manejo de valores nulos (`null safety`) mediante la modelación de un
`Producto`.

**Contexto:**
Necesitas crear un sistema para representar productos en un catálogo. Cada producto tiene un nombre, un precio y,
opcionalmente, un código de descuento. Una vez que un producto se crea, su información no debe poder ser modificada
directamente para garantizar la integridad de los datos.

---

### Pasos para la Solución

#### Paso 1: Define la Clase `Producto`

* Crea una nueva clase llamada `Producto`.
* Declara tres atributos de instancia, y asegúrate de que no puedan ser modificados después de la creación del objeto
  usando la palabra clave `final`.
    * Un `nombre` de tipo `String`.
    * Un `precio` de tipo `double`.
    * Un `codigoDescuento` que pueda ser nulo. Para ello, declara su tipo como `String?`.

#### Paso 2: Crea el Constructor Inmutable

* Implementa un constructor para la clase `Producto`.
* Asegúrate de que este constructor sea `const` para permitir la creación de instancias en tiempo de compilación.
* Utiliza parámetros con nombre para inicializar todos los atributos. Los atributos no anulables (`nombre` y `precio`)
  deben ser marcados como `required`. El atributo anulable (`codigoDescuento`) puede ser opcional.

#### Paso 3: Implementa el Método `copyWith`

* Añade un método llamado `copyWith` a tu clase. Este método debe devolver una nueva instancia de `Producto`.
* El método debe aceptar parámetros opcionales con nombre para cada uno de los atributos de la clase (`nombre`,
  `precio`, `codigoDescuento`).
* Dentro del método, invoca al constructor de `Producto`. Para cada atributo, utiliza el operador de coalescencia nula (
  `??`) para decidir: si se pasó un nuevo valor al método `copyWith`, úsalo; de lo contrario, mantén el valor del objeto
  actual (`this`).

#### Paso 4: Prueba tu Implementación en `main`

* Crea una función `main`.
* **Instancia Inicial:** Dentro de `main`, crea una instancia `const` de `Producto` llamada `productoOriginal`. Asígnale
  un nombre y un precio, pero deja el `codigoDescuento` como `null`.
* **Primera Copia:** A partir de `productoOriginal`, usa el método `copyWith` para crear una nueva instancia llamada
  `productoConDescuento`. En esta nueva instancia, asigna un valor al `codigoDescuento`.
* **Segunda Copia:** Ahora, a partir de `productoConDescuento`, usa `copyWith` de nuevo para crear una tercera instancia
  llamada `productoRebajado`. En esta ocasión, cambia únicamente el `precio` a un valor más bajo.
* **Verificación:** Imprime los detalles de las tres instancias (`productoOriginal`, `productoConDescuento` y
  `productoRebajado`) para confirmar que cada una tiene los valores correctos y que las instancias originales no fueron
  modificadas.