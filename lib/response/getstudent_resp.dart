
import 'package:json_annotation/json_annotation.dart';
import '/model/student.dart';

part 'getstudent_resp.g.dart';

@JsonSerializable(explicitToJson: true)
class ResponseGetStudent{
  final bool success;
  
  final List<Student> data;

  ResponseGetStudent({
    required this.success,
    required this.data,
  });
  
  factory ResponseGetStudent.fromJson(Map<String, dynamic> json) =>
      _$ResponseGetStudentFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseGetStudentToJson(this);

}