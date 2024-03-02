import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:qnotes_flutter/base/gallery/gallery_manager.dart';
import 'package:qnotes_flutter/config/theme/style/style_theme.dart';
import 'package:qnotes_flutter/extension.dart';
import 'package:qnotes_flutter/main.dart';

class GalleryAssetView extends StatelessWidget {
  const GalleryAssetView({
    super.key,
    required this.galleryAsset,
    this.size,
    this.boxFit = BoxFit.contain,
    this.radius = 0,
    this.showVideoDuration = true,
  });

  final GalleryAsset galleryAsset;
  final double? size;
  final BoxFit boxFit;
  final double radius;
  final bool showVideoDuration;

  @override
  Widget build(BuildContext context) {
    if (galleryAsset.assetEntity.mimeType == 'video/mp4' && showVideoDuration) {
      final duration = Duration(seconds: galleryAsset.assetEntity.duration);
      final minutes = duration.inMinutes;
      final second = duration.inSeconds - (minutes * 60);
      final minText = minutes < 10 ? '0$minutes' : minutes.toString();
      final secondText = second < 10 ? '0$second' : second.toString();
      return Stack(
        children: [
          _buildAssetImage(),
          Positioned(
            bottom: 0,
            right: 0,
            child: Padding(
              padding: padding(all: 8),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1000),
                  color: Colors.black.withOpacity(0.5),
                ),
                child: Padding(
                  padding: padding(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$minText:$secondText',
                        style: StyleThemeData.styleSize12Weight400(
                            color: appTheme.whiteText),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }
    return _buildAssetImage();
  }

  _buildAssetImage() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: appTheme.whiteText, width: 2),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Image(
          image: AssetEntityImageProvider(
            galleryAsset.assetEntity,
            isOriginal: false,
            thumbnailSize: const ThumbnailSize.square(100),
            thumbnailFormat: ThumbnailFormat.png,
          ),
          height: size ?? 125.w,
          width: size ?? 125.w,
          fit: boxFit,
        ),
      ),
    );
  }
}
