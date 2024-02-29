import '../emoji_picker_app.dart';

class EmojiViewState {
  EmojiViewState(
    this.categoryEmoji,
    this.onEmojiSelected,
    this.onBackspacePressed,
  );

  final List<CategoryEmoji> categoryEmoji;
  final OnEmojiSelected onEmojiSelected;
  final OnBackspacePressed? onBackspacePressed;
}
