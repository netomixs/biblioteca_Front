class Book {
  final int id;
  final String isbn;
  final String titulo;
  final String descripcion;
  final String fechaPublicacion;
  final String fechaAdquicicion;
  final int existencias;
  final bool esPrestable;
  final String imagen;
  final int idTipo;
  final int idEditorial;
  final String codigo;
  final List<Genero> genero;
  final List<Autor> autor;

  Book({
    required this.id,
    required this.isbn,
    required this.titulo,
    required this.descripcion,
    required this.fechaPublicacion,
    required this.fechaAdquicicion,
    required this.existencias,
    required this.esPrestable,
    required this.imagen,
    required this.idTipo,
    required this.idEditorial,
    required this.codigo,
    required this.genero,
    required this.autor,
  });
   static Book mapToBook(dynamic map) {
    print( map['Id']);
    return Book(
      id: map['Id'],
      isbn: map['ISBN'],
      titulo: map['Titulo'],
      descripcion: map['Descripcion'],
      fechaPublicacion: map['Fecha_Publicacion'],
      fechaAdquicicion: map['Feha_Adquicicion'],
      existencias: map['Existencias'],
      esPrestable: map['Es_Prestable'] == 1,
      imagen: map['Imagen'],
      idTipo: map['Id_Tipo'],
      idEditorial: map['Id_Editorial'],
      codigo: map['Codigo'],
      genero: (map['genero'] as List)
          .map((g) => Genero(
                id: g['Id'],
                codigo: g['Codigo'],
                nombre: g['Nombre'],
              ))
          .toList(),
      autor: (map['autor'] as List)
          .map((a) => Autor(
                id: a['Id'],
                idPersona: a['Id_Persona'],
                codigo: a['Codigo'],
                persona: Persona(
                  id: a['persona']['Id'],
                  nombre: a['persona']['Nombre'],
                  apellidoP: a['persona']['Apellido_P'],
                  apellidoM: a['persona']['Apellido_M'],
                  nacimiento: a['persona']['Nacimiento'],
                  sexo: a['persona']['Sexo'],
                ),
              ))
          .toList(),
    );
  }
}

class Genero {
  final int id;
  final String codigo;
  final String nombre;

  Genero({
    required this.id,
    required this.codigo,
    required this.nombre,
  });
}

class Autor {
  final int id;
  final int idPersona;
  final String codigo;
  final Persona persona;

  Autor({
    required this.id,
    required this.idPersona,
    required this.codigo,
    required this.persona,
  });
}

class Persona {
  final int id;
  final String nombre;
  final String apellidoP;
  final String apellidoM;
  final String nacimiento;
  final String sexo;

  Persona({
    required this.id,
    required this.nombre,
    required this.apellidoP,
    required this.apellidoM,
    required this.nacimiento,
    required this.sexo,
  });

}
