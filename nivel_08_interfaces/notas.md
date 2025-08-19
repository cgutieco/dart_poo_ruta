# Capítulo 8. Interfaces e Implementación en Dart

En el diseño de sistemas orientados a objetos es común separar la **definición de un contrato** de su **implementación
concreta**.  
Este principio, fundamental para lograr flexibilidad y escalabilidad, se materializa en Dart a través de las *
*interfaces**.

A diferencia de lenguajes como Java, Dart **no tiene una palabra reservada `interface`**. En su lugar, **toda clase
define automáticamente una interfaz implícita**, es decir, un contrato que puede ser implementado por otras clases
mediante la palabra clave `implements`.

---

## 8.1 La palabra clave `implements`

El uso de `implements` en Dart tiene como finalidad **forzar a una clase a cumplir con las definiciones públicas de otra
**.  
Cuando una clase implementa otra:

- **No hereda código**: solo adquiere la obligación de reproducir la misma interfaz pública (métodos, getters, setters).
- **Debe proporcionar sus propias implementaciones**: incluso si la clase original ya contenía métodos con lógica, estos
  no son reutilizados.
- El contrato se aplica tanto si la clase usada como interfaz es abstracta como si es concreta.

**Ejemplo conceptual:**  
Imaginemos una clase `Imprimible` que define un método `imprimir()`.

- Si otra clase `Factura` declara `implements Imprimible`, está obligada a proveer su propia versión de `imprimir()`.
- No importa que `Imprimible` tenga ya lógica implementada: la clase `Factura` debe redefinir todo.

Esto convierte a `implements` en una herramienta poderosa para diseñar **contratos claros y uniformes**, sin imponer
herencia ni arrastrar código innecesario.

---

## 8.2 Diferencia entre `implements` y `extends`

Es habitual que los principiantes confundan `implements` con `extends`, dado que ambos conectan clases.  
La diferencia esencial radica en la **naturaleza de la relación**:

| Aspecto                 | `extends` (Herencia)                        | `implements` (Implementación de interfaz)       |
|-------------------------|---------------------------------------------|-------------------------------------------------|
| Propósito               | Reutilizar código y comportamiento          | Establecer un contrato (sin herencia de código) |
| Código heredado         | Sí, métodos y atributos concretos           | No, solo las firmas públicas                    |
| Obligación de redefinir | No, salvo que se desee sobrescribir         | Sí, todos los métodos deben implementarse       |
| Constructores           | Se heredan y pueden invocarse con `super`   | No se heredan, deben declararse desde cero      |
| Relación                | "Es un tipo de..." con comportamiento común | "Debe cumplir con..." como contrato             |
| Ejemplo                 | `Empleado extends Persona`                  | `Factura implements Imprimible`                 |

En resumen:

- Se utiliza **`extends`** cuando existe una **relación jerárquica** con intención de **reutilizar comportamiento**.
- Se utiliza **`implements`** cuando lo que interesa es **garantizar la compatibilidad con un contrato**, sin importar
  cómo se implementa.

---

## 8.3 Implementar múltiples interfaces

Una de las mayores ventajas del modelo de interfaces en Dart es la posibilidad de **implementar múltiples contratos a la
vez**.  
Esto se logra simplemente listando las interfaces separadas por comas después de la palabra clave `implements`.

**Ejemplo conceptual:**  
Un objeto `DocumentoElectronico` puede necesitar comportarse como:

- `Imprimible` (porque puede enviarse a impresora),
- `Serializable` (porque debe convertirse a JSON),
- `Auditable` (porque requiere trazabilidad).

En Dart se escribiría:

```dart
class DocumentoElectronico implements Imprimible, Serializable, Auditable {
  // Obligación: implementar TODOS los métodos de Imprimible, Serializable y Auditable
}
```

Esto permite que un mismo objeto sea compatible con múltiples contextos, logrando polimorfismo múltiple a nivel de
contratos.
La gran diferencia respecto a extends es que no existe herencia múltiple de implementación: lo que se multiplica son los
contratos, no el código.

---

## 8.4 Esquema visual de relaciones

Para reforzar la comprensión, aquí tienes un diagrama textual simplificado:

```
               (Clase A)
                  ↑
               extends
                  │
               (Clase B)
                  
   (Interface C)    (Interface D)
          ↑             ↑
           \           /
            \         /
             \       /
         (Clase E implements C, D)
```

• Clase B hereda de Clase A mediante `extends`, reutilizando código.

• Clase E no hereda de C ni D, sino que se compromete a implementar sus contratos, incluso si ambos tienen decenas de
métodos.

---

## 8.5 Comparación con Java

En Java, las interfaces son un constructo específico, declarado con `interface`. Una clase puede `implements` varias
interfaces y `extends` una sola clase.

En Dart, el modelo es más simple porque:

- Toda clase se convierte automáticamente en interfaz.
- La diferencia entre herencia y contrato se resuelve con dos palabras clave: `extends` y `implements`.
- Se evita la duplicación conceptual de tener que aprender un constructo adicional.

No obstante, la flexibilidad de Dart exige disciplina: el desarrollador debe tener claro cuándo busca reutilizar
comportamiento (`extends`) y cuándo solo establecer un contrato (`implements`).

---

## Conclusión

Las interfaces en Dart representan un mecanismo elegante y potente para expresar contratos:

- Con `implements` se logra independencia total de implementación, garantizando solo la forma pública.
- Con `extends` se hereda tanto contrato como código, facilitando la reutilización.
- Dart permite implementar múltiples interfaces de manera natural, sin recurrir a herencia múltiple.

Este modelo aporta gran flexibilidad y simplicidad conceptual, a la vez que mantiene la claridad necesaria para
construir sistemas complejos y modulares.