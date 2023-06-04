class Note {
  Note({this.id, this.titulo, this.contenido, this.fechaEdicion});

  int? id;
  String? titulo;
  String? contenido;
  String? fechaEdicion;

  static Note fromJson (Map<String, dynamic> json) {
    return Note(
      id: json['idNote'],
      titulo: json['titulo'],
      contenido: json['contenido'],
      fechaEdicion: json['fechaEdicion']
    );
  }

  Map<String, dynamic> convertToJson () {
    return {
      'titulo' : titulo,
      'contenido' : contenido,
    };
  }
}
