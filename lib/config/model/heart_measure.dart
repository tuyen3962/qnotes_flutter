// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'heart_measure.g.dart';

@JsonSerializable()
class HeartMeasure {
  @JsonKey(includeIfNull: false)
  int? id;
  int? sys;
  int? dia;
  int? fluse;
  DateTime? date;

  HeartMeasure({
    this.id,
    this.sys,
    this.dia,
    this.fluse,
    this.date,
  });

  HeartMeasure copyWith({
    int? id,
    int? sys,
    int? dia,
    int? fluse,
    DateTime? date,
  }) {
    return HeartMeasure(
      id: id ?? this.id,
      sys: sys ?? this.sys,
      dia: dia ?? this.dia,
      fluse: fluse ?? this.fluse,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toJson() => _$HeartMeasureToJson(this);

  factory HeartMeasure.fromJson(Map<String, dynamic> json) =>
      _$HeartMeasureFromJson(json);
}
