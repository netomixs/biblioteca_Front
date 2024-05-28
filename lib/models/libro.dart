import 'package:json_annotation/json_annotation.dart';
import 'genero.dart';
import 'autor.dart';
import 'tipo.dart';

part 'libro.g.dart';

@JsonSerializable()
class Libro {
  final int id;
  final String isbn;
  final String titulo;
  final String descripcion;
  final String fechaPublicacion;
  final String fechaAdquicicion;
  final int existencias;
  final int esPrestable;
  final String imagen;
  final int idTipo;
  final int idEditorial;
  final String codigo;
  final List<Genero> genero;
  final List<Autor> autor;
  final Tipo tipo;

  Libro({
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
    required this.tipo,
  });

  factory Libro.fromJson(Map<String, dynamic> json) => _$LibroFromJson(json);
  Map<String, dynamic> toJson() => _$LibroToJson(this);
}
