import 'package:json_annotation/json_annotation.dart';
import 'persona.dart';

part 'autor.g.dart';

@JsonSerializable()
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

  factory Autor.fromJson(Map<String, dynamic> json) => _$AutorFromJson(json);
  Map<String, dynamic> toJson() => _$AutorToJson(this);
}
