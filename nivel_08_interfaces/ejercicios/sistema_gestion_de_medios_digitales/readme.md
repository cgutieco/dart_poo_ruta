# Ejercicio Integrador: Sistema de Gestión de Medios Digitales

## Objetivo

Diseñar e implementar un sistema básico para gestionar una biblioteca de medios digitales. Este ejercicio te obligará a
utilizar clases, herencia, polimorfismo, abstracción, interfaces, encapsulación y varios tipos de constructores para
crear una jerarquía de clases coherente y funcional.

---

## Requisitos del Sistema

Debes modelar diferentes tipos de medios digitales (Canciones, Podcasts y Audiolibros). Todos comparten características
básicas, pero tienen atributos y comportamientos específicos.

### 1. La Interfaz `Calificable`

Crea una clase que actuará como una **interfaz** implícita llamada `Calificable`. Su propósito es definir un contrato
para cualquier medio que pueda ser calificado por los usuarios.

- Debe definir la firma de un método: `void calificar(int estrellas)`.
- Debe definir la firma de un getter: `double get calificacionPromedio`.

### 2. La Clase Abstracta `MedioDigital`

Esta será la clase base para todos los medios en la biblioteca.

- **Debe ser una clase abstracta.**
- **Atributos:**
    - `titulo` (String, público, inmutable).
    - `artista` (String, público, inmutable).
    - `duracion` (Duration, público, inmutable).
    - `_idInterno` (String, privado, inmutable). Este ID debe generarse automáticamente.
- **Constructor:**
    - Un constructor principal que reciba `titulo`, `artista` y `duracion`.
    - Debe usar una **lista de inicializadores** para asignar un valor a `_idInterno` llamando a un método privado
      estático `_generarId()`.
- **Métodos:**
    - Un método abstracto `void reproducir()`.
    - Un método concreto `String obtenerInfoBasica()` que devuelva un `String` con el título, artista y duración.
    - Un getter público `id` que devuelva el valor de `_idInterno`.
    - Un método estático privado `_generarId()` que devuelva un `String` único (puedes simularlo usando
      `DateTime.now().millisecondsSinceEpoch.toString()`).

### 3. La Clase `Cancion`

Representa una pista de música.

- **Herencia e Interfaces:**
    - Debe **extender** de `MedioDigital`.
    - Debe **implementar** la interfaz `Calificable`.
- **Atributos:**
    - `album` (String, público, inmutable).
    - `_calificaciones` (List<int>, privada). Inicialízala como una lista vacía.
- **Constructores:**
    - Un constructor principal que reciba `titulo`, `artista`, `duracion` y `album`, y llame al constructor de la
      superclase (`super`).
- **Implementación de Métodos (`@override`):**
    - `reproducir()`: Debe imprimir un mensaje como "Reproduciendo canción: [título] - [artista]".
    - `calificar(int estrellas)`: Debe añadir la calificación (un número del 1 al 5) a la lista `_calificaciones`.
    - `calificacionPromedio` (getter): Debe calcular y devolver el promedio de las calificaciones. Si no hay
      calificaciones, debe devolver `0.0`.

### 4. La Clase `Podcast`

Representa un episodio de un podcast.

- **Herencia:**
    - Debe **extender** de `MedioDigital`.
- **Atributos:**
    - `nombrePodcast` (String, público, inmutable).
    - `numeroEpisodio` (int, público, inmutable).
- **Constructores:**
    - Un constructor principal para inicializar todos sus atributos.
- **Implementación de Métodos (`@override`):**
    - `reproducir()`: Debe imprimir "Reproduciendo podcast: [nombrePodcast], episodio [numeroEpisodio]: [título]".

### 5. El Constructor `factory` en `MedioDigital`

Añade un constructor `factory` a la clase `MedioDigital` para crear instancias de forma dinámica.

- **Firma:** `factory MedioDigital.crear(...)`
- **Lógica:**
    - Debe aceptar un `Map<String, dynamic> datos`.
    - Dentro del `factory`, debe leer una clave `'tipo'` del mapa.
    - Si `tipo` es `'cancion'`, debe crear y devolver una instancia de `Cancion`.
    - Si `tipo` es `'podcast'`, debe crear y devolver una instancia de `Podcast`.
    - Si el tipo no es reconocido, debe lanzar una excepción `ArgumentError`.

### 6. El `main` para Probar Todo

Crea una función `main` para verificar que todo funciona correctamente.

1. Crea una lista de tipo `MedioDigital`.
2. Usa el constructor `factory` `MedioDigital.crear` para instanciar al menos una `Cancion` y un `Podcast` a partir de
   mapas y añádelos a la lista.
3. Crea una instancia de `Cancion` directamente con su constructor. Califícala varias veces (ej. con 4 y 5 estrellas).
4. Itera sobre la lista de medios y, para cada elemento:
    - Imprime la información básica usando `obtenerInfoBasica()`.
    - Llama al método `reproducir()`.
    - Verifica si el objeto es `Calificable` (usando `is Calificable`). Si lo es, imprime su calificación promedio.
    - Imprime una línea separadora (`---`).
5. Verifica que no puedes instanciar `MedioDigital` directamente (ej. `final medio = MedioDigital(...)`), ya que es
   abstracta.

Este ejercicio te permitirá aplicar de forma práctica todos los conceptos clave de la POO en Dart que has aprendido.
¡Mucha suerte!