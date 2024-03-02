// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:qnotes_flutter/config/model/employee.dart';

part 'employee_working_time.g.dart';

@JsonSerializable()
class EmployeeWorkingTime {
  @JsonKey(includeIfNull: false)
  int? id;
  @JsonKey(name: 'is_morning')
  bool? isMorning;
  @JsonKey(name: 'is_afternoon')
  bool? isAfternoon;
  @JsonKey(name: 'employee_id', includeFromJson: false, includeToJson: true)
  int? employeeId;
  @JsonKey(name: 'employee_id', includeFromJson: true, includeToJson: false)
  Employee? employee;
  @JsonKey(name: 'working_time')
  DateTime? workingTime;
  @JsonKey(name: 'created_at', includeToJson: false)
  DateTime? createdAt;
  String? note;

  EmployeeWorkingTime({
    this.id,
    this.isMorning,
    this.isAfternoon,
    this.employeeId,
    this.employee,
    this.workingTime,
    this.createdAt,
    this.note,
  });

  EmployeeWorkingTime copyWith({
    int? id,
    bool? isMorning,
    bool? isAfternoon,
    int? employeeId,
    Employee? employee,
    DateTime? workingTime,
    DateTime? createdAt,
    String? note,
  }) {
    return EmployeeWorkingTime(
      id: id ?? this.id,
      isMorning: isMorning ?? this.isMorning,
      isAfternoon: isAfternoon ?? this.isAfternoon,
      employeeId: employeeId ?? this.employeeId,
      employee: employee ?? this.employee,
      workingTime: workingTime ?? this.workingTime,
      createdAt: createdAt ?? this.createdAt,
      note: note ?? this.note,
    );
  }

  Map<String, dynamic> toJson() => _$EmployeeWorkingTimeToJson(this);

  factory EmployeeWorkingTime.fromJson(Map<String, dynamic> json) =>
      _$EmployeeWorkingTimeFromJson(json);
}
