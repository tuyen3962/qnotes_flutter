import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:qnotes_flutter/base/stream/base_list_stream_controller.dart';

class GalleryManager {
  int page = 0;
  final size = 50;
  final ScrollController controller;
  final int maxAssetSelected;

  String currentId = 'isAll';
  List<GalleryAsset> galleryAssets = <GalleryAsset>[];
  Map<String, GalleryAssetPath> mapGalleryAsset = {};
  final galleryAssetUpdateNotifier = ValueNotifier(0);
  final totalAsset = ValueNotifier<int>(0);
  final keepKeyboardNotifier = ValueNotifier(false);
  final galleryVisible = ValueNotifier(false);
  final stickerVisible = ValueNotifier(false);
  final emojyVisible = ValueNotifier(false);
  final assetSelectedStream = BaseListStreamController<GalleryAsset>([]);
  final assetsIdSelected = <String>[];

  bool isGranted = true;

  GalleryAssetPath get currentAssetPath => mapGalleryAsset[currentId]!;

  GalleryManager(this.controller, this.maxAssetSelected) {
    initGallery();
    controller.addListener(onCheckLoadMore);
  }

  onChangeKeyboardVisible(bool isVisible) {
    if (isVisible) {
      keepKeyboardNotifier.value = true;
    } else {
      if (galleryVisible.value == false &&
          stickerVisible.value == false &&
          emojyVisible.value == false) {
        keepKeyboardNotifier.value = false;
      }
    }
  }

  onSwitchVisibilityGallery({bool? isEnable}) {
    if (isEnable != null) {
      galleryVisible.value = isEnable;
    } else {
      galleryVisible.value = !galleryVisible.value;
    }

    if (galleryVisible.value) {
      keepKeyboardNotifier.value = true;
    }
  }

  onSwitchVisibilitySticker({bool? isEnable}) {
    if (isEnable != null) {
      stickerVisible.value = isEnable;
    } else {
      stickerVisible.value = !stickerVisible.value;
    }

    if (stickerVisible.value) {
      keepKeyboardNotifier.value = true;
    }
  }

  onSwitchEmojy({bool? isEnable}) {
    if (isEnable != null) {
      emojyVisible.value = isEnable;
    } else {
      emojyVisible.value = !emojyVisible.value;
    }

    if (emojyVisible.value) {
      keepKeyboardNotifier.value = true;
    }
  }

  changeKeyboardVisibility(bool value) {
    keepKeyboardNotifier.value = value;
  }

  chanegGalleryVisible(bool value) {
    galleryVisible.value = value;
  }

  clearSelectedAssets() {
    assetsIdSelected.clear();
    assetSelectedStream.value = [];
    galleryAssetUpdateNotifier.value += 1;
  }

  onCheckLoadMore() {
    if (controller.offset >= controller.position.maxScrollExtent) {
      controller.removeListener(onCheckLoadMore);
      loadMore();
    }
  }

  loadMore() async {
    if (galleryAssets.length >= totalAsset.value) {
      return;
    }
    page += 1;
    final entities =
        await PhotoManager.getAssetListPaged(page: page, pageCount: size);
    galleryAssets.addAll(await Future.wait(entities.map(createGalleryAsset)));
    galleryAssetUpdateNotifier.value += 1;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (galleryAssets.length < totalAsset.value) {
        controller.addListener(onCheckLoadMore);
      }
    });
  }

  initGallery() async {
    final status = await PhotoManager.requestPermissionExtend();
    if (status == PermissionState.authorized) {
      final pathAssets = await PhotoManager.getAssetPathList();
      await Future.wait(pathAssets.map((path) async {
        final assetPath = await initGalleryAssetPath(path);
        mapGalleryAsset.putIfAbsent(path.id, () => assetPath);
      }));
      totalAsset.value = currentAssetPath.totalAsset;
      galleryAssets = currentAssetPath.assets;
      galleryAssetUpdateNotifier.value += 1;
    } else {
      isGranted = false;
    }
  }

  onSelectAsset(GalleryAsset galleryAsset) {
    final assetSelected = assetSelectedStream.value;
    if (assetsIdSelected.contains(galleryAsset.assetEntity.id)) {
      assetsIdSelected.remove(galleryAsset.assetEntity.id);
      assetSelected.removeWhere(
          (element) => element.assetEntity.id == galleryAsset.assetEntity.id);
    } else {
      if (assetSelected.length >= maxAssetSelected) {
        return;
      }
      assetsIdSelected.add(galleryAsset.assetEntity.id);
      assetSelected.add(galleryAsset);
    }
    assetSelectedStream.value = assetSelected;
    galleryAssetUpdateNotifier.value += 1;
  }

  int indexSelectedItem(GalleryAsset asset) {
    return assetsIdSelected.indexWhere((e) => e == asset.assetEntity.id);
  }

  onChangeAssetPath(String id) {
    currentId = id;
    totalAsset.value = currentAssetPath.totalAsset;
    galleryAssets = currentAssetPath.assets;
    galleryAssetUpdateNotifier.value += 1;
  }

  Future<GalleryAssetPath> initGalleryAssetPath(
      AssetPathEntity assetPathEntity) async {
    final totalAsset = await assetPathEntity.assetCountAsync;
    final assetSize = totalAsset < size ? totalAsset : size;
    final assets =
        await assetPathEntity.getAssetListPaged(page: 0, size: assetSize);
    final assetPath =
        GalleryAssetPath(pathEntity: assetPathEntity, totalAsset: totalAsset);
    assetPath.assets.addAll(await Future.wait(assets.map(createGalleryAsset)));
    return assetPath;
  }

  Future<GalleryAsset> createGalleryAsset(AssetEntity entity) async {
    final asset = GalleryAsset(entity);
    await asset.initialize();
    return asset;
  }

  void dispose() {
    assetSelectedStream.dispose();
    galleryAssetUpdateNotifier.dispose();
    galleryVisible.dispose();
    stickerVisible.dispose();
  }
}

class GalleryAsset {
  final AssetEntity assetEntity;
  File? file;

  GalleryAsset(this.assetEntity);

  Future<void> initialize() async {
    file = await assetEntity.file;
  }
}

class GalleryAssetPath {
  List<GalleryAsset> assets = [];
  final int totalAsset;
  final AssetPathEntity? pathEntity;
  int currentPage = 0;

  GalleryAssetPath({this.pathEntity, this.totalAsset = 0});
}
