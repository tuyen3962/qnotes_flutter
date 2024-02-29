// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Employee _$EmployeeFromJson(Map<String, dynamic> json) => Employee(
      id: json['id'] as int?,
      fullName: json['full_name'] as String? ?? '',
      avatarUrl: json['avatar_url'] as String? ?? '',
      phoneNumber: json['phone'] as String? ?? '',
      dateOfBirth: json['date_of_birth'] == null
          ? null
          : DateTime.parse(json['date_of_birth'] as String),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$EmployeeToJson(Employee instance) => <String, dynamic>{
      'full_name': instance.fullName,
      'avatar_url': instance.avatarUrl,
      'phone': instance.phoneNumber,
      'date_of_birth': instance.dateOfBirth?.toIso8601String(),
    };
