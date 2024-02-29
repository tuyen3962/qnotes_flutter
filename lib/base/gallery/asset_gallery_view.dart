import 'package:flutter/material.dart';
import 'package:flutter_persistent_keyboard_height/flutter_persistent_keyboard_height.dart';
import 'package:base_flutter_source/base/gallery/view/gallery_album_view.dart';
import 'package:base_flutter_source/base/gallery/gallery_manager.dart';
import 'package:base_flutter_source/config/theme/style/style_theme.dart';
import 'package:base_flutter_source/extension.dart';
import 'package:base_flutter_source/main.dart';
import 'package:base_flutter_source/utils/loading.dart';
import 'package:base_flutter_source/widget/default_image.dart';
import 'package:base_flutter_source/widget/list_vertical_item.dart';

import 'view/gallery_asset_view.dart';

class AssetGalleryView extends StatefulWidget {
  const AssetGalleryView({
    super.key,
    required this.galleryManager,
    required this.scrollController,
    required this.node,
  });

  final GalleryManager galleryManager;
  final ScrollController scrollController;
  final FocusNode node;

  @override
  State<AssetGalleryView> createState() => _AssetGalleryViewState();
}

class _AssetGalleryViewState extends State<AssetGalleryView>
    with TickerProviderStateMixin {
  late final galleryManager = widget.galleryManager;
  late AnimationController _controller;
  bool isInitAnimation = false;
  late Animation animation;
  late Animation<double> headerScaleAnim;
  late Animation<double> topScaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    headerScaleAnim = Tween<double>(begin: 0, end: 1).animate(_controller);
    topScaleAnim = Tween<double>(begin: 1, end: 0).animate(_controller);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final keyboardHeight = PersistentKeyboardHeight.of(context).keyboardHeight;
    if (!isInitAnimation && keyboardHeight > 0) {
      isInitAnimation = true;
      handleInLoading(() => Future.delayed(const Duration(milliseconds: 1000))
          .then((value) => animation = Tween<double>(
                  begin: PersistentKeyboardHeight.of(context).keyboardHeight,
                  end: MediaQuery.of(context).size.height)
              .animate(_controller)));
    }
  }

  @override
  void dispose() {
    galleryManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: galleryManager.galleryVisible,
      builder: (context, value, child) => Visibility(
        visible: value,
        child: buildGalleryView(),
      ),
    );
  }

  handleWhenScrolling(double offset) {
    if (_controller.status == AnimationStatus.completed) {
      if (widget.scrollController.offset < 400) {
        _controller.value += offset / 400;
      }
    } else if (widget.scrollController.offset <= 400) {
      _controller.value += offset / 400;
    }
  }

  handleWhenScrollEnd() {
    if (_controller.status == AnimationStatus.dismissed ||
        _controller.status == AnimationStatus.reverse ||
        _controller.status == AnimationStatus.forward) {
      if (_controller.value > 0.6) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
      return;
    }
    if (_controller.status == AnimationStatus.completed &&
        widget.scrollController.offset == 0) {
      _controller.reverse();
      return;
    }
  }

  buildGalleryView() {
    return ValueListenableBuilder(
      valueListenable: galleryManager.galleryAssetUpdateNotifier,
      builder: (context, value, child) => AnimatedBuilder(
        animation: animation,
        builder: (context, child) => Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: appTheme.whiteText,
            height: animation.value,
            width: double.infinity,
            child: Column(
              children: [
                SizeTransition(
                  sizeFactor: headerScaleAnim,
                  child: _buildHeaderGallery(),
                ),
                SizedBox(height: 8.h),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onPanUpdate: (details) =>
                        handleWhenScrolling(details.delta.dy * -1),
                    onPanCancel: handleWhenScrollEnd,
                    onPanEnd: (details) => handleWhenScrollEnd(),
                    child: SizedBox(
                      width: 100.w,
                      height: 8.h,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1000),
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Expanded(
                  child: NotificationListener(
                    onNotification: (notification) {
                      if (notification is ScrollEndNotification) {
                        handleWhenScrollEnd();
                      } else if (notification is ScrollUpdateNotification) {
                        handleWhenScrolling(notification.scrollDelta ?? 0);
                      }
                      return true;
                    },
                    child: ListVerticalItem<GalleryAsset>(
                      controller: widget.scrollController,
                      lineItemCount: 3,
                      items: galleryManager.galleryAssets,
                      paddingBetweenLine: 0,
                      paddingBetweenItem: 0,
                      itemBuilder: (index, asset) {
                        if (asset.file == null) {
                          return DefaultImage();
                        }
                        final index = galleryManager.indexSelectedItem(asset);
                        return GestureDetector(
                          onTap: () {
                            galleryManager.onSelectAsset(asset);
                          },
                          child: Stack(
                            children: [
                              GalleryAssetView(
                                  galleryAsset: asset, boxFit: BoxFit.cover),
                              Positioned(
                                top: 10,
                                right: 10,
                                child: index == -1
                                    ? _buildUnselectIcon()
                                    : _buildSelectIcon(index + 1),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildSelectIcon(int index) {
    return Container(
      width: 16.w,
      height: 16.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: appTheme.primaryColor,
      ),
      alignment: Alignment.center,
      child: Text(
        index.toString(),
        style: StyleThemeData.styleSize10Weight600(
            color: appTheme.whiteText, height: 1),
        textAlign: TextAlign.center,
      ),
    );
  }

  _buildUnselectIcon() {
    return Container(
      width: 16.w,
      height: 16.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: appTheme.whiteText),
        color: Colors.black.withOpacity(0.4),
      ),
      alignment: Alignment.center,
    );
  }

  _buildHeaderGallery() {
    return Stack(
      alignment: Alignment.center,
      children: [
        ValueListenableBuilder(
          valueListenable: galleryManager.totalAsset,
          builder: (context, val, child) => Row(
            children: [
              InkWell(
                onTap: () {
                  galleryManager.chanegGalleryVisible(false);
                  galleryManager.changeKeyboardVisibility(false);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Icon(Icons.arrow_back),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: _changeAssetAlbum,
                  child: Align(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('Tất cả',
                                style: StyleThemeData.styleSize14Weight600()),
                            SizedBox(width: 2.w),
                            Icon(Icons.keyboard_arrow_down_rounded, size: 24.h)
                          ],
                        ),
                        Text('$val Tổng ảnh',
                            style: StyleThemeData.styleSize12Weight400(
                                color: appTheme.textDesColor)),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Icon(Icons.settings, color: appTheme.transparentColor),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _changeAssetAlbum() async {
    final result = await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
      constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * 0.6,
          maxHeight: MediaQuery.of(context).size.height * 0.9),
      builder: (context) {
        return GalleryAlbumView(
          assetPaths: galleryManager.mapGalleryAsset.values.toList(),
        );
      },
    );
    if (result != null) {
      galleryManager.onChangeAssetPath(result);
    }
  }
}
