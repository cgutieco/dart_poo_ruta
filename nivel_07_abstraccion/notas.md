# Capítulo 7. Abstracción en Dart

La **abstracción** es un principio fundamental en la programación orientada a objetos, y consiste en resaltar los
aspectos esenciales de una entidad mientras se omiten los detalles irrelevantes para el contexto.  
En términos prácticos, abstraer significa **modelar un concepto del mundo real o de un dominio de problemas** mediante
una representación en el código que capture únicamente sus características más relevantes.

En Dart, la abstracción se materializa principalmente a través de las **clases abstractas** y los **métodos abstractos
**, que actúan como plantillas o contratos para otras clases. Esta capacidad es esencial para diseñar sistemas robustos,
jerárquicos y extensibles, donde la generalidad de ciertos comportamientos convive con la concreción de implementaciones
específicas.

---

## 7.1 Clases abstractas

Una **clase abstracta** es aquella que no puede ser instanciada directamente. Su propósito no es crear objetos
concretos, sino servir de base para que otras clases deriven de ella.  
Se declara con la palabra clave `abstract`.

Las características principales de una clase abstracta en Dart son:

1. **No instanciable:** intentar crear un objeto de una clase abstracta producirá un error de compilación.
2. **Puede contener métodos abstractos y concretos:** una clase abstracta puede incluir métodos sin implementación, que
   deberán ser definidos por sus subclases, pero también puede proporcionar métodos con comportamiento completo y
   reutilizable.
3. **Admite atributos y constructores:** a diferencia de una interfaz pura, una clase abstracta puede declarar variables
   de instancia y constructores, aunque estos últimos solo serán invocados por sus subclases.

**Ejemplo conceptual:**

- Una clase abstracta `Empleado` define atributos comunes como `nombre` y `salarioBase`.
- Proporciona un método concreto `aumentarSalario()` que aplica una regla general.
- Declara un método abstracto `calcularBonificacion()`, cuya implementación dependerá de cada tipo de empleado (
  administrativo, técnico, gerente).

De este modo, la clase abstracta fija un marco general y deja espacio para que las subclases especifiquen detalles
particulares.

**Comparación con Java:**  
El papel de las clases abstractas en Dart es prácticamente idéntico al de Java. La diferencia más relevante es que Dart
no posee modificadores de acceso como `protected`, por lo que todos los miembros abstractos son públicos (a menos que se
restrinjan por convención de librerías usando `_`).

---

## 7.2 Métodos abstractos

Un **método abstracto** es aquel que se declara sin cuerpo de implementación.  
Se limita a especificar la firma (nombre, parámetros, tipo de retorno), y delega la responsabilidad de implementar el
comportamiento en las subclases concretas.

La utilidad de los métodos abstractos radica en:

- **Forzar la implementación:** cualquier subclase concreta debe proporcionar una definición para todos los métodos
  abstractos heredados.
- **Definir un contrato:** establecen qué operaciones son obligatorias en las subclases, garantizando uniformidad en
  jerarquías de clases.

**Ejemplo conceptual:**  
Un método abstracto `procesarPago(double monto)` en la clase `MedioDePago` obliga a que subclases como `TarjetaCredito`
o `TransferenciaBancaria` definan cómo procesan el pago de acuerdo a sus particularidades.

Es importante señalar que en Dart los métodos abstractos solo pueden existir dentro de **clases abstractas**. No se
pueden declarar métodos abstractos en una clase ordinaria.

---

## 7.3 Diferencia entre `abstract class` e interfaces

Uno de los aspectos más distintivos de Dart frente a otros lenguajes es la forma en que maneja la dualidad entre clases
abstractas e interfaces.

### Interfaces en Dart

En Dart, **toda clase define automáticamente una interfaz implícita**.  
Esto significa que cualquier clase puede ser tratada como interfaz, y otra clase puede implementar sus métodos usando la
sintaxis `implements NombreClase`.

- Cuando se utiliza `implements`, la nueva clase **no hereda código**, solo asume el compromiso de implementar todos los
  métodos y atributos públicos de la interfaz.
- Esto se aplica incluso si la clase que sirve de interfaz no era abstracta en origen.

### Clases abstractas vs Interfaces

La diferencia fundamental entre ambos mecanismos puede resumirse así:

| Aspecto                    | Clases abstractas (`abstract class`)         | Interfaces implícitas (`implements`)                     |
|----------------------------|----------------------------------------------|----------------------------------------------------------|
| Instanciación              | No pueden instanciarse                       | Tampoco, pues son contratos                              |
| Métodos con implementación | **Sí**, permiten definir lógica reutilizable | **No**, requieren implementación en la clase que las usa |
| Atributos                  | **Sí**, pueden tener campos de instancia     | Solo definen la forma (firmas de métodos/atributos)      |
| Constructores              | **Sí**, pueden declararlos                   | **No**, no se heredan constructores                      |
| Uso                        | Base para herencia y reutilización parcial   | Contrato estricto sin reutilización                      |

En resumen:

- Se utiliza una **clase abstracta** cuando se busca **mezclar contrato y reutilización de código**.
- Se utiliza `implements` (interfaces implícitas) cuando se quiere **forzar un contrato sin heredar implementación**.

### Comparación con Java

En Java, las interfaces y las clases abstractas son constructos distintos. Dart, en cambio, simplifica el modelo al
eliminar la necesidad de una palabra clave `interface`. Esto reduce la complejidad conceptual, aunque obliga a los
desarrolladores a entender que `implements` no trae consigo la implementación, solo el contrato.

---

## Conclusión

La abstracción en Dart es una herramienta poderosa que permite diseñar jerarquías de clases claras y extensibles:

- Las **clases abstractas** proporcionan un marco común y reutilizable.
- Los **métodos abstractos** obligan a las subclases a implementar comportamientos esenciales.
- Las **interfaces implícitas** eliminan la necesidad de un constructo adicional, unificando el modelo conceptual y
  reduciendo la duplicación de mecanismos.

En conjunto, estos recursos permiten representar conceptos generales en el código y delegar en las subclases la
responsabilidad de concretar los detalles, lo que conduce a sistemas más modulares, mantenibles y expresivos.