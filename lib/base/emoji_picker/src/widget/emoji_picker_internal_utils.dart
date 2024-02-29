import 'dart:convert';
import 'dart:io';
import 'dart:math';

import '../../emoji_picker_app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'recent_emoji.dart';

const initVal = 1;

class EmojiPickerInternalUtils {
  static const _platform = MethodChannel('emoji_picker_app');

  Future<CategoryEmoji> _getAvailableEmojis(CategoryEmoji category) async {
    var available = (await _platform.invokeListMethod<bool>(
        'getSupportedEmojis', {'source': category.emoji.map((e) => e.emoji).toList(growable: false)}))!;

    return category.copyWith(emoji: [
      for (int i = 0; i < available.length; i++)
        if (available[i]) category.emoji[i]
    ]);
  }

  Future<List<CategoryEmoji>> filterUnsupported(List<CategoryEmoji> data) async {
    if (kIsWeb || !Platform.isAndroid) {
      return data;
    }
    final futures = [for (final cat in data) _getAvailableEmojis(cat)];
    return await Future.wait(futures);
  }

  Future<List<RecentEmoji>> getRecentEmojis() async {
    final prefs = await SharedPreferences.getInstance();
    var emojiJson = prefs.getString('recent');
    if (emojiJson == null) {
      return [];
    }
    var json = jsonDecode(emojiJson) as List<dynamic>;
    return json.map<RecentEmoji>(RecentEmoji.fromJson).toList();
  }

  Future<List<RecentEmoji>> addEmojiToRecentlyUsed({required Emoji emoji, Config config = const Config()}) async {
    if (emoji.hasSkinTone) {
      emoji = removeSkinTone(emoji);
    }
    var recentEmoji = await getRecentEmojis();
    var recentEmojiIndex = recentEmoji.indexWhere((element) => element.emoji.emoji == emoji.emoji);
    if (recentEmojiIndex != -1) {
      recentEmoji.removeAt(recentEmojiIndex);
    }

    recentEmoji.insert(0, RecentEmoji(emoji, initVal));

    recentEmoji = recentEmoji.sublist(0, min(config.recentsLimit, recentEmoji.length));

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('recent', jsonEncode(recentEmoji));

    return recentEmoji;
  }

  Future<List<RecentEmoji>> addEmojiToPopularUsed({required Emoji emoji, Config config = const Config()}) async {
    if (emoji.hasSkinTone) {
      emoji = removeSkinTone(emoji);
    }
    var recentEmoji = await getRecentEmojis();
    var recentEmojiIndex = recentEmoji.indexWhere((element) => element.emoji.emoji == emoji.emoji);
    if (recentEmojiIndex != -1) {
      recentEmoji[recentEmojiIndex].counter++;
    } else if (recentEmoji.length == config.recentsLimit && config.replaceEmojiOnLimitExceed) {
      recentEmoji[recentEmoji.length - 1] = RecentEmoji(emoji, initVal);
    } else {
      recentEmoji.add(RecentEmoji(emoji, initVal));
    }

    recentEmoji.sort((a, b) => b.counter - a.counter);

    recentEmoji = recentEmoji.sublist(0, min(config.recentsLimit, recentEmoji.length));

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('recent', jsonEncode(recentEmoji));

    return recentEmoji;
  }

  Future<void> clearRecentEmojisInLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('recent', jsonEncode([]));
  }

  Emoji removeSkinTone(Emoji emoji) {
    return emoji.copyWith(
      emoji: emoji.emoji.replaceFirst(
        RegExp(SkinTone.values.join('|')),
        '',
      ),
    );
  }
}
