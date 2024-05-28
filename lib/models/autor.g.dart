// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'autor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Autor _$AutorFromJson(Map<String, dynamic> json) => Autor(
      id: (json['id'] as num).toInt(),
      idPersona: (json['idPersona'] as num).toInt(),
      codigo: json['codigo'] as String,
      persona: Persona.fromJson(json['persona'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AutorToJson(Autor instance) => <String, dynamic>{
      'id': instance.id,
      'idPersona': instance.idPersona,
      'codigo': instance.codigo,
      'persona': instance.persona,
    };
