import 'constants/tipo_contenido.dart';

void main() {
  List<TipoContenido> listaDeContenidos = [
    TipoContenido.podcast,
    TipoContenido.video,
    TipoContenido.articulo,
  ];

  mostrarResumenContenido(listaContenidos: listaDeContenidos);
}
