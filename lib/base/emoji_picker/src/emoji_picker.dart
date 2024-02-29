import 'category_emoji.dart';
import 'config.dart';
import 'widget/default_emoji_picker_view.dart';
import 'default_emoji_set.dart';
import 'emoji.dart';
import 'widget/emoji_picker_internal_utils.dart';
import 'emoji_view_state.dart';
import 'widget/recent_emoji.dart';
import 'recent_tab_behavior.dart';
import 'package:flutter/material.dart';

enum Category {
  RECENT,

  SMILEYS,

  ANIMALS,

  FOODS,

  ACTIVITIES,

  TRAVEL,

  OBJECTS,

  SYMBOLS,

  FLAGS,
}

extension CategoryExtension on Category {
  String get name {
    switch (this) {
      case Category.RECENT:
        return 'recent';
      case Category.SMILEYS:
        return 'smileys';
      case Category.ANIMALS:
        return 'animals';
      case Category.FOODS:
        return 'foods';
      case Category.ACTIVITIES:
        return 'activities';
      case Category.TRAVEL:
        return 'travel';
      case Category.OBJECTS:
        return 'objects';
      case Category.SYMBOLS:
        return 'symbols';
      case Category.FLAGS:
        return 'flags';
    }
  }
}

enum ButtonMode {
  NONE,

  MATERIAL,

  CUPERTINO
}

const kSkinToneCount = 6;

typedef void OnEmojiSelected(Category? category, Emoji emoji);

typedef void OnSkinToneDialogRequested(Emoji emoji, double emojiSize, CategoryEmoji? categoryEmoji, int index);

typedef void OnBackspacePressed();

typedef EmojiViewBuilder = Widget Function(Config config, EmojiViewState state);

class EmojiPicker extends StatefulWidget {
  const EmojiPicker({
    Key? key,
    this.textEditingController,
    this.onEmojiSelected,
    this.onBackspacePressed,
    this.config = const Config(),
    this.customWidget,
  }) : super(key: key);

  final EmojiViewBuilder? customWidget;
  final TextEditingController? textEditingController;
  final OnEmojiSelected? onEmojiSelected;
  final OnBackspacePressed? onBackspacePressed;
  final Config config;

  @override
  EmojiPickerState createState() => EmojiPickerState();
}

class EmojiPickerState extends State<EmojiPicker> {
  final List<CategoryEmoji> _categoryEmoji = List.empty(growable: true);
  List<RecentEmoji> _recentEmoji = List.empty(growable: true);
  late EmojiViewState _state;

  bool _loaded = false;

  final _emojiPickerInternalUtils = EmojiPickerInternalUtils();

  void updateRecentEmoji(List<RecentEmoji> recentEmoji, {bool refresh = false}) {
    _recentEmoji = recentEmoji;
    _categoryEmoji[0] = _categoryEmoji[0].copyWith(emoji: _recentEmoji.map((e) => e.emoji).toList());
    if (mounted && refresh) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _updateEmojis();
  }

  @override
  void didUpdateWidget(covariant EmojiPicker oldWidget) {
    if (oldWidget.config != widget.config) {
      _loaded = false;
      _updateEmojis();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) {
      return widget.config.loadingIndicator;
    }
    return widget.customWidget == null
        ? DefaultEmojiPickerView(widget.config, _state)
        : widget.customWidget!(widget.config, _state);
  }

  void _onBackspacePressed() {
    if (widget.textEditingController != null) {
      final controller = widget.textEditingController!;

      final text = controller.value.text;
      var cursorPosition = controller.selection.base.offset;

      if (cursorPosition < 0) {
        controller.selection = TextSelection(
          baseOffset: controller.text.length,
          extentOffset: controller.text.length,
        );
        cursorPosition = controller.selection.base.offset;
      }

      if (cursorPosition >= 0) {
        final selection = controller.value.selection;
        final newTextBeforeCursor = selection.textBefore(text).characters.skipLast(1).toString();
        print(newTextBeforeCursor);
        controller
          ..text = newTextBeforeCursor + selection.textAfter(text)
          ..selection = TextSelection.fromPosition(TextPosition(offset: newTextBeforeCursor.length));
      }
    }

    widget.onBackspacePressed?.call();
  }

  // Add recent emoji handling to tap listener
  OnEmojiSelected _getOnEmojiListener() {
    return (category, emoji) {
      if (widget.config.recentTabBehavior == RecentTabBehavior.POPULAR) {
        _emojiPickerInternalUtils.addEmojiToPopularUsed(emoji: emoji, config: widget.config).then((newRecentEmoji) => {
              updateRecentEmoji(newRecentEmoji, refresh: category != Category.RECENT),
            });
      } else if (widget.config.recentTabBehavior == RecentTabBehavior.RECENT) {
        _emojiPickerInternalUtils.addEmojiToRecentlyUsed(emoji: emoji, config: widget.config).then((newRecentEmoji) => {
              updateRecentEmoji(newRecentEmoji, refresh: category != Category.RECENT),
            });
      }

      if (widget.textEditingController != null) {
        final controller = widget.textEditingController!;
        final text = controller.text;
        final selection = controller.selection;
        final cursorPosition = controller.selection.base.offset;

        if (cursorPosition < 0) {
          controller.text += emoji.emoji;
          widget.onEmojiSelected?.call(category, emoji);
          return;
        }

        final newText = text.replaceRange(selection.start, selection.end, emoji.emoji);
        final emojiLength = emoji.emoji.length;
        controller
          ..text = newText
          ..selection = selection.copyWith(
            baseOffset: selection.start + emojiLength,
            extentOffset: selection.start + emojiLength,
          );
      }

      widget.onEmojiSelected?.call(category, emoji);
    };
  }

  Future<void> _updateEmojis() async {
    _categoryEmoji.clear();
    if ([RecentTabBehavior.RECENT, RecentTabBehavior.POPULAR].contains(widget.config.recentTabBehavior)) {
      _recentEmoji = await _emojiPickerInternalUtils.getRecentEmojis();
      final recentEmojiMap = _recentEmoji.map((e) => e.emoji).toList();
      _categoryEmoji.add(CategoryEmoji(Category.RECENT, recentEmojiMap));
    }
    final data = widget.config.emojiSet ?? defaultEmojiSet;
    _categoryEmoji.addAll(data);
    // widget.config.checkPlatformCompatibility ? await _emojiPickerInternalUtils.filterUnsupported(data) : data);
    _state = EmojiViewState(
      _categoryEmoji,
      _getOnEmojiListener(),
      widget.onBackspacePressed == null ? null : _onBackspacePressed,
    );
    if (mounted) {
      setState(() {
        _loaded = true;
      });
    }
  }
}
