import 'dart:math';

import 'package:flutter/material.dart';

import '../emoji_picker_app.dart';
import 'widget/emoji_picker_internal_utils.dart';
import 'widget/recent_emoji.dart';

class EmojiPickerUtils {
  factory EmojiPickerUtils() {
    return _singleton;
  }

  EmojiPickerUtils._internal();

  static final EmojiPickerUtils _singleton = EmojiPickerUtils._internal();
  final List<Emoji> _allAvailableEmojiEntities = [];
  final _emojiRegExp = RegExp(r'(\p{So})', unicode: true);

  Future<List<RecentEmoji>> getRecentEmojis() async {
    return EmojiPickerInternalUtils().getRecentEmojis();
  }

  Future<List<Emoji>> searchEmoji(String keyword, List<CategoryEmoji> data,
      {bool checkPlatformCompatibility = true}) async {
    if (keyword.isEmpty) return [];

    if (_allAvailableEmojiEntities.isEmpty) {
      final emojiPickerInternalUtils = EmojiPickerInternalUtils();

      final availableCategoryEmoji =
          checkPlatformCompatibility ? await emojiPickerInternalUtils.filterUnsupported(data) : data;

      for (var emojis in availableCategoryEmoji) {
        _allAvailableEmojiEntities.addAll(emojis.emoji);
      }
    }

    return _allAvailableEmojiEntities
        .where(
          (emoji) => emoji.name.toLowerCase().contains(keyword.toLowerCase()),
        )
        .toList();
  }

  Future<void> addEmojiToRecentlyUsed({
    required GlobalKey<EmojiPickerState> key,
    required Emoji emoji,
    Config config = const Config(),
  }) async {
    return EmojiPickerInternalUtils()
        .addEmojiToRecentlyUsed(emoji: emoji, config: config)
        .then((recentEmojiList) => key.currentState?.updateRecentEmoji(recentEmojiList));
  }

  List<InlineSpan> setEmojiTextStyle(String text, {required TextStyle emojiStyle, TextStyle? parentStyle}) {
    final finalEmojiStyle = parentStyle == null ? emojiStyle : parentStyle.merge(emojiStyle);
    final matches = _emojiRegExp.allMatches(text).toList();
    final spans = <InlineSpan>[];
    var cursor = 0;
    for (final match in matches) {
      spans
        ..add(TextSpan(text: text.substring(cursor, match.start)))
        ..add(
          TextSpan(
            text: text.substring(match.start, match.end),
            style: finalEmojiStyle,
          ),
        );
      cursor = match.end;
    }
    spans.add(TextSpan(text: text.substring(cursor, text.length)));
    return spans;
  }

  Emoji applySkinTone(Emoji emoji, String color) {
    final codeUnits = emoji.emoji.codeUnits;
    var result = List<int>.empty(growable: true)
      ..addAll(codeUnits.sublist(0, min(codeUnits.length, 2)))
      ..addAll(color.codeUnits);
    if (codeUnits.length >= 2) {
      result.addAll(codeUnits.sublist(2));
    }
    return emoji.copyWith(emoji: String.fromCharCodes(result));
  }

  Future<void> clearRecentEmojis({required GlobalKey<EmojiPickerState> key}) async {
    return await EmojiPickerInternalUtils()
        .clearRecentEmojisInLocalStorage()
        .then((_) => key.currentState?.updateRecentEmoji([], refresh: true));
  }
}
