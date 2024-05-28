import 'package:json_annotation/json_annotation.dart';

part 'tipo.g.dart';

@JsonSerializable()
class Tipo {
  final int id;
  final String codigo;
  final String nombre;

  Tipo({
    required this.id,
    required this.codigo,
    required this.nombre,
  });

  factory Tipo.fromJson(Map<String, dynamic> json) => _$TipoFromJson(json);
  Map<String, dynamic> toJson() => _$TipoToJson(this);
}
