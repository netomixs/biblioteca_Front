// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResponse _$ApiResponseFromJson(Map<String, dynamic> json) => ApiResponse(
      code: (json['code'] as num).toInt(),
      codeDesc: json['codeDesc'] as String,
      isSuccess: json['isSuccess'] as bool,
      message: json['message'] as String,
      data: json['data'] as List<dynamic>?,
    );

Map<String, dynamic> _$ApiResponseToJson(ApiResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'codeDesc': instance.codeDesc,
      'isSuccess': instance.isSuccess,
      'message': instance.message,
      'data': instance.data,
    };
