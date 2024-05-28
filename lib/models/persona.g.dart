// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'persona.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Persona _$PersonaFromJson(Map<String, dynamic> json) => Persona(
      id: (json['id'] as num).toInt(),
      nombre: json['nombre'] as String,
      apellidoP: json['apellidoP'] as String,
      apellidoM: json['apellidoM'] as String,
      nacimiento: json['nacimiento'] as String,
      sexo: json['sexo'] as String,
    );

Map<String, dynamic> _$PersonaToJson(Persona instance) => <String, dynamic>{
      'id': instance.id,
      'nombre': instance.nombre,
      'apellidoP': instance.apellidoP,
      'apellidoM': instance.apellidoM,
      'nacimiento': instance.nacimiento,
      'sexo': instance.sexo,
    };
