// Alias de tipo para mayor legibilidad
typedef Punto = ({int x, int y});
// Funciones que retornan records
(int, int) coordenadas() => (10, 20);

({String nombre, int edad}) crearPersona() => (nombre: "Ana", edad: 30);

// Usar records como parámetros
void imprimirPersona((String, int) persona) {
  print("Nombre: ${persona.$1}, Edad: ${persona.$2}");
}

// Funciones que operan con records nombrados
Punto mover(Punto p, int dx, int dy) => (x: p.x + dx, y: p.y + dy);

// Pattern matching con records nombrados
String cuadrante(Punto p) => switch (p) {
  (x: > 0, y: > 0) => "I",
  (x: < 0, y: > 0) => "II",
  (x: < 0, y: < 0) => "III",
  (x: > 0, y: < 0) => "IV",
  _ => "Ejes",
};

void main() {
  // 1) Creación y acceso
  final pos = (1, "texto", true);
  print(pos.$1); // 1
  print(pos.$2); // texto
  print(pos.$3); // true

  final nombrado = (x: 10, y: 20);
  print(nombrado.x); // 10
  print(nombrado.y); // 20

  final mixto = (1, 2, z: 3);
  print("${mixto.$1}, ${mixto.$2}, ${mixto.z}");

  // 2) Igualdad estructural
  print((x: 1, y: 2) == (x: 1, y: 2)); // true

  // 3) Desestructuración (patterns)
  var (cx, cy) = coordenadas();
  print("coordenadas: $cx, $cy");

  final (:nombre, :edad) = crearPersona();
  print("persona: $nombre, $edad");

  // 4) Como parámetros
  imprimirPersona(("Luis", 28));

  // 5) Alias de tipo y funciones con records
  Punto p = (x: -2, y: 5);
  print(cuadrante(p)); // II
  p = mover(p, 5, -10);
  print(p); // (x: 3, y: -5)

  // 6) Uso en colecciones (clave de mapa)
  final Map<Punto, String> cache = {};
  cache[(x: 1, y: 2)] = "A";
  print(cache[(x: 1, y: 2)]); // A

  // 7) Null safety en campos
  (String?, int) datos = (null, 42);
  print(datos.$1 ?? "sin nombre");
}
