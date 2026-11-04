// SE DEFINE LA CLASE PARA LAS TAREAS
class Tarea {
  String titulo; // SE DETERMINA AL TITULO DE LA TAREA COMO UN STRING
  String descripcion; // SE DETERMINA A LA DESCRIPCION DE LA TAREA COMO STRING
  DateTime fecha; // SE DETERMINA A LA FECHA EN FORMATO DATATIME (GUARDA TANTO LA FECHA COMO LA HORA)
  bool completada; // SE DETERMINA EL ESTADO DE LA TAREA CON BOOLEANOS

  // SE DECLARA EL CONSTRUCTOR DE LA CLASE
  Tarea({
    required this.titulo, // SE DECLARA A TITULO COMO OBLIGATORIO Y LO ASIGNA A TITULO
    this.descripcion = '', // ES OPCIONAL Y VA CON UN VALOR POR DEFAULT, EN ESTE CASO UN STRING VACIO
    required this.fecha, // SE DECLARA A LA FECHA COMO OBLIGATORIA Y LO ASIGNA A FECHA
    this.completada = false, // DECLARA CUALQUIER TAREA RECIEN HECHA CON FALSE
  });

  // CON MAP SE DECLARA QUE LA FUNCION DEVOLVERA UN MAPA (UN DICCIONARIO) CON KEYS STRINGS Y VALORES DE CUALQUIER TIPO(DYNAMIC)
  // EL METODO TOJSON() CONVIERTE CUALQUIER ONJETO AL FORMATO JSON
  Map<String, dynamic> toJson() {
    // SE RETORNA EL OBJETO CONVERTIDO A JSON
    return {
      'titulo': titulo,
      'descripcion': descripcion,
      'fecha': fecha.toIso8601String(),
      'completada': completada,
    };
  }

  // FACTORY SE UTILIZA PARA CUANDO SE NECESITA HACER UN PROCESO PREVIO
  // EN ESTE CASO CONVIERTE EL JSON LEIDO NUEVAMENTE EN UN OBJETO PARA QUE FLUTTER PUEDA ENTENDERLO
  factory Tarea.fromJson(Map<String, dynamic> json) {
    // SE RETORNA EL OBJETO PARA SER ENTENDIDO POR FLUTTER
    return Tarea(
      titulo: json['titulo'],
      descripcion: json['descripcion'],
      fecha: DateTime.parse(json['fecha']),
      completada: json['completada'],
    );
  }
}
