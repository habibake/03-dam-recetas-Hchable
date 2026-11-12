class Resena {
  final int? id;
  final int recetaId;
  final String comentario;
  final double calificacion;

  const Resena({
    this.id,
    required this.recetaId,
    required this.comentario,
    required this.calificacion,
  });

  Map<String, Object?> toMap() {
    return {
      if (id != null) 'id': id,
      'recetaId': recetaId,
      'comentario': comentario,
      'calificacion': calificacion,
    };
  }

  factory Resena.fromMap(Map<String, Object?> mapa) {
    return Resena(
      id: mapa['id'] as int?,
      recetaId: mapa['recetaId'] as int,
      comentario: mapa['comentario'] as String,
      calificacion: (mapa['calificacion'] as num).toDouble(),
    );
  }
}