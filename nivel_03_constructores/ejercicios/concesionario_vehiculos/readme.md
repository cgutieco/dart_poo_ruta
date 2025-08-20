### Ejercicio: Modelado de un Concesionario de Vehículos

**Objetivo:** Crear un sistema de clases para representar vehículos en un concesionario, aplicando diferentes tipos de
constructores y la herencia.

**Requisitos:**

1. **Clase Base `Vehiculo`:**
    * Debe ser una clase inmutable. Todos sus campos serán `final`.
    * Tendrá dos propiedades: `marca` (String) y `modelo` (String).
    * Define un constructor `const` que utilice parámetros **nombrados y requeridos** para inicializar sus propiedades.

2. **Clase Derivada `Coche`:**
    * Debe heredar de `Vehiculo`.
    * Añade dos propiedades propias: `numeroDePuertas` (int) y `color` (String).
    * Define un constructor principal que reciba `marca`, `modelo` y `numeroDePuertas` como parámetros **posicionales**.
      El parámetro `color` debe ser **nombrado y opcional**, con un valor por defecto de `'Negro'`.
    * Este constructor debe usar `super` para pasar la `marca` y el `modelo` al constructor de la clase `Vehiculo`.

3. **Constructor Nombrado y de Redirección:**
    * En la clase `Coche`, crea un constructor **nombrado** llamado `Coche.deportivo`.
    * Este constructor recibirá únicamente la `marca` y el `modelo`.
    * Debe ser un constructor de **redirección** que llame al constructor principal de `Coche`, estableciendo el
      `numeroDePuertas` en `2` y el `color` en `'Rojo'`.

4. **Uso de Inicializadores:**
    * Añade una propiedad `final String codigoInterno` a la clase `Coche`.
    * Modifica el constructor principal de `Coche` para que, usando una **lista de inicializadores**, asigne a
      `codigoInterno` un valor generado a partir de la concatenación de la marca, el modelo y el número de puertas (ej:
      `'FORD-FOCUS-4'`).

**Tarea final:**

En tu función `main`, crea instancias de `Coche` utilizando todos los constructores que has definido para verificar que
tu implementación es correcta:

* Un coche estándar con un color personalizado.
* Un coche estándar que use el color por defecto.
* Un coche deportivo utilizando el constructor nombrado.