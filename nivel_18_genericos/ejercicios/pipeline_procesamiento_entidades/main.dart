import 'entities/articulo_dominio.dart';
import 'logic/convertido_articulo.dart';
import 'logic/pipeline_procesador.dart';
import 'logic/validador.dart';
import 'models/articulo_dto.dart';

void main() {
  // 1) Convertidor
  final convertidorArticulo = ConvertidorArticulo();

  // 2) Validador con dos reglas
  final validador = Validador<ArticuloDominio>();
  validador.agregarRegla((articulo) => articulo.emailDeAutor.contains("@"));
  validador.agregarRegla((articulo) => articulo.subtitulo.isNotEmpty);

  // 3) Pipeline
  final pipeline = PipelineProcesador<ArticuloDTO, ArticuloDominio>(
    convertidor: convertidorArticulo,
    validador: validador,
  );

  // 4) Dos DTO: uno válido y uno inválido
  final dtoValido = ArticuloDTO(
    tituloCompleto: "Genéricos en Dart - Una guía",
    autorEmail: "autor@correo.com",
    id: "art-1",
  );

  // Incluye el guion para no romper el split del convertidor;
  // el email carece de '@' para forzar fallo de validación.
  final dtoInvalido = ArticuloDTO(
    tituloCompleto: "Título sin subtítulo -",
    autorEmail: "email-invalido",
    id: "art-2",
  );

  // 5) Procesar ambos
  final (resultadoOk, erroresOk) = pipeline.procesar(dtoValido);
  final (resultadoFail, erroresFail) = pipeline.procesar(dtoInvalido);

  // 6) Desestructurar y mostrar resultados
  if (resultadoOk != null) {
    print(
      "Procesamiento OK (art-1): "
      'titulo="${resultadoOk.titulo}", '
      'subtitulo="${resultadoOk.subtitulo}", '
      'email="${resultadoOk.emailDeAutor}"',
    );
  } else {
    print("Procesamiento FALLÓ (art-1): ${erroresOk.join("; ")}");
  }

  if (resultadoFail != null) {
    print(
      "Procesamiento OK (art-2): "
      'titulo="${resultadoFail.titulo}", '
      'subtitulo="${resultadoFail.subtitulo}", '
      'email="${resultadoFail.emailDeAutor}"',
    );
  } else {
    print("Procesamiento FALLÓ (art-2): ${erroresFail.join("; ")}");
  }
}
