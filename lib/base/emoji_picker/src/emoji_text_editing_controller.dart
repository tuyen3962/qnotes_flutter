import 'package:flutter/widgets.dart';
import 'emoji_picker_utils.dart';

class EmojiTextEditingController extends TextEditingController {
  EmojiTextEditingController({String? text, required this.emojiStyle}) : super(text: text);

  final TextStyle emojiStyle;
  final _utils = EmojiPickerUtils();

  @override
  TextSpan buildTextSpan({required BuildContext context, TextStyle? style, required bool withComposing}) {
    if (!value.isComposingRangeValid || !withComposing) {
      return TextSpan(
          style: style, children: _utils.setEmojiTextStyle(text, emojiStyle: emojiStyle, parentStyle: style));
    }
    final composingStyle = style?.merge(const TextStyle(decoration: TextDecoration.underline)) ??
        const TextStyle(decoration: TextDecoration.underline);
    return TextSpan(
      style: style,
      children: <TextSpan>[
        TextSpan(children: _utils.setEmojiTextStyle(value.composing.textBefore(value.text), emojiStyle: emojiStyle)),
        TextSpan(
          style: composingStyle,
          children: _utils.setEmojiTextStyle(
            value.composing.textInside(value.text),
            emojiStyle: emojiStyle,
            parentStyle: composingStyle,
          ),
        ),
        TextSpan(children: _utils.setEmojiTextStyle(value.composing.textAfter(value.text), emojiStyle: emojiStyle)),
      ],
    );
  }
}
