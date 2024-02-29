import 'package:flutter/material.dart';

@immutable
class Emoji {
  const Emoji(this.emoji, this.name, {this.hasSkinTone = false});

  final String emoji;

  final String name;

  final bool hasSkinTone;

  @override
  String toString() {
    return 'Emoji: $emoji, Name: $name, HasSkinTone: $hasSkinTone';
  }

  static Emoji fromJson(Map<String, dynamic> json) {
    return Emoji(
      json['emoji'] as String,
      json['name'] as String,
      hasSkinTone: json['hasSkinTone'] != null ? json['hasSkinTone'] as bool : false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'emoji': emoji,
      'name': name,
      'hasSkinTone': hasSkinTone,
    };
  }

  Emoji copyWith({String? name, String? emoji, bool? hasSkinTone}) {
    return Emoji(
      emoji ?? this.emoji,
      name ?? this.name,
      hasSkinTone: hasSkinTone ?? this.hasSkinTone,
    );
  }
}
