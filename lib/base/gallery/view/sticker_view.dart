import 'package:flutter/material.dart';
import 'package:qnotes_flutter/base/stream/base_stream_builder.dart';
import 'package:qnotes_flutter/base/stream/base_stream_controller.dart';
import 'package:qnotes_flutter/config/constant/app_config.dart';
import 'package:qnotes_flutter/config/model/sticker.dart';
import 'package:qnotes_flutter/config/repository/upload/iupload_repository.dart';
import 'package:qnotes_flutter/config/service/app_service.dart';
import 'package:qnotes_flutter/config/theme/style/style_theme.dart';
import 'package:qnotes_flutter/extension.dart';
import 'package:qnotes_flutter/main.dart';
import 'package:qnotes_flutter/widget/custom_network_image.dart';
import 'package:qnotes_flutter/widget/list_vertical_item.dart';

class StickerView extends StatefulWidget {
  const StickerView({super.key, this.onAddNewSticker});

  final void Function(String)? onAddNewSticker;

  @override
  State<StickerView> createState() => _StickerViewState();
}

class _StickerViewState extends State<StickerView>
    with AutomaticKeepAliveClientMixin {
  late IUploadRepository uploadRepository = locator.get();
  final stickerStreamCtrl = BaseStreamController<List<Sticker>>([]);
  final pageController = PageController();
  final currentPageIndex = ValueNotifier<int>(0);
  final isLoading = ValueNotifier(false);

  @override
  void initState() {
    initializeSticker();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    stickerStreamCtrl.dispose();
    super.dispose();
  }

  void initializeSticker() async {
    isLoading.value = true;
    final stickers = await uploadRepository.getListStickers();
    stickerStreamCtrl.value = stickers;
    isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BaseStreamBuilder<List<Sticker>>(
      controller: stickerStreamCtrl,
      builder: (value) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ValueListenableBuilder(
            valueListenable: currentPageIndex,
            builder: (context, page, child) => SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: value
                    .asMap()
                    .entries
                    .map((e) => GestureDetector(
                          onTap: () {
                            currentPageIndex.value = e.key;
                            pageController.animateToPage(e.key,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.bounceIn);
                          },
                          behavior: HitTestBehavior.opaque,
                          child: buildTabSticker(e.value,
                              isCurrentPage: e.key == page),
                        ))
                    .toList(),
              ),
            ),
          ),
          Expanded(
              child: ValueListenableBuilder(
            valueListenable: isLoading,
            builder: (context, loading, child) {
              if (loading) {
                return Center(child: CircularProgressIndicator());
              } else {
                return PageView.builder(
                  controller: pageController,
                  itemBuilder: (context, index) {
                    final sticker = value[index];
                    return ListVerticalItem<String>(
                      lineItemCount: 3,
                      items: sticker.stikcerImageIds ?? [],
                      divider: const SizedBox(),
                      itemBuilder: (index, item) {
                        final stickerImageUrl =
                            AppwirteStorageConfig.getImageLink(
                                sticker.bucketId ?? '', item);
                        return GestureDetector(
                          onTap: () {
                            if (widget.onAddNewSticker != null) {
                              widget.onAddNewSticker!(stickerImageUrl);
                            }
                          },
                          child: CustomNetworkImage(imageUrl: stickerImageUrl),
                        );
                      },
                    );
                  },
                );
              }
            },
          ))
        ],
      ),
    );
  }

  Widget buildTabSticker(Sticker sticker, {bool isCurrentPage = false}) {
    return Container(
      color: isCurrentPage ? appTheme.backgroundContainer : null,
      padding: padding(all: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomNetworkImage(
              imageUrl: AppwirteStorageConfig.getImageLink(
                  sticker.bucketId ?? '',
                  (sticker.stikcerImageIds ?? []).first),
              size: 20.w),
          SizedBox(width: 12.w),
          Text(sticker.name ?? '',
              style: StyleThemeData.styleSize14Weight400()),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
