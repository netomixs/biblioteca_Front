import 'package:json_annotation/json_annotation.dart';
class GenericListConverter<T> implements JsonConverter<List<T>, List<dynamic>> {
  const GenericListConverter(this.fromJsonT);

  final T Function(Object? json) fromJsonT;

  @override
  List<T> fromJson(List<dynamic> json) => json.map((e) => fromJsonT(e)).toList();

  @override
  List<dynamic> toJson(List<T> object) => object.map((e) => e).toList();
}