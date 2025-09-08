enum Status { pending, approved, rejected }

enum Currency {
  usd(code: 'USD', symbol: '\$'),
  eur(code: 'EUR', symbol: '€'),
  gbp(code: 'GBP', symbol: '£');

  final String code;
  final String symbol;

  const Currency({required this.code, required this.symbol});

  String format(num amount) => '$symbol${amount.toStringAsFixed(2)}';
}

enum LogLevel {
  debug(10),
  info(20),
  warning(30),
  error(40);

  final int severity;

  const LogLevel(this.severity);

  bool get isSevere => severity >= 30;

  void log(String message) {
    // Ejemplo sencillo de salida por consola
    print('[$name] $message');
  }
}

// enum define un conjunto cerrado de constantes
enum Color { red, green, blue }

// extension method añade métodos a un tipo existente sin modificarlo ni heredar
// 'on Color' significa que los métodos se adjuntan al tipo Color
// Solo añade comportamiento adicional
extension ColorHex on Color {
  String toHex() {
    switch (this) {
      case Color.red:
        return '#FF0000';
      case Color.green:
        return '#00FF00';
      case Color.blue:
        return '#0000FF';
    }
  }
}

enum Priority {
  low('L'),
  medium('M'),
  high('H');

  final String code;

  const Priority(this.code);

  static Priority fromCode(String code) =>
      Priority.values.firstWhere((p) => p.code == code);
}

void main() {
  print("Enums Simples: ${Status.values}");
  separador();
  print('Enums con valores asociados: ');
  print(Currency.values);
  print(Currency.usd.code);
  print(Currency.usd.symbol);
  print(Currency.usd.format(12.5));
  print(Currency.usd.name);
  separador();
  print('Enums con getters y métodos: ');
  print(LogLevel.error.isSevere);
  LogLevel.debug.log("Esto falta debugear xd");
  separador();
  final mensaje1 = mensaje(Status.approved);
  print(mensaje1);
  separador();
  print(Priority.fromCode('L'));
}

String mensaje(Status s) => switch (s) {
  Status.pending => 'Pendiente',
  Status.approved => 'Aprobado',
  Status.rejected => 'Rechazado',
};

void separador() {
  print('-------------------------------------');
}
