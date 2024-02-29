import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_persistent_keyboard_height/flutter_persistent_keyboard_height.dart';
import 'package:base_flutter_source/base/emoji_picker/emoji_picker_app.dart';
import 'package:base_flutter_source/base/gallery/asset_gallery_view.dart';
import 'package:base_flutter_source/base/gallery/base_gallery_controller.dart';
import 'package:base_flutter_source/base/gallery/view/sticker_view.dart';
import 'package:base_flutter_source/main.dart';

abstract class BaseGalleryPageState<S extends StatefulWidget,
        C extends BaseGalleryController> extends State<S>
    with WidgetsBindingObserver {
  bool isInitAnimation = false;
  double keyboardHeight = 0.0;

  late StreamSubscription<double> onKeyboardChangeSubscription;

  bool get isResizeToAvoidBottomInset => false;

  double get bottomPadding => 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    controller.onInit();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    controller.keyboardHeight =
        WidgetsBinding.instance.window.viewInsets.bottom;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final height = PersistentKeyboardHeight.of(context).keyboardHeight;
    if (!isInitAnimation && height > 0) {
      isInitAnimation = true;
      Future.delayed(const Duration(milliseconds: 1000)).then((value) =>
          keyboardHeight = PersistentKeyboardHeight.of(context).keyboardHeight);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    controller.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: isResizeToAvoidBottomInset,
      body: SafeArea(
        bottom: false,
        child: Stack(children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                buildAppbar(),
                Expanded(child: buildBody()),
                buildBottomButton(),
                ValueListenableBuilder(
                  valueListenable:
                      controller.galleryManager.keepKeyboardNotifier,
                  builder: (context, value, child) {
                    return SizedBox(
                      height: value ? keyboardHeight + bottomPadding : 0,
                    );
                  },
                ),
              ],
            ),
          ),
          AssetGalleryView(
            galleryManager: controller.galleryManager,
            scrollController: controller.scrollController,
            node: controller.textNode,
          ),
          ValueListenableBuilder(
            valueListenable: controller.galleryManager.stickerVisible,
            builder: (context, visible, child) => Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                height: visible ? keyboardHeight : 0,
                child: StickerView(onAddNewSticker: controller.addNewSticker),
              ),
            ),
          ),
          ValueListenableBuilder(
            valueListenable: controller.galleryManager.emojyVisible,
            builder: (context, visible, child) => Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.only(top: 8),
                height: visible ? keyboardHeight : 0,
                child: EmojiPicker(
                  onEmojiSelected: (category, emoji) {},
                  onBackspacePressed: () {},
                  textEditingController: controller.textEditController,
                  config: Config(
                    emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                    bgColor: appTheme.whiteText,
                    iconColorSelected: appTheme.fatherActiveColor,
                    backspaceColor: appTheme.fatherActiveColor,
                    indicatorColor: appTheme.fatherActiveColor,
                    columns: 8,
                  ),
                ),
              ),
            ),
          ),
          ...buildOtherBackgroundKeyboard(),
        ]),
      ),
    );
  }

  Widget buildAppbar() => const SizedBox();

  Widget buildBody() => const SizedBox();

  Widget buildBottomButton() => const SizedBox();

  List<Widget> buildOtherBackgroundKeyboard() => [];

  late final C controller = initGalleryController();

  C initGalleryController();
}
