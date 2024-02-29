import 'package:flutter/material.dart';

import '../../emoji_picker_app.dart';

mixin SkinToneOverlayStateMixin<T extends StatefulWidget> on State<T> {
  OverlayEntry? _overlay;

  void closeSkinToneOverlay() {
    _overlay?.remove();
    _overlay = null;
  }

  void showSkinToneOverlay(
    Emoji emoji,
    double emojiSize,
    CategoryEmoji? categoryEmoji,
    int index,
    int skinToneCount,
    Config config,
    double scrollControllerOffset,
    double tabBarHeight,
    EmojiPickerUtils utils,
    OnEmojiSelected onEmojiSelected,
  ) {
    final skinTonesEmoji = SkinTone.values.map((skinTone) => utils.applySkinTone(emoji, skinTone)).toList();

    final positionRect = _calculateEmojiPosition(
      context,
      index,
      config.columns,
      skinToneCount,
      scrollControllerOffset,
      tabBarHeight,
      config.customSkinColorOverlayHorizontalOffset,
    );

    _overlay = OverlayEntry(
      builder: (context) => Positioned(
        left: positionRect.left,
        top: positionRect.top,
        child: Material(
          elevation: 4.0,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            color: config.skinToneDialogBgColor,
            child: Row(
              children: [
                _buildSkinToneEmoji(
                  emoji,
                  categoryEmoji,
                  positionRect.width,
                  emojiSize,
                  onEmojiSelected,
                  config,
                ),
                ...List.generate(
                  SkinTone.values.length,
                  (index) => _buildSkinToneEmoji(
                      skinTonesEmoji[index], categoryEmoji, positionRect.width, emojiSize, onEmojiSelected, config),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    if (_overlay != null) {
      Overlay.of(context).insert(_overlay!);
    } else {
      throw Exception('Chèn lớp phủ màu da không xác định');
    }
  }

  Widget _buildSkinToneEmoji(
    Emoji emoji,
    CategoryEmoji? categoryEmoji,
    double width,
    double emojiSize,
    OnEmojiSelected onEmojiSelected,
    Config config,
  ) =>
      SizedBox(
        width: width,
        height: width,
        child: EmojiCell.fromConfig(
          emoji: emoji,
          emojiSize: emojiSize,
          categoryEmoji: categoryEmoji,
          onEmojiSelected: onEmojiSelected,
          config: config,
        ),
      );

  Rect _calculateEmojiPosition(
    BuildContext context,
    int index,
    int columns,
    int skinToneCount,
    double scrollControllerOffset,
    double tabBarHeight,
    double? customSkinColorOverlayHorizontalOffset,
  ) {
    final row = index ~/ columns;
    final column = index % columns;

    final renderBox = context.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final emojiSpace = renderBox.size.width / columns;
    final topOffset = emojiSpace;
    final leftOffset = _getLeftOffset(emojiSpace, column, skinToneCount, columns);
    final dx = customSkinColorOverlayHorizontalOffset ?? offset.dx;
    final left = dx + column * emojiSpace + leftOffset;
    final top = tabBarHeight + offset.dy + row * emojiSpace - scrollControllerOffset - topOffset;

    return Rect.fromLTWH(left, top, emojiSpace, .0);
  }

  double _getLeftOffset(double emojiWidth, int column, int skinToneCount, int columns) {
    var remainingColumns = columns - (column + 1 + (skinToneCount ~/ 2));
    if (column >= 0 && column < 3) {
      return -1 * column * emojiWidth;
    } else if (remainingColumns < 0) {
      return -1 * ((skinToneCount ~/ 2 - 1) + -1 * remainingColumns) * emojiWidth;
    }
    return -1 * ((skinToneCount ~/ 2) * emojiWidth) + emojiWidth / 2;
  }
}
