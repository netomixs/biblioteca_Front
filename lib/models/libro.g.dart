// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'libro.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Libro _$LibroFromJson(Map<String, dynamic> json) => Libro(
      id: (json['id'] as num).toInt(),
      isbn: json['isbn'] as String,
      titulo: json['titulo'] as String,
      descripcion: json['descripcion'] as String,
      fechaPublicacion: json['fechaPublicacion'] as String,
      fechaAdquicicion: json['fechaAdquicicion'] as String,
      existencias: (json['existencias'] as num).toInt(),
      esPrestable: (json['esPrestable'] as num).toInt(),
      imagen: json['imagen'] as String,
      idTipo: (json['idTipo'] as num).toInt(),
      idEditorial: (json['idEditorial'] as num).toInt(),
      codigo: json['codigo'] as String,
      genero: (json['genero'] as List<dynamic>)
          .map((e) => Genero.fromJson(e as Map<String, dynamic>))
          .toList(),
      autor: (json['autor'] as List<dynamic>)
          .map((e) => Autor.fromJson(e as Map<String, dynamic>))
          .toList(),
      tipo: Tipo.fromJson(json['tipo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LibroToJson(Libro instance) => <String, dynamic>{
      'id': instance.id,
      'isbn': instance.isbn,
      'titulo': instance.titulo,
      'descripcion': instance.descripcion,
      'fechaPublicacion': instance.fechaPublicacion,
      'fechaAdquicicion': instance.fechaAdquicicion,
      'existencias': instance.existencias,
      'esPrestable': instance.esPrestable,
      'imagen': instance.imagen,
      'idTipo': instance.idTipo,
      'idEditorial': instance.idEditorial,
      'codigo': instance.codigo,
      'genero': instance.genero,
      'autor': instance.autor,
      'tipo': instance.tipo,
    };
