import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:base_flutter_source/base/gallery/gallery_manager.dart';
import 'package:base_flutter_source/base/stream/base_stream_controller.dart';
import 'package:base_flutter_source/base/widget/base_controller.dart';

abstract class BaseGalleryController<S extends State<StatefulWidget>>
    extends BaseController<S> {
  final textNode = FocusNode();
  final textEditController = TextEditingController();
  final scrollController = ScrollController();
  late final galleryManager =
      GalleryManager(scrollController, maxItemAssetSelected);
  final keyboardHeightStream = BaseStreamController<double>(0);
  late StreamSubscription<double> onKeyboardChangeSubscription;
  late StreamSubscription<List<GalleryAsset>>
      _onGalleryAssetSelectedSubscription;

  bool _isClosed = false;

  bool get isClose => _isClosed;

  int get maxItemAssetSelected => 8;

  BaseGalleryController(super.state);

  @override
  void onInit() {
    super.onInit();
    onKeyboardChangeSubscription = keyboardHeightStream.stream
        .distinct()
        .debounceTime(const Duration(milliseconds: 100))
        .doOnData(print)
        .listen((value) {
      if (value > 0) {
        galleryManager.onChangeKeyboardVisible(true);
      } else {
        galleryManager.onChangeKeyboardVisible(false);
      }
    });
    _onGalleryAssetSelectedSubscription = galleryManager
        .assetSelectedStream.stream
        .listen(onUpdateGalleryAssetSelected);
  }

  void onHandleImageButton() {
    if (galleryManager.galleryVisible.value && textNode.hasFocus) {
      FocusScope.of(context).unfocus();
      return;
    }
    galleryManager.onSwitchVisibilityGallery();
    if (galleryManager.galleryVisible.value) {
      if (galleryManager.emojyVisible.value) {
        galleryManager.emojyVisible.value = false;
      }
      if (galleryManager.stickerVisible.value) {
        galleryManager.stickerVisible.value = false;
      }
      if (textNode.hasFocus) {
        FocusScope.of(context).unfocus();
        return;
      }
    }
    if (!galleryManager.galleryVisible.value && !textNode.hasFocus) {
      galleryManager.keepKeyboardNotifier.value = false;
    }
  }

  void disableAll() {
    galleryManager.onSwitchEmojy(isEnable: false);
    galleryManager.onSwitchVisibilitySticker(isEnable: false);
    galleryManager.chanegGalleryVisible(false);
    galleryManager.changeKeyboardVisibility(false);
  }

  void addNewSticker(String imageNetwork) {}

  void onHandleStickerImageButton() {
    if (galleryManager.stickerVisible.value && textNode.hasFocus) {
      FocusScope.of(context).unfocus();
      return;
    }
    galleryManager.onSwitchVisibilitySticker();
    if (galleryManager.stickerVisible.value) {
      if (galleryManager.emojyVisible.value) {
        galleryManager.emojyVisible.value = false;
      }
      if (galleryManager.galleryVisible.value) {
        galleryManager.galleryVisible.value = false;
      }
      if (textNode.hasFocus) {
        FocusScope.of(context).unfocus();
        return;
      }
    }
    if (!galleryManager.stickerVisible.value && !textNode.hasFocus) {
      galleryManager.keepKeyboardNotifier.value = false;
    }
  }

  void onHandleEmojyButton() {
    if (galleryManager.emojyVisible.value && textNode.hasFocus) {
      FocusScope.of(context).unfocus();
      return;
    }
    galleryManager.onSwitchEmojy();
    if (galleryManager.emojyVisible.value) {
      if (galleryManager.stickerVisible.value) {
        galleryManager.stickerVisible.value = false;
      }
      if (galleryManager.galleryVisible.value) {
        galleryManager.galleryVisible.value = false;
      }
      if (textNode.hasFocus) {
        FocusScope.of(context).unfocus();
        return;
      }
    }

    if (!galleryManager.emojyVisible.value && !textNode.hasFocus) {
      galleryManager.keepKeyboardNotifier.value = false;
    }
  }

  void onUpdateGalleryAssetSelected(List<GalleryAsset> assets);

  void onRemoveGalleryAsset(GalleryAsset galleryAsset) {
    galleryManager.onSelectAsset(galleryAsset);
  }

  set keyboardHeight(double value) {
    keyboardHeightStream.value =
        WidgetsBinding.instance.window.viewInsets.bottom;
  }

  @override
  void onDispose() {
    _isClosed = true;
    textEditController.dispose();
    keyboardHeightStream.dispose();
    onKeyboardChangeSubscription.cancel();
    textNode.dispose();
    _onGalleryAssetSelectedSubscription.cancel();
    super.onDispose();
  }
}
