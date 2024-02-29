import 'package:flutter/material.dart';

import 'config.dart';
import 'emoji_view_state.dart';

abstract class EmojiPickerBuilder extends StatefulWidget {
  const EmojiPickerBuilder(
    this.config,
    this.state, {
    Key? key,
  }) : super(key: key);

  final Config config;
  final EmojiViewState state;
}
