enum TipoContenido {
  articulo(nombreLegible: "Artículo de Blog", icono: "📄", duracionEstimada: 5),
  video(nombreLegible: "Video educativo", icono: "🎥", duracionEstimada: 20),
  podcast(
    nombreLegible: "Episodio de Podcast",
    icono: '🎤',
    duracionEstimada: 30,
  );

  final String nombreLegible;
  final String icono;
  final int duracionEstimada;

  const TipoContenido({
    required this.nombreLegible,
    required this.icono,
    required this.duracionEstimada,
  });

  bool esPremium() => switch (this) {
    articulo => false,
    video => true,
    podcast => true,
  };
}

void mostrarResumenContenido({required List<TipoContenido> listaContenidos}) {
  for (TipoContenido tc in listaContenidos) {
    print('-------------------------------------------');
    print("Tipo de contenido: ${tc.name}");
    print('Nombre legible: ${tc.nombreLegible}');
    print('Ícono: ${tc.icono}');
    print('Duración estimada: ${tc.duracionEstimada}');
    print('Requiere suscripción: ${tc.esPremium() ? "Sí" : "No"}');
    print('-------------------------------------------\n');
  }
}
