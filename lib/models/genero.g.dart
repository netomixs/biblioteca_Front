// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genero.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Genero _$GeneroFromJson(Map<String, dynamic> json) => Genero(
      id: (json['id'] as num).toInt(),
      codigo: json['codigo'] as String,
      nombre: json['nombre'] as String,
    );

Map<String, dynamic> _$GeneroToJson(Genero instance) => <String, dynamic>{
      'id': instance.id,
      'codigo': instance.codigo,
      'nombre': instance.nombre,
    };
