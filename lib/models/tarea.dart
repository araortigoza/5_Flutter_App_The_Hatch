class Tarea {
  String titulo;
  String descripcion;
  DateTime fecha;
  bool completada;

  Tarea({
    required this.titulo,
    this.descripcion = '',
    required this.fecha,
    this.completada = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'titulo': titulo,
      'descripcion': descripcion,
      'fecha': fecha.toIso8601String(),
      'completada': completada,
    };
  }

  factory Tarea.fromJson(Map<String, dynamic> json) {
    return Tarea(
      titulo: json['titulo'],
      descripcion: json['descripcion'],
      fecha: DateTime.parse(json['fecha']),
      completada: json['completada'],
    );
  }
}
