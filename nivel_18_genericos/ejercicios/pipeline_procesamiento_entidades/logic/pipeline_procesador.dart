import '../entities/modelo.dart';
import '../interfaces/convertidor.dart';
import 'validador.dart';

class PipelineProcesador<E extends Modelo, S extends Modelo> {
  final Convertidor<E, S> convertidor;
  final Validador<S> validador;

  PipelineProcesador({
    required this.convertidor,
    required this.validador,
  });

  (S? resultado, List<String> errores) procesar(E entidad) {
    final convertido = convertidor.convertir(entidad);
    final valido = validador.esValido(convertido);

    if (valido) {
      return (convertido, <String>[]);
    } else {
      return (null, <String>['La validación falló para la entidad con ID: ${entidad.id}']);
    }
  }
}