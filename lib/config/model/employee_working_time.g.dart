// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_working_time.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeWorkingTime _$EmployeeWorkingTimeFromJson(Map<String, dynamic> json) =>
    EmployeeWorkingTime(
      id: json['id'] as int?,
      isMorning: json['is_morning'] as bool?,
      isAfternoon: json['is_afternoon'] as bool?,
      employee: json['employee_id'] == null
          ? null
          : Employee.fromJson(json['employee_id'] as Map<String, dynamic>),
      workingTime: json['working_time'] == null
          ? null
          : DateTime.parse(json['working_time'] as String),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      note: json['note'] as String?,
    );

Map<String, dynamic> _$EmployeeWorkingTimeToJson(EmployeeWorkingTime instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['is_morning'] = instance.isMorning;
  val['is_afternoon'] = instance.isAfternoon;
  val['employee_id'] = instance.employeeId;
  val['working_time'] = instance.workingTime?.toIso8601String();
  val['note'] = instance.note;
  return val;
}
