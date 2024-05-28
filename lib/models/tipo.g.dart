// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tipo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tipo _$TipoFromJson(Map<String, dynamic> json) => Tipo(
      id: (json['id'] as num).toInt(),
      codigo: json['codigo'] as String,
      nombre: json['nombre'] as String,
    );

Map<String, dynamic> _$TipoToJson(Tipo instance) => <String, dynamic>{
      'id': instance.id,
      'codigo': instance.codigo,
      'nombre': instance.nombre,
    };
