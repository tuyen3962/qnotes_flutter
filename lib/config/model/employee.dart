// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

part 'employee.g.dart';

@JsonSerializable()
class Employee {
  @JsonKey(includeFromJson: true, includeToJson: false)
  int? id;
  @JsonKey(name: 'full_name', defaultValue: '')
  String? fullName;
  @JsonKey(name: 'avatar_url', defaultValue: '')
  String? avatarUrl;
  @JsonKey(name: 'phone', defaultValue: '')
  String? phoneNumber;
  @JsonKey(name: 'date_of_birth')
  DateTime? dateOfBirth;
  @JsonKey(name: 'created_at', includeToJson: false)
  DateTime? createdAt;

  @JsonKey(includeFromJson: false, includeToJson: false)
  File? imageFile;

  Employee({
    this.id,
    this.fullName,
    this.avatarUrl,
    this.phoneNumber,
    this.dateOfBirth,
    this.createdAt,
    this.imageFile,
  });

  Employee copyWith({
    int? id,
    String? fullName,
    String? avatarUrl,
    String? phoneNumber,
    DateTime? dateOfBirth,
    DateTime? createdAt,
    File? imageFile,
  }) {
    return Employee(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      createdAt: createdAt ?? this.createdAt,
      imageFile: imageFile ?? this.imageFile,
    );
  }

  Map<String, dynamic> toJson() => _$EmployeeToJson(this);

  factory Employee.fromJson(Map<String, dynamic> json) =>
      _$EmployeeFromJson(json);
}
