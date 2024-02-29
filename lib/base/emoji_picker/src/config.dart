import 'dart:math';

import 'package:flutter/material.dart';

import 'category_emoji.dart';
import 'category_icons.dart';
import 'emoji_picker.dart';
import 'recent_tab_behavior.dart';

const DefaultNoRecentsWidget = Text(
  'Không có lịch sử gần đây',
  style: TextStyle(fontSize: 20, color: Colors.black26),
  textAlign: TextAlign.center,
);

class Config {
  const Config({
    this.columns = 7,
    this.emojiSizeMax = 32.0,
    this.verticalSpacing = 0,
    this.horizontalSpacing = 0,
    this.gridPadding = EdgeInsets.zero,
    this.initCategory = Category.RECENT,
    this.bgColor = const Color(0xFFEBEFF2),
    this.indicatorColor = Colors.blue,
    this.iconColor = Colors.grey,
    this.iconColorSelected = Colors.blue,
    this.backspaceColor = Colors.blue,
    this.skinToneDialogBgColor = Colors.white,
    this.skinToneIndicatorColor = Colors.grey,
    this.enableSkinTones = true,
    this.recentTabBehavior = RecentTabBehavior.RECENT,
    this.recentsLimit = 28,
    this.replaceEmojiOnLimitExceed = false,
    this.noRecents = DefaultNoRecentsWidget,
    this.loadingIndicator = const SizedBox.shrink(),
    this.tabIndicatorAnimDuration = kTabScrollDuration,
    this.categoryIcons = const CategoryIcons(),
    this.buttonMode = ButtonMode.MATERIAL,
    this.checkPlatformCompatibility = true,
    this.emojiSet,
    this.emojiTextStyle,
    this.customSkinColorOverlayHorizontalOffset,
  });

  final int columns;
  final double emojiSizeMax;
  final double verticalSpacing;
  final double horizontalSpacing;
  final Category initCategory;
  final Color bgColor;
  final Color indicatorColor;
  final Color iconColor;
  final Color iconColorSelected;
  final Color backspaceColor;
  final Color skinToneDialogBgColor;
  final Color skinToneIndicatorColor;
  final bool enableSkinTones;
  final RecentTabBehavior recentTabBehavior;
  final int recentsLimit;
  final Widget noRecents;
  final Widget loadingIndicator;
  final Duration tabIndicatorAnimDuration;
  final CategoryIcons categoryIcons;
  final ButtonMode buttonMode;
  final EdgeInsets gridPadding;
  final bool replaceEmojiOnLimitExceed;
  final bool checkPlatformCompatibility;
  final List<CategoryEmoji>? emojiSet;
  final TextStyle? emojiTextStyle;
  final double? customSkinColorOverlayHorizontalOffset;

  double getEmojiSize(double width) {
    final maxSize = width / columns;
    return min(maxSize, emojiSizeMax);
  }

  IconData getIconForCategory(Category category) {
    switch (category) {
      case Category.RECENT:
        return categoryIcons.recentIcon;
      case Category.SMILEYS:
        return categoryIcons.smileyIcon;
      case Category.ANIMALS:
        return categoryIcons.animalIcon;
      case Category.FOODS:
        return categoryIcons.foodIcon;
      case Category.TRAVEL:
        return categoryIcons.travelIcon;
      case Category.ACTIVITIES:
        return categoryIcons.activityIcon;
      case Category.OBJECTS:
        return categoryIcons.objectIcon;
      case Category.SYMBOLS:
        return categoryIcons.symbolIcon;
      case Category.FLAGS:
        return categoryIcons.flagIcon;
      default:
        throw Exception('Unsupported Category');
    }
  }

  @override
  bool operator ==(other) {
    return (other is Config) &&
        other.columns == columns &&
        other.emojiSizeMax == emojiSizeMax &&
        other.verticalSpacing == verticalSpacing &&
        other.horizontalSpacing == horizontalSpacing &&
        other.initCategory == initCategory &&
        other.bgColor == bgColor &&
        other.indicatorColor == indicatorColor &&
        other.iconColor == iconColor &&
        other.iconColorSelected == iconColorSelected &&
        other.backspaceColor == backspaceColor &&
        other.skinToneDialogBgColor == skinToneDialogBgColor &&
        other.skinToneIndicatorColor == skinToneIndicatorColor &&
        other.enableSkinTones == enableSkinTones &&
        other.recentTabBehavior == recentTabBehavior &&
        other.recentsLimit == recentsLimit &&
        other.noRecents == noRecents &&
        other.loadingIndicator == loadingIndicator &&
        other.tabIndicatorAnimDuration == tabIndicatorAnimDuration &&
        other.categoryIcons == categoryIcons &&
        other.buttonMode == buttonMode &&
        other.gridPadding == gridPadding &&
        other.replaceEmojiOnLimitExceed == replaceEmojiOnLimitExceed &&
        other.checkPlatformCompatibility == checkPlatformCompatibility &&
        other.emojiSet == emojiSet &&
        other.emojiTextStyle == emojiTextStyle &&
        other.customSkinColorOverlayHorizontalOffset == customSkinColorOverlayHorizontalOffset;
  }

  @override
  int get hashCode =>
      columns.hashCode ^
      emojiSizeMax.hashCode ^
      verticalSpacing.hashCode ^
      horizontalSpacing.hashCode ^
      initCategory.hashCode ^
      bgColor.hashCode ^
      indicatorColor.hashCode ^
      iconColor.hashCode ^
      iconColorSelected.hashCode ^
      backspaceColor.hashCode ^
      skinToneDialogBgColor.hashCode ^
      skinToneIndicatorColor.hashCode ^
      enableSkinTones.hashCode ^
      recentTabBehavior.hashCode ^
      recentsLimit.hashCode ^
      noRecents.hashCode ^
      loadingIndicator.hashCode ^
      tabIndicatorAnimDuration.hashCode ^
      categoryIcons.hashCode ^
      buttonMode.hashCode ^
      gridPadding.hashCode ^
      replaceEmojiOnLimitExceed.hashCode ^
      checkPlatformCompatibility.hashCode ^
      (emojiSet?.hashCode ?? 0) ^
      (emojiTextStyle?.hashCode ?? 0) ^
      (customSkinColorOverlayHorizontalOffset?.hashCode ?? 0);
}
