import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'category_emoji.dart';
import 'config.dart';
import 'emoji.dart';
import 'emoji_picker.dart';
import 'widget/triangle_decoration.dart';

class EmojiCell extends StatelessWidget {
  const EmojiCell({
    super.key,
    required this.emoji,
    required this.emojiSize,
    this.categoryEmoji,
    required this.buttonMode,
    this.index = 0,
    required this.enableSkinTones,
    required this.textStyle,
    required this.skinToneIndicatorColor,
    this.onSkinToneDialogRequested,
    required this.onEmojiSelected,
  });

  EmojiCell.fromConfig({
    super.key,
    required this.emoji,
    required this.emojiSize,
    this.categoryEmoji,
    this.index = 0,
    required this.onEmojiSelected,
    this.onSkinToneDialogRequested,
    required Config config,
  })  : buttonMode = config.buttonMode,
        enableSkinTones = config.enableSkinTones,
        textStyle = config.emojiTextStyle,
        skinToneIndicatorColor = config.skinToneIndicatorColor;

  final Emoji emoji;
  final double emojiSize;
  final CategoryEmoji? categoryEmoji;
  final ButtonMode buttonMode;
  final int index;
  final bool enableSkinTones;
  final TextStyle? textStyle;
  final Color skinToneIndicatorColor;
  final OnSkinToneDialogRequested? onSkinToneDialogRequested;
  final OnEmojiSelected onEmojiSelected;

  Widget _buildButtonWidget({
    required VoidCallback onPressed,
    VoidCallback? onLongPressed,
    required Widget child,
  }) {
    if (buttonMode == ButtonMode.MATERIAL) {
      return InkWell(
        onTap: onPressed,
        onLongPress: onLongPressed,
        child: child,
      );
    }
    if (buttonMode == ButtonMode.CUPERTINO) {
      return GestureDetector(
        onLongPress: onLongPressed,
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: onPressed,
          child: child,
        ),
      );
    }
    return GestureDetector(
      onLongPress: onLongPressed,
      onTap: onPressed,
      child: child,
    );
  }

  Widget _buildEmoji() {
    final style = TextStyle(
      fontSize: emojiSize,
      backgroundColor: Colors.transparent,
    );
    final emojiText = Text(
      emoji.emoji,
      textScaleFactor: 1.0,
      style: textStyle == null ? style : textStyle!.merge(style),
    );

    return Center(
      child: emoji.hasSkinTone && enableSkinTones && onSkinToneDialogRequested != null
          ? Container(
              decoration: TriangleDecoration(color: skinToneIndicatorColor, size: 8.0),
              child: emojiText,
            )
          : emojiText,
    );
  }

  @override
  Widget build(BuildContext context) {
    onPressed() {
      onEmojiSelected(categoryEmoji?.category, emoji);
    }

    onLongPressed() {
      onSkinToneDialogRequested?.call(emoji, emojiSize, categoryEmoji, index);
    }

    return _buildButtonWidget(
      onPressed: onPressed,
      onLongPressed: onLongPressed,
      child: _buildEmoji(),
    );
  }
}
