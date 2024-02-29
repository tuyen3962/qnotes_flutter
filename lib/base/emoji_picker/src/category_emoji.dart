import 'emoji.dart';
import 'emoji_picker.dart';

class CategoryEmoji {
  const CategoryEmoji(this.category, this.emoji);

  final Category category;
  final List<Emoji> emoji;

  CategoryEmoji copyWith({Category? category, List<Emoji>? emoji}) {
    return CategoryEmoji(
      category ?? this.category,
      emoji ?? this.emoji,
    );
  }
}
