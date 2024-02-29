import '../emoji.dart';

class RecentEmoji {
  RecentEmoji(this.emoji, this.counter);

  final Emoji emoji;

  int counter = 0;

  static RecentEmoji fromJson(dynamic json) {
    return RecentEmoji(
      Emoji.fromJson(json['emoji'] as Map<String, dynamic>),
      json['counter'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'emoji': emoji,
        'counter': counter,
      };
}
