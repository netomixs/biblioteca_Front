import 'package:json_annotation/json_annotation.dart';

part 'persona.g.dart';

@JsonSerializable()
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

  factory Persona.fromJson(Map<String, dynamic> json) => _$PersonaFromJson(json);
  Map<String, dynamic> toJson() => _$PersonaToJson(this);
}
