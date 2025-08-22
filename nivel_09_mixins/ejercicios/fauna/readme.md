Ejercicio integrador: Mixins en Dart con herencia, polimorfismo, encapsulación y constructores `factory`

Objetivo

- Diseñar un mini\-modelo de fauna usando mixins para reutilizar comportamiento, con herencia, polimorfismo,
  encapsulación y constructores `factory`.

Requisitos

- No escribir código al inicio. Primero definir el diseño siguiendo los pasos.
- Respetar encapsulación con atributos privados y validaciones a través de getters/setters.
- Usar mixins con `on` para restringir su uso.
- Demostrar polimorfismo invocando métodos a través del tipo base.
- Incluir al menos un conflicto de métodos entre mixins y resolverlo por orden en `with`.
- Implementar al menos un `factory` en una clase abstracta que retorne subtipos y otro `factory` con caché.

Pasos

1. Definir la clase base abstracta `Animal`
    - Atributos:
        - `\_id` (cadena): identificador único. Solo lectura.
        - `\_energia` (entero 0\-100): nivel de energía. Lectura/escritura con validación.
    - Métodos:
        - `id`: getter de solo lectura que expone `\_id`.
        - `energia`: getter y setter con validación \[0, 100\]. El setter ajusta a límites y puede lanzar error si el
          dato es inválido.
        - `mover(String modo)`: reduce `\_energia` según el `modo` (por ejemplo, caminar, nadar, volar) y retorna una
          descripción del movimiento.
        - `recargarEnergia(int cantidad)`: aumenta energía sin exceder 100.
        - `emitirSonido()`: abstracto; cada subtipo define su sonido.
        - `toString()`: resumen que incluya `id` y `energia`.

2. Definir mixin `Volador on Animal`
    - Propósito: inyectar comportamiento de vuelo solo a clases que sean `Animal`.
    - Métodos:
        - `despegar()`: valida energía mínima, la reduce y retorna mensaje de despegue.
        - `volar(int km)`: reduce energía en función de distancia; registra el movimiento. Puede invocar
          `super.mover("volando")`.
        - `aterrizar()`: retorna mensaje y recupera un poco de energía si aplica.
        - `modoMovimiento()`: retorna `"volando"`; se usará para probar conflictos con otros mixins.
        - `registrarMovimiento(String modo)`: método auxiliar que delega al registro si existe, o construye un mensaje
          estándar.

3. Definir mixin `Nadador on Animal`
    - Propósito: comportamiento de nado para clases `Animal`.
    - Métodos:
        - `sumergirse(int metros)`: valida y reduce energía.
        - `nadar(int metros)`: reduce energía y registra el movimiento. Puede invocar `super.mover("nadando")`.
        - `emerger()`: mensaje de salida a superficie.
        - `modoMovimiento()`: retorna `"nadando"`.

4. Definir mixins de registro con conflicto intencional
    - `RegistraSimple`:
        - `registrarMovimiento(String modo)`: imprime/retorna un mensaje simple de registro.
    - `RegistraDetallado`:
        - `registrarMovimiento(String modo)`: imprime/retorna un mensaje con marca temporal y energía restante.
    - Objetivo: al combinar ambos, verificar que prevalece el último en `with`.

5. Definir jerarquía de herencia
    - `Ave extends Animal`
        - Métodos: `emitirSonido()` retorna un canto genérico; puede sobreescribir `mover` para ajustar el costo base de
          movimiento de aves.
    - `Mamifero extends Animal`
        - Métodos: `emitirSonido()` genérico de mamífero; puede ajustar consumo de energía al moverse.
    - `Pez extends Animal`
        - Métodos: `emitirSonido()` apropiado; `mover` con costo base diferente.

6. Definir clases concretas que combinen herencia y mixins
    - `Aguila extends Ave with Volador, RegistraSimple`
        - Atributos extra: ninguno obligatorio.
        - Métodos: puede sobreescribir `emitirSonido()` con su sonido específico.
    - `Pato extends Ave with Volador, Nadador, RegistraDetallado`
        - Nota: el orden de `with` asegura que `modoMovimiento()` será el del último mixin que lo defina. Ajustar para
          observar comportamiento deseado.
        - Métodos: `emitirSonido()` característico.
    - `Murcielago extends Mamifero with Volador, RegistraDetallado`
        - Métodos: `emitirSonido()` característico; puede ajustar gasto energético de vuelo nocturno.
    - `Tiburon extends Pez with Nadador, RegistraSimple`
        - Métodos: `emitirSonido()` si aplica; priorizar `nadar`.

7. Encapsulación
    - Mantener `\_id` y `\_energia` privados.
    - Toda modificación de energía debe pasar por `energia` o métodos de dominio (`mover`, `nadar`, `volar`, etc.).
    - Evitar exponer referencias mutables. Si se agregan colecciones internas, devolver copias.

8. Constructores `factory`
    - En `Animal`:
        - `factory Animal.crear(Map datos)`: según `datos["tipo"]` (`"aguila"`, `"pato"`, `"murcielago"`, `"tiburon"`),
          retorna una instancia del subtipo correspondiente inicializada con `id` y `energia` validados. Si `tipo` es
          desconocido, retornar un subtipo por defecto o lanzar error.
    - En subclases concretas (por ejemplo, `Pato`):
        - `factory Pato.desdeMapa(Map datos)`: valida entrada, normaliza energía, crea o reutiliza desde caché.
        - Caché: campo estático privado `\_cache` que mapea `id` a instancia. Si `id` existe, retorna la ya creada; si
          no, crea, guarda y retorna.
    - Documentar la intención de cada `factory`: selección de subtipo en `Animal` y caching en subclases.

9. Polimorfismo
    - Preparar una colección homogénea de tipo `List<Animal>` con instancias de `Aguila`, `Pato`, `Murcielago`,
      `Tiburon` creadas mediante `Animal.crear(...)` y/o sus `factory` específicos.
    - Iterar llamando `emitirSonido()` y `mover("caminando")` o similar y observar el despacho dinámico.
    - Para comportamientos de mixin, condicionar por capacidad:
        - Si el elemento soporta vuelo, invocar la secuencia `despegar` → `volar` → `aterrizar`.
        - Si soporta nado, invocar `sumergirse` → `nadar` → `emerger`.
    - Verificar que el método `registrarMovimiento` usado proviene del último mixin en el orden de `with`.

10. Restricciones con `on` y cooperación con la jerarquía
    - Asegurar que `Volador` y `Nadador` usen `on Animal` para poder acceder a la API de `Animal` y cooperar con
      `super.mover(...)`.
    - Mostrar que intentar aplicar `Volador` a una clase que no herede de `Animal` debe considerarse un error de diseño.

11. Escenarios de prueba sugeridos
    - Crear un `Pato` con energía baja y demostrar que algunos métodos validan y rechazan acciones si no hay energía
      suficiente.
    - Crear dos `Pato` con el mismo `id` mediante `Pato.desdeMapa(...)` y comprobar que el `factory` retorna la misma
      instancia (caché).
    - Crear instancias vía `Animal.crear(...)` y confirmar que el subtipo retornado coincide con `tipo`.
    - Cambiar el orden de los mixins en `Pato` para observar cómo cambia el método `modoMovimiento()` efectivo.

Entrega esperada

- Un archivo `README.md` con la especificación de este ejercicio y tus decisiones de diseño.
- Un archivo de implementación con las clases y mixins descritos y pruebas manuales que evidencien herencia,
  polimorfismo, encapsulación y funcionamiento de los `factory`.