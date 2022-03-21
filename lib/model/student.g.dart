// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Student _$StudentFromJson(Map<String, dynamic> json) => Student(
      id: json['_id'] as String?,
      fullname: json['fullname'] as String?,
      age: json['age'] as int?,
      gender: json['gender'] as String?,
      address: json['address'] as String?,
      photo: json['photo'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$StudentToJson(Student instance) => <String, dynamic>{
      '_id': instance.id,
      'fullname': instance.fullname,
      'age': instance.age,
      'gender': instance.gender,
      'address': instance.address,
      'photo': instance.photo,
      'createdAt': instance.createdAt,
    };
