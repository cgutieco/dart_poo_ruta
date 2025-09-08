# Ejercicio práctico — Capítulo 16. Enums Avanzados

Objetivo: practicar enums simples, enums con valores asociados, métodos y getters, extensions, switch exhaustivo (
sentencia y expresión) y decisiones de serialización. Sin escribir clases selladas, pero comparándolas conceptualmente.

Contexto sugerido: un mini “sistema de pedidos” con estados y prioridades.

Instrucciones:

1) Crea un enum simple para el estado de un pedido

   - Define un enum con 3–4 estados coherentes (por ejemplo: creado, pagado, enviado, cancelado).
   - Asegúrate de poder listar todas sus variantes con values y obtener name e index de alguna.
   - No uses index para lógica de negocio (solo inspección).

2) Implementa un switch exhaustivo (sentencia)

   - Escribe una función que reciba el estado y devuelva un mensaje para UI (por ejemplo: “Tu pedido está en camino”).
   - Usa switch sin default/_ para forzar exhaustividad.
   - Verifica que el compilador no emite advertencias.

3) Convierte ese switch a switch expresión

   - Crea una versión equivalente con switch expresión que devuelva un String.
   - Mantén el mapeo puro y sin efectos colaterales.

4) Crea un enum con valores asociados (campos + constructor const)

   - Modela una prioridad del pedido con un code para persistencia (por ejemplo, “L”, “M”, “H”) y un label legible (por
     ejemplo, “Baja”, “Media”, “Alta”).
   - Declara los campos como final y el constructor como const.
   - Añade al menos un método que use esos campos (por ejemplo, comparación simple o formateo para UI).

5) Agrega getters y lógica ligera en el enum con valores asociados

   - Implementa un getter booleando que indique si la prioridad es alta/severa.
   - Evita efectos colaterales; que el método sea puro.

6) Implementa una extensión (extension) para separar presentación

   - Crea una extension sobre el enum de estado o prioridad con funciones de presentación (por ejemplo, toEmoji(),
     toColorName() o a un formato corto).
   - Mantén fuera del enum todo lo que sea puramente de presentación.

7) Serialización sencilla de enums

   - Define un contrato de serialización:
       - Para el estado: decide si serializas por name (recomendado) y documenta la decisión.
       - Para la prioridad: serializa por code (recomendado).
   - Añade una función de mapeo “from” para reconstruir la prioridad por su code.
   - Documenta por qué evitas usar index.

8) Pruebas manuales rápidas

   - Verifica que values contiene exactamente las variantes esperadas.
   - Llama a las funciones con cada variante del enum y confirma que el switch es exhaustivo.
   - Prueba la ida y vuelta de serialización: (enum) -> (string code/name) -> (enum).

9) Evolución y verificación de exhaustividad

   - Agrega una nueva variante al enum de estado (por ejemplo, “devuelto”).
   - Comprueba que el compilador te obliga a actualizar los switch.
   - Actualiza todos los lugares necesarios hasta que no haya advertencias.

10) Reflexión: enum vs sealed class

    - Escribe una nota breve justificando por qué tu modelado funciona con enums.
    - Describe un caso hipotético del mismo dominio que requeriría sealed classes (por ejemplo, variantes con datos
      radicalmente distintos).

Entregables (texto):

- Lista de estados y prioridades con una breve descripción semántica por variante.
- Decisiones de serialización (por name y por code), con 1–2 frases de justificación.
- Resultado de las pruebas manuales: qué casos verificaste y el resultado esperado.
- Reflexión final sobre enum vs sealed class.

Criterios de aceptación:

- Al menos 1 enum simple y 1 enum con valores asociados y constructor const.
- Presencia de métodos y/o getters en el enum con valores asociados.
- Una extension separada para responsabilidades de presentación.
- Uso de switch exhaustivo en sentencia y en expresión.
- Funciones de serialización y deserialización coherentes con la decisión tomada.
- Al añadir una variante nueva, se actualizan los switch afectados.
- Documentación corta y clara de las decisiones.

Retos opcionales:

- Añade un mapa de ordenación por prioridad y valida su uso en una lista simulada de pedidos.
- Implementa una función que devuelva un “record” con título y mensaje a partir del estado (usando switch expresión).
- Agrega una interfaz simple (por ejemplo, Displayable) e implementa sus contratos con el enum correspondiente.

Errores a evitar:

- Persistir por index.
- Incluir efectos colaterales en constructores del enum.
- Usar default/_ en switch cuando buscas exhaustividad.
- Mezclar lógica de presentación dentro del enum cuando corresponde a una extension.