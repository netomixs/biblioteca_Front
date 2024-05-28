import 'package:json_annotation/json_annotation.dart';
 
part 'api_response.g.dart';

@JsonSerializable()
class ApiResponse {
  final int code;
  final String codeDesc;
  final bool isSuccess;
  final String message;
 
  final List<dynamic>? data;

  ApiResponse({
    required this.code,
    required this.codeDesc,
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) => _$ApiResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);
}