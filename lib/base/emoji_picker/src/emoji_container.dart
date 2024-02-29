import 'package:flutter/material.dart';

import 'emoji_picker.dart';

class EmojiContainer extends StatelessWidget {
  const EmojiContainer({
    super.key,
    required this.color,
    required this.buttonMode,
    this.padding,
    required this.child,
  });

  final Color color;
  final ButtonMode buttonMode;
  final EdgeInsets? padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (buttonMode == ButtonMode.MATERIAL) {
      return Material(
        color: color,
        child: padding == null ? child : Padding(padding: padding!, child: child),
      );
    } else {
      return Container(
        color: color,
        padding: padding,
        child: child,
      );
    }
  }
}
