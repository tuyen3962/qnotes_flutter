// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'heart_measure.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HeartMeasure _$HeartMeasureFromJson(Map<String, dynamic> json) => HeartMeasure(
      id: json['id'] as int?,
      sys: json['sys'] as int?,
      dia: json['dia'] as int?,
      fluse: json['fluse'] as int?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$HeartMeasureToJson(HeartMeasure instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['sys'] = instance.sys;
  val['dia'] = instance.dia;
  val['fluse'] = instance.fluse;
  val['date'] = instance.date?.toIso8601String();
  return val;
}
