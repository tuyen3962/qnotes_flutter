import 'package:flutter/material.dart';

class CategoryIcons {
  const CategoryIcons({
    this.recentIcon = Icons.access_time,
    this.smileyIcon = Icons.tag_faces,
    this.animalIcon = Icons.pets,
    this.foodIcon = Icons.fastfood,
    this.activityIcon = Icons.directions_run,
    this.travelIcon = Icons.location_city,
    this.objectIcon = Icons.lightbulb_outline,
    this.symbolIcon = Icons.emoji_symbols,
    this.flagIcon = Icons.flag,
  });

  /// Icon for [Category.RECENT]
  final IconData recentIcon;

  /// Icon for [Category.SMILEYS]
  final IconData smileyIcon;

  /// Icon for [Category.ANIMALS]
  final IconData animalIcon;

  /// Icon for [Category.FOODS]
  final IconData foodIcon;

  /// Icon for [Category.ACTIVITIES]
  final IconData activityIcon;

  /// Icon for [Category.TRAVEL]
  final IconData travelIcon;

  /// Icon for [Category.OBJECTS]
  final IconData objectIcon;

  /// Icon for [Category.SYMBOLS]
  final IconData symbolIcon;

  /// Icon for [Category.FLAGS]
  final IconData flagIcon;
}
