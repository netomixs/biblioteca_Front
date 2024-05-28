import 'package:json_annotation/json_annotation.dart';

part 'genero.g.dart';

@JsonSerializable()
class Genero {
  final int id;
  final String codigo;
  final String nombre;

  Genero({
    required this.id,
    required this.codigo,
    required this.nombre,
  });

  factory Genero.fromJson(Map<String, dynamic> json) => _$GeneroFromJson(json);
  Map<String, dynamic> toJson() => _$GeneroToJson(this);
}
