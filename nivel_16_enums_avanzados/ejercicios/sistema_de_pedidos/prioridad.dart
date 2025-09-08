import 'pedido.dart';

enum Prioridad {
  L(code: "Baja"),
  M(code: "Media"),
  H(code: "Alta");

  final String code;

  const Prioridad({required this.code});

  bool get esSevera => code == H.code;

  String prioridadToJson(Pedido p) => p.name;

  static Prioridad fromCode(String code) {
    return Prioridad.values.firstWhere((c) => c.code == code);
  }
}

extension EmojiPrioridad on Prioridad {
  String toEmoji() {
    switch (this) {
      case Prioridad.L:
        return "😄";
      case Prioridad.M:
        return "😬";
      case Prioridad.H:
        return "😨";
    }
  }
}

extension ColorPrioridad on Prioridad {
  String toColorName() => switch (this) {
    Prioridad.L => "yellow",
    Prioridad.M => "orange",
    Prioridad.H => 'red',
  };
}
