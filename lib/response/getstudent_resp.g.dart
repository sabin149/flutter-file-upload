// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getstudent_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseGetStudent _$ResponseGetStudentFromJson(Map<String, dynamic> json) =>
    ResponseGetStudent(
      success: json['success'] as bool,
      data: (json['data'] as List<dynamic>)
          .map((e) => Student.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResponseGetStudentToJson(ResponseGetStudent instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data.map((e) => e.toJson()).toList(),
    };
